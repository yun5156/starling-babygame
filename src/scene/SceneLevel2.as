package scene
{
	public class SceneLevel2 extends SceneBase
	{
		public function SceneLevel2()
		{
			super();
			numBox=Root.assets.createSprite("spr_level2");
			this.sceneID=SceneControl.SCENE_LEVEL_2;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}