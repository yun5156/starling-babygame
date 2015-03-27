package scene
{
	public class SceneLevel3 extends SceneBase
	{
		public function SceneLevel3()
		{
			super();
			numBox=Root.assets.createSprite("spr_level3");
			this.sceneID=SceneControl.SCENE_LEVEL_3;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}