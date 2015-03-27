package scene
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	
	import UI.Magnifying;
	import UI.Scoring;
	
	import events.EventConstant;
	
	import lzm.starling.gestures.MovedGestures;
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	
	public class FindNum
	{
		
		private const HOME_POINT:String="home_point";
		private const BROTHER:String="brother";
		private var currentScene:SceneBase;
		private var bgMusic:SoundChannel;
		private var hideNums:Vector.<Image>=new Vector.<Image>();
		
		public var currentHideNums:Vector.<Image>=new Vector.<Image>();
		
		private var bind:Dictionary=new Dictionary();
		private var tweenDuration:Number=1;
		private var bezierH:Number=300;
		private var movedGestures:MovedGestures;
		private var tapGestures:TapGestures;
		private var isDraging:Boolean=false;//是不是正在拖动
		
		private var winEffect:MovieClip;
		
		private var failFlag:Image;
		
		private var magnifying:Magnifying;
		private var magnifyingRect:Rectangle;
		
		public function FindNum(scene:SceneBase)
		{
			currentScene=scene;
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			
			TweenPlugin.activate([BezierPlugin,AutoAlphaPlugin]);
			
			tapGestures=new TapGestures(currentScene.numBox,onHideNumTap);
			tapGestures.maxDragDist=30;
			movedGestures=new MovedGestures(currentScene.numBox,onNumBoxMoved);
			movedGestures.minDist=tapGestures.maxDragDist;//
			
			currentScene.addEventListener(TouchEvent.TOUCH,onSceneTouch);
			
			currentScene.header.addEventListener(EventConstant.HINT,onHintTap);
			
			
			for (var i:int = 0; i < currentScene.numQuantity; i++) 
			{
				var _index:uint=i+1;
				var _hideNum:Image=currentScene.numBox.getChildByName("img_l"+currentScene.sceneID.substring(12)+"_num_"+_index) as Image;
				var _globalP:Point=currentScene.numBox.localToGlobal(new Point(_hideNum.x,_hideNum.y));//获取坐标从而将其提出一层
				currentScene.addChild(_hideNum);
				_hideNum.touchable=false;
				_hideNum.x=_globalP.x;
				_hideNum.y=_globalP.y;
				bind[_hideNum.name+HOME_POINT]=_globalP;//记录下初始位置
				var _answerNumber:Image=currentScene.answerBar.answerNums[i];
				bind[_hideNum.name+BROTHER]=_answerNumber;
				var _gloalP2:Point=currentScene.answerBar.bar.localToGlobal(new Point(_answerNumber.x,_answerNumber.y));
				bind[_answerNumber.name+HOME_POINT]=_gloalP2;
				hideNums.push(_hideNum);
				currentHideNums.push(_hideNum);
			}
			
			var effectAtlas:TextureAtlas=Root.assets.otherAssets.getTextureAtlas("winEffect");
			winEffect=new MovieClip(effectAtlas.getTextures("mc_win_star"),24);
			winEffect.pivotX=winEffect.width/2;
			winEffect.pivotY=winEffect.height/2;
			
			failFlag=Root.assets.createImage("img_fail");
			failFlag.touchable=false;
			failFlag.alpha=0;
			failFlag.pivotX=failFlag.width/2;
			failFlag.pivotY=failFlag.height/2;
			currentScene.addChild(failFlag);
			
			magnifying=new Magnifying(200,200,currentScene,0.8);
			magnifyingRect=new Rectangle(currentScene.x,currentScene.header.height,currentScene.numBox.width,currentScene.numBox.height-currentScene.header.height-currentScene.answerBar.height);
		}
		
		private function onSceneTouch(e:TouchEvent):void
		{
			var touch:Touch=e.getTouch(currentScene);
			if (touch&&touch.phase==TouchPhase.ENDED&&currentScene.getChildIndex(magnifying)>=0)//当手指提起的时候 
			{
				magnifying.removeFromParent(false);
			}
			
		}
		private function playWinEffect(_p:Point):void
		{
			currentScene.addChild(winEffect);
			currentScene.juggler.add(winEffect);
			winEffect.x=_p.x;
			winEffect.y=_p.y;
			currentScene.juggler.delayCall(function onComplete():void{
				winEffect.removeFromParent();
				currentScene.juggler.remove(winEffect);
			},1);
			
		}
		private function onHintTap(e:Event):void
		{
			// TODO Auto Generated method stub
			if (currentHideNums.length>0) 
			{
				var _num:Image=currentHideNums[0];
				findOne(_num);
			}
		}
		public function rest():void
		{
			currentHideNums.length=0;
			var len:uint=hideNums.length;
			for (var i:int = 0; i < len; i++) 
			{
				var _hideNum:Image=hideNums[i];
				var _homeP:Point=bind[_hideNum.name+HOME_POINT] as Point;
				
				_hideNum.x=_homeP.x;
				_hideNum.y=_homeP.y;
				_hideNum.visible=true;
				currentHideNums.push(_hideNum);
			}
			currentScene.answerBar.restAllNum();
			
		}
		private function findOne(num:Image):void
		{
			playWinEffect(new Point(num.x,num.y));//播放成功效果
			effectNum(num);
			var _index:uint=currentHideNums.indexOf(num);
			currentHideNums.splice(_index,1);
		}
		private function onHideNumTap(e:Touch):void
		{
			if (currentHideNums.length>0&&!isDraging) 
			{
				var _p:Point=e.getLocation(currentScene);
				/*var _shap:Quad=new Quad(10,10,0xff0000);
				currentScene.addChild(_shap);
				_shap.x=_p.x;
				_shap.y=_p.y;*/
				var _hideNum:Image=currentScene.hitTest(_p) as Image;
				if (_hideNum&&currentHideNums.indexOf(_hideNum)>=0) 
				{
					trace(_hideNum.mName,666666);
					findOne(_hideNum);
				}else
				{
					trace("fail");
					failFlag.alpha=1;
					failFlag.x=_p.x;
					failFlag.y=_p.y;
					TweenLite.to(failFlag,1,{autoAlpha:0});
					var _failSound:Sound=Root.assets.otherAssets.getSound("fail_1");
					_failSound.play();
					
					var _score:Number;//
					if (currentScene.scoringDevice.currentScore<Scoring.GAP) 
					{
						_score=0;
					}else
					{
						_score=-Scoring.GAP;
					}
					currentScene.dispatchEventWith(EventConstant.CHANGE_SCORE,true,_score);//通知控制器改变分数
				}
			}
			if (e.phase==TouchPhase.ENDED) 
			{
				isDraging=false;
			}
		}
		private function onNumBoxMoved(e:Touch):void
		{
			//trace("drag");
			
			if (currentScene.getChildIndex(magnifying)<0)
			{
				currentScene.addChild(magnifying);
				isDraging=true;
			}
			
			var p:Point=e.getLocation(currentScene);
			magnifying.x = p.x - magnifying.width+20;
			magnifying.y = p.y - magnifying.height+20;
			
			if (magnifying.x < magnifyingRect.x)
			{
				magnifying.x = magnifyingRect.x;
			}
			else if (magnifying.x > magnifyingRect.x + magnifyingRect.width - magnifying.width)
			{
				magnifying.x = magnifyingRect.x + magnifyingRect.width - magnifying.width;
			}
			if (magnifying.y < magnifyingRect.y)
			{
				magnifying.y = magnifyingRect.y;
			}
			else if (magnifying.y > magnifyingRect.y + magnifyingRect.height - magnifying.height)
			{
				magnifying.y = magnifyingRect.y + magnifyingRect.height - magnifying.height;
			}
			
			/////////
			magnifying.working();
		}
		private function effectNum(num:Image):void
		{
			var _winSound:Sound=Root.assets.otherAssets.getSound("win_0");
			_winSound.play();
			
			var _answerNumber:Image=bind[num.name+BROTHER] as Image;
			var _endPoint:Point=bind[_answerNumber.name+HOME_POINT] as Point;
			var timeline:TimelineLite=new TimelineLite({onComplete:effectNumComplete,onCompleteParams:[num,_answerNumber]});
			var _scale:Number=1.5;
			timeline.add(TweenLite.to(num,0.2,{scaleX:_scale,scaleY:_scale}));
			timeline.add(TweenLite.to(num,0.2,{scaleX:1,scaleY:1}));
			timeline.add(TweenLite.to(num,0.2,{scaleX:_scale,scaleY:_scale}));
			timeline.add(TweenLite.to(num,0.2,{scaleX:1,scaleY:1}));
			timeline.add(TweenLite.to(num,0.2,{scaleX:_scale,scaleY:_scale}));
			timeline.add(TweenMax.to(num,1.5, {scaleX:1,scaleY:1,bezier:{type:"soft", autoRotate:false, values:[{x:num.x, y:num.y-bezierH}, {x:_endPoint.x, y:_endPoint.y}]},ease:Sine.easeOut}));
			timeline.play();
			
			
		}
		private function effectNumComplete(... args):void
		{
			var _hideNum:Image=args[0] as Image;
			var	_answerNumber:Image=args[1] as Image;
			_hideNum.visible=false;
			_answerNumber.alpha=1;
			_answerNumber.color=0xffff00;
			var _score:Number=Scoring.GAP+10*(hideNums.length-currentHideNums.length);//
			currentScene.dispatchEventWith(EventConstant.CHANGE_SCORE,true,_score);//通知控制器改变分数
		}
	}
}