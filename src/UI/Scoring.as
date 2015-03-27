//计分牌
package UI
{
	import starling.text.TextField;
	
	public class Scoring
	{
		public static var GAP:uint=30;//分数基数 
		private var scorePlate:TextField;
		public var currentScore:Number=0;
		public function Scoring(txt:TextField)
		{
			scorePlate=txt;
		}
		public function changeScoring(_number:Object):void
		{
			if (_number is Number) 
			{
				currentScore+=_number;
			}else
			{
				currentScore=0;
			}
			scorePlate.text=String(currentScore);
		}
	}
}