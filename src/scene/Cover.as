package scene 
{
	
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.geom.Point;
	import flash.media.Sound;
	
	import events.EventConstant;
	
	import lzm.starling.gestures.TapGestures;
	
	import media.SoundControl;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	/**
	 * ...
	 * @author jujube
	 */
	public class Cover extends Sprite 
	{
		private var content:Sprite;
		public static var bgMusic:Sound;
		private var btnPlay:Button;
		private var btnHow:Button;
		private var howToPlay:Sprite;
		private var howToPlayClose:Image;
		public function Cover() 
		{
			content=Root.assets.createSprite("spr_cover");
			addChild(content);
			
			var _btnUpImg:Image=Root.assets.createImage("img_cover_play_upSkin");
			//var btnDownImg:Image=Root.assets.createImage("img_cover_play_downSkin");
			btnPlay=new Button(_btnUpImg.texture,"");
			content.addChild(btnPlay);
			btnPlay.x=222;
			btnPlay.y=486;
			btnPlay.addEventListener(Event.TRIGGERED,onBtnPlay);
			
			var _btnHowSkin:Image=Root.assets.createImage("img_cover_btnHow");
			btnHow=new Button(_btnHowSkin.texture);
			content.addChild(btnHow);
			btnHow.x=92;
			btnHow.y=650;
			btnHow.addEventListener(Event.TRIGGERED,onBtnHow);
			
			howToPlay=Root.assets.createSprite("spr_howtoplay");
			howToPlayClose=howToPlay.getChildByName("img_btn_close") as Image;
			howToPlay.visible=false;
			howToPlay.alpha=0;
			addChild(howToPlay);
			howToPlay.x=110;
			howToPlay.y=10;
			var _tap:TapGestures=new TapGestures(howToPlayClose,closeHowToPlay);
			
			//var tree:SwfMovieClip=content.getChildByName("mc_tree_0") as SwfMovieClip;
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			var i:uint=Math.floor(Math.random()*6);
			bgMusic=Root.assets.otherAssets.getSound("bg_"+i);
			
			TweenPlugin.activate([AutoAlphaPlugin]);
		}
		
		private function closeHowToPlay(e:Touch=null):void
		{
			btnHow.touchable=true;
			
			TweenLite.to(btnHow,0.2,{autoAlpha:1});
			TweenLite.to(howToPlay,0.5,{autoAlpha:0});
		}
		
		private function onBtnHow(e:Event):void
		{
			btnHow.touchable=false;
			
			TweenLite.to(btnHow,0.2,{autoAlpha:0});
			TweenLite.to(howToPlay,0.5,{autoAlpha:1});
			
		}
		
		private function onAddedToStage(e:Event):void
		{
			SoundControl.getInstance().playSound(bgMusic,int.MAX_VALUE,false);
		}
		
		private function onBtnPlay(e:Event):void
		{
			// TODO Auto Generated method stub
			dispatchEventWith(EventConstant.TO_LIST,true);
		}
		
	}

}