package scene
{
	public class SceneLevel6 extends SceneBase
	{
		public function SceneLevel6()
		{
			super();
			numBox=Root.assets.createSprite("spr_level6");
			this.sceneID=SceneControl.SCENE_LEVEL_6;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}