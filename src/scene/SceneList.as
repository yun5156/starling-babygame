package scene
{
	import events.EventConstant;
	
	import lzm.starling.gestures.TapGestures;
	
	import media.SoundControl;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	
	public class SceneList extends Sprite
	{
		public var content:Sprite;
		private var btnBack:Button; 
		
		
		private var sound0:Button
		private var sound1:Button;
		public function SceneList()
		{
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			content=Root.assets.createSprite("spr_levellist");
			addChild(content);
			
			
			
			var btnImg0:Image=Root.assets.createImage("img_btn_back_0");
			var btnImg1:Image=Root.assets.createImage("img_btn_back_1");
			btnBack=new Button(btnImg0.texture,"",btnImg1.texture);
			addChild(btnBack);
			btnBack.x=30;
			btnBack.y=30;
			btnBack.addEventListener(Event.TRIGGERED,onBtnBack);
			
			
			var sound0Skin:Image=Root.assets.createImage("img_sound_0");
			var sound1Skin:Image=Root.assets.createImage("img_sound_1");
			sound0=new Button(sound0Skin.texture,"",sound0Skin.texture);
			sound1=new Button(sound1Skin.texture,"",sound1Skin.texture);
			addChild(sound0);
			sound0.addEventListener(Event.TRIGGERED,onSoundClick);
			sound1.addEventListener(Event.TRIGGERED,onSoundClick);
			sound0.x=content.width-30-sound0.width;
			sound0.y=30;
			sound1.x=sound0.x;
			sound1.y=sound0.y;
			
			var len:uint=content.numChildren;
			for (var j:int = 0; j < len; j++) 
			{
				var _child:DisplayObject=content.getChildAt(j) as DisplayObject;
				
				if (_child is Image&&_child.name.substr(0,12)=="img_levelbtn") 
				{
					var imgTap:TapGestures=new TapGestures(_child,onImgTap);
				}else
				{
					_child.touchable=false;
				}
			}
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onSoundClick(e:Event):void
		{
			var btn:Button=e.currentTarget as Button;
			if (btn==sound0) 
			{
				removeChild(sound0);
				addChild(sound1);
				SoundControl.getInstance().pauseSound();
			}
			else 
			{
				removeChild(sound1);
				addChild(sound0);
				SoundControl.getInstance().playSound(SoundControl.getInstance().currentSound,int.MAX_VALUE,false);
			}
		}
		
		private function onAddedToStage(e:Event):void
		{
			SoundControl.getInstance().playSound(SoundControl.getInstance().currentSound,int.MAX_VALUE,false);
		}
		
		private function onImgTap(e:Touch):void
		{
			var img:Image=e.target as Image;
			var data:Object=img.name.split("_")[2];
			//trace(img.name,data);
			dispatchEventWith(EventConstant.TO_SCENE,true,data);
		}
		
		private function onBtnBack(e:Event):void
		{
			this.dispatchEventWith(EventConstant.TO_COVER,true);
		}
	}
}