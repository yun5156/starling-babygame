package scene
{
	public class SceneLevel7 extends SceneBase
	{
		public function SceneLevel7()
		{
			super();
			numBox=Root.assets.createSprite("spr_level7");
			this.sceneID=SceneControl.SCENE_LEVEL_7;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}