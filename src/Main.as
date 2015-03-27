package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import media.SoundControl;
	
	import pl.mateuszmackowiak.nativeANE.dialogs.NativeAlertDialog;
	import pl.mateuszmackowiak.nativeANE.events.NativeDialogEvent;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	public class Main extends Sprite
	{
		[Embed(source="../system/background.png")]
		public static var Background:Class;
		
		private var _starling:Starling;
		private var _soundIsPlaying:Boolean;
		
		public function Main()
		{
			stage.color=0xffffff;
			
			var _viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.SHOW_ALL);
			
			var _startupImage:Bitmap = new Background();
			_startupImage.smoothing=true;
			_startupImage.x=_viewPort.x;
			_startupImage.y=_viewPort.y;
			_startupImage.width=_viewPort.width;
			_startupImage.height=_viewPort.height;
			this.addChild(_startupImage);
			
			Starling.handleLostContext=true;
			
			_starling = new Starling(Root, stage,_viewPort);
			_starling.simulateMultitouch  = false;
			_starling.enableErrorChecking = false;
			//_starling.showStats = true;
			 
			_starling.addEventListener("rootCreated", function():void
			{
				removeChild(_startupImage);
				var _root:Root = _starling.root as Root;
				_root.init(_startupImage);
				_root.width=_viewPort.width;
				_root.height=_viewPort.height;
				
				_starling.start();
			});
			//
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;//屏幕常亮
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,onActivate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,onDeActivate);
			this.stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN,onFlashKeyboard);
			//_starling.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN,onStarlingKeyboard);
		}
		private function onFlashKeyboard(e:flash.events.KeyboardEvent):void 
		{
			if (e.keyCode == flash.ui.Keyboard.BACK)
			{
				e.preventDefault();
				e.stopPropagation();
				NativeAlertDialog.showAlert("是否要退出？", "", Vector.<String>(["退出", "取消"]), onDialog, false);
			}
		}
		private function onDialog(e:NativeDialogEvent):void
		{
			if (e.index == "0") 
			{
				NativeApplication.nativeApplication.exit();
			}
		}
		private function onActivate(e:Event):void
		{
			_starling.start();
			if (_soundIsPlaying) 
			{
				SoundControl.getInstance().playSound(SoundControl.getInstance().currentSound,int.MAX_VALUE,false);
			}
		}
		private function onDeActivate(e:Event):void
		{
			_starling.stop(true);
			_soundIsPlaying=SoundControl.getInstance().isPlaying;
			SoundControl.getInstance().pauseSound();
		}
	}
}