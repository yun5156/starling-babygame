package UI
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class Hint extends Sprite
	{
		private const totalHints:uint=3;//一共提示次数
		private var icons:Vector.<Image>=new Vector.<Image>();
		private var currentIcons:Vector.<Image>=new Vector.<Image>();
		private const iconGap:uint=20;//间隔
		public function Hint()
		{
			for (var i:int = 0; i < totalHints; i++) 
			{
				var icon:Image=new Image(Root.assets.createImage("img_tishi_icon").texture);
				icon.x=(icon.width+iconGap)*i;
				icons.push(icon);	
			}
			
			var bg:Quad=new Quad((icon.width+iconGap)*totalHints,icon.height);
			bg.alpha=0;
			addChild(bg);//增加有效点击区域			
		}
		
		public function rest():void
		{
			// TODO Auto Generated method stub
			currentIcons.length=0;
			var len:uint=icons.length;
			for (var i:int = 0; i < len; i++) 
			{
				addChild(icons[i]);
				currentIcons.push(icons[i]);
			}
			
		}
		public function expend():Boolean
		{
			if (currentIcons.length>0) 
			{
				removeChild(currentIcons[0]);
				currentIcons.shift();
				return true;
			}
			else 
			{
				return false;
			}
		}
		
	}
}