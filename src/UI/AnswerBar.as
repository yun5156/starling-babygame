package UI
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class AnswerBar extends Sprite
	{
		public var answerNums:Vector.<Image>=new Vector.<Image>();//数字
		public var bar:Sprite;
		private const disabledAlpha:Number=0.2;
		public function AnswerBar()
		{
			super();
			
			buildUI();
		}
		
		public function restAllNum():void
		{
			var len:uint=answerNums.length;
			for (var i:int = 0; i < len; i++) 
			{
				answerNums[i].alpha=disabledAlpha;
				answerNums[i].color=0xffffff;
			}
			
		}
		private function buildUI():void
		{
			// TODO Auto Generated method stub
			bar=Root.assets.createSprite("spr_answer_bar");
			addChild(bar);
			for (var i:int = 1; i <= 20; i++) 
			{
				var imgNum:Image=bar.getChildByName("img_ans_"+i) as Image;
				answerNums.push(imgNum);
				
			}
			restAllNum();
		}
	}
}