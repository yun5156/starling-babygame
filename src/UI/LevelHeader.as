package UI
{
	
	import events.EventConstant;
	
	import lzm.starling.gestures.TapGestures;
	import lzm.starling.swf.SwfAssetManager;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.text.TextField;
	
	public class LevelHeader extends Sprite
	{
		private var assets:SwfAssetManager;
		private var bg:Image;
		private var hint:Hint;
		private var pause:Button;
		private var star:Image;
		public var txtScoring:TextField;
		
		
		public function LevelHeader()
		{
			assets=Root.assets;
			buildUI();
			addfunction();
		}
		
		
		private function buildUI():void
		{
			// TODO Auto Generated method stub
			bg=assets.createImage("img_header_bg");
			addChild(bg);
			
			star=assets.createImage("img_star");
			addChild(star);
			star.x=bg.width/8;
			star.y=bg.height/2-star.height/2;
			
			var _swfheader:Sprite=Root.assets.createSprite("spr_header");
			txtScoring=_swfheader.getChildByName("txt_header_score") as TextField;
			addChild(txtScoring);
			txtScoring.x=star.x+star.width+20;
			
			
			
			hint=new Hint();
			addChild(hint);
			hint.x=bg.width-bg.width/3;
			hint.y=bg.height/2-hint.height/2;
			hint.rest();
			
			
			
			var pauseButtonUPSkin:Image=assets.createImage("img_btn_pause");
			pause=new Button(pauseButtonUPSkin.texture);
			
			addChild(pause);
			pause.x=bg.width-pause.width-50;
			pause.y=bg.height/2-pause.height/2;
			
			
		}
		
		private function addfunction():void
		{
			// TODO Auto Generated method stub
			var tapHint:TapGestures=new TapGestures(hint,onHintTap);
			pause.addEventListener(Event.TRIGGERED,onPauseClick);
			
		}
		
		
		private function onHintTap(e:Touch):void
		{
			var b:Boolean=hint.expend();
			trace("提示:",b);
			dispatchEventWith(EventConstant.HINT,true);
		}
		private function onPauseClick(e:Event):void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(EventConstant.PAUSE,true);
		}
		
	}
}