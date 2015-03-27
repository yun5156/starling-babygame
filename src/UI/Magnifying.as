package UI
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.textures.RenderTexture;
	
	public class Magnifying extends Sprite
	{
		private var _drawImage:Image;
		private var _magnifyingScale:Number=0.8;
		//private var _magnifyingRect:Rectangle;
		private var _magnifyingTexture:RenderTexture;
		private var _sourceDisplay:DisplayObject;
		
		private var _pixelMask:PixelMaskDisplayObject;
		public function Magnifying(_width:uint,_height:uint,_src:DisplayObject,_scale:Number)
		{
			_sourceDisplay=_src;
			_magnifyingScale=_scale;
			
			_magnifyingTexture=new RenderTexture(_width,_height,false);
			_drawImage=new Image(_magnifyingTexture);
			//addChild(_drawImage);
			
			addMask();
			
			//_magnifyingRect=new Rectangle(_src.x,_src.y,_src.width,_src.height);
			this.touchGroup=true;
			this.touchable=false;
			
		}
		private function addMask():void
		{
			//绘制放大镜的形状
			var _shape:Shape=new Shape();
			_shape.graphics.beginFill(0xffffff);
			_shape.graphics.drawEllipse(_drawImage.x,_drawImage.y,_drawImage.width,_drawImage.height);
			_shape.graphics.endFill();
			
			var _maskBD:BitmapData=new BitmapData(_drawImage.width,_drawImage.height,true,0);
			_maskBD.draw(_shape);
			var _maskImg:Image=Image.fromBitmap(new Bitmap(_maskBD));
			addChild(_maskImg);
			
			_pixelMask=new PixelMaskDisplayObject();
			addChild(_pixelMask);
			_pixelMask.addChild(_drawImage);
			_pixelMask.mask=_maskImg;
			
		}
		public function working(/*_p:Point*/):void
		{
			/*
			this.x = _p.x - this.width;
			this.y = _p.y - this.height;
			
			if (this.x < _magnifyingRect.x)
			{
				this.x = _magnifyingRect.x;
			}
			else if (this.x > _magnifyingRect.x + _magnifyingRect.width - this.width)
			{
				this.x = _magnifyingRect.x + _magnifyingRect.width - this.width;
			}
			if (this.y < _magnifyingRect.y)
			{
				this.y = _magnifyingRect.y;
			}
			else if (this.y > _magnifyingRect.y + _magnifyingRect.height - this.height)
			{
				this.y = _magnifyingRect.y + _magnifyingRect.height - this.height;
			}
			*/
			var matrix:Matrix = new Matrix();
			//偏移量根据touch点的变化而变化，当touch点越往右，偏移量就越往左,为了能在限定范围内完全显示，需要将放大部分也根据
			//touch点以	(display.width*scale) * (mask.x/(display.width-mask.width))  这个比例来增加偏移。 	
			var offsetX:Number = -this.x - (_sourceDisplay.width * _magnifyingScale) * (this.x / (_sourceDisplay.width - this.width));
			var offsetY:Number = -this.y - (_sourceDisplay.height * _magnifyingScale) * (this.y / (_sourceDisplay.height - this.height));
			
			matrix.createBox(1 + _magnifyingScale, 1 + _magnifyingScale, 0, offsetX, offsetY);
			_magnifyingTexture.draw(_sourceDisplay, matrix);
		}
		/*public function set magnifyingRect(_rect:Rectangle):void 
		{
			_magnifyingRect=_rect;
		}*/
	}
}