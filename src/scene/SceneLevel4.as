package scene
{
	public class SceneLevel4 extends SceneBase
	{
		public function SceneLevel4()
		{
			super();
			numBox=Root.assets.createSprite("spr_level4");
			this.sceneID=SceneControl.SCENE_LEVEL_4;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
	}
}