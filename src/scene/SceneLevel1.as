package scene
{
	import starling.display.Sprite;
	
	public class SceneLevel1 extends SceneBase
	{
		public function SceneLevel1()
		{
			super();
			numBox=Root.assets.createSprite("spr_level1");
			this.sceneID=SceneControl.SCENE_LEVEL_1;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}