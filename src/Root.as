package
{
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.OnCompleteRenderPlugin;
	
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	import flash.system.System;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.SwfAssetManager;
	
	import scene.SceneControl;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author jujube
	 */
	public class Root extends Sprite
	{
		public static var assets:SwfAssetManager;
		private var sceneControl:SceneControl;
		private var progressBar:MyProgressBar;
		private var backgroundImage:Image;
		public function Root()
		{
			// nothing to do here -- Startup will call "start" immediately.
		}
		public function init(_background:Bitmap):void
		{
			
			backgroundImage=new Image(Texture.fromBitmap(_background));
			backgroundImage.smoothing=TextureSmoothing.TRILINEAR;
			addChild(backgroundImage);
			
			//使用starlingSWF素材
			Swf.init(this);
						
			assets = new SwfAssetManager();
			var appDir:File = File.applicationDirectory;
			assets.verbose=Capabilities.isDebugger;
			assets.enqueue("find_numbers",[appDir.resolvePath("../assets/find_numbers/")]);
			assets.enqueueOtherAssets(appDir.resolvePath("../assets/other"));
			
			TweenLite.to(backgroundImage,0.3,{delay:2,alpha:0,onComplete:showProgressBar});
		}
		private function showProgressBar():void
		{
			//显示载入进度
			progressBar = new MyProgressBar(backgroundImage.width / 3, 50);
			progressBar.x = (backgroundImage.width - progressBar.width) / 2;
			progressBar.y = backgroundImage.height/2;
			addChild(progressBar);
			assets.loadQueue(onProgress);
		}
		private function onProgress(ratio:Number):void
		{
			progressBar.ratio = ratio;
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
						{
							progressBar.removeFromParent(true);
							backgroundImage.removeFromParent(true);
							start();
							System.gc();
						
						}, 0.5);
		}
		
		private function start():void
		{
			//trace(stage.stageWidth,stage.stageHeight);
			sceneControl=new SceneControl(this);
			sceneControl.showScene(SceneControl.SCENE_COVER);
			
		}
	}

}