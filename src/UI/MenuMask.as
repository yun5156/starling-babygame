package UI
{
	import events.EventConstant;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MenuMask extends Sprite
	{
		private var bg:Quad;
		private var btnRest:Button;
		private var btnBack:Button;
		private var btnPlay:Button;
		private var dogIcon:Image;
		public function MenuMask()
		{
			 
			buildUI();
		}
		private function buildUI():void
		{
			bg=new Quad(1280,800,0x000000);
			bg.alpha=0.85;
			addChild(bg);
			
			var btnRestSkin0:Texture=Root.assets.createImage("img_btn_restart_0").texture;
			var btnRestSkin1:Texture=Root.assets.createImage("img_btn_restart_1").texture;
			btnRest=new Button(btnRestSkin0,"",btnRestSkin1);
			addChild(btnRest);
			btnRest.addEventListener(Event.TRIGGERED,onBtnRest);
			
			var btnPlaySkin0:Texture=Root.assets.createImage("img_btn_play_0").texture;
			var btnPlaySkin1:Texture=Root.assets.createImage("img_btn_play_1").texture;
			btnPlay=new Button(btnPlaySkin0,"",btnPlaySkin1);
			addChild(btnPlay);
			btnPlay.addEventListener(Event.TRIGGERED,onBtnPlay);
			
			var btnBackSkin0:Texture=Root.assets.createImage("img_btn_back_0").texture;
			var btnBackSkin1:Texture=Root.assets.createImage("img_btn_back_1").texture;
			btnBack=new Button(btnBackSkin0,"",btnBackSkin1);
			addChild(btnBack);
			btnBack.addEventListener(Event.TRIGGERED,onBtnBack);
			
			dogIcon=Root.assets.createImage("img_tip_dog");
			addChild(dogIcon);
			
			dogIcon.x=bg.width/2-dogIcon.width/2;
			dogIcon.y=bg.height/6;
			
			btnPlay.y=dogIcon.y+dogIcon.height+80;
			btnPlay.x=bg.width/2-btnPlay.width/2;
			btnBack.x=btnPlay.x-150;
			btnBack.y=btnPlay.y
			btnRest.x=btnPlay.x+150;
			btnRest.y=btnPlay.y;
			
		}
		
		private function onBtnBack(e:Event):void
		{
			trace(e.currentTarget);
			this.dispatchEventWith(EventConstant.TO_LIST,true);
		}
		
		private function onBtnPlay(e:Event):void
		{
			trace(e.currentTarget);
			this.dispatchEventWith(EventConstant.PLAY,true);
		}
		
		private function onBtnRest(e:Event):void
		{
			trace(e.currentTarget);
			this.dispatchEventWith(EventConstant.REST,true);
		}
		
	}
}