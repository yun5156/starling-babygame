package scene
{
	public class SceneLevel5 extends SceneBase
	{
		public function SceneLevel5()
		{
			super();
			numBox=Root.assets.createSprite("spr_level5");
			this.sceneID=SceneControl.SCENE_LEVEL_5;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}