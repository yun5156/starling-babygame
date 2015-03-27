package scene
{
	import flash.media.Sound;
	
	import UI.AnswerBar;
	import UI.LevelHeader;
	import UI.Scoring;
	
	import media.SoundControl;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class SceneBase extends Sprite
	{
		public var juggler:Juggler=new Juggler();
		public var header:LevelHeader=new LevelHeader();
		public var answerBar:AnswerBar=new AnswerBar();
		public var numBox:Sprite=new Sprite();
		
		public var scoringDevice:Scoring; 
		public var sceneID:String="";
		public const numQuantity:uint=20;
		public var findNum:FindNum;
		public var bgMusic:Sound;//背景音乐
		public function SceneBase()
		{
		}
		public function buildUI():void
		{
			addChild(numBox);
			addChild(header);
			addChild(answerBar);
			answerBar.y=numBox.height-answerBar.height;
			scoringDevice=new Scoring(header.txtScoring);
			animation(true);
			this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(E:Event):void
		{
			if (bgMusic) 
			{
				SoundControl.getInstance().playSound(bgMusic,int.MAX_VALUE,true);
			}else
			{
				SoundControl.getInstance().playSound(SoundControl.getInstance().currentSound,int.MAX_VALUE,true);
			}
			
		}
		public function animation(b:Boolean):void
		{
			if (b) 
			{
				Starling.juggler.add(juggler);
			}
			else 
			{
				Starling.juggler.remove(juggler);
			}
		}
	}
}