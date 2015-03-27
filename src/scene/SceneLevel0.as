package scene
{
	
	//import starling.display.Image;
	
	public class SceneLevel0 extends SceneBase
	{
		//private var imgNums:Vector.<Image>=new Vector.<Image>();
		
		public function SceneLevel0()
		{
			super();
			numBox=Root.assets.createSprite("spr_level0");
			this.sceneID=SceneControl.SCENE_LEVEL_0;
			this.buildUI();
			this.findNum=new FindNum(this);
		}
		
	}
}