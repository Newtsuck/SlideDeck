package utils 
{
	import loom2d.display.Image;
	import loom2d.display.Stage;
	import loom2d.display.TextAlign;
	import loom2d.display.TextFormat;
	import loom2d.math.Point;
	
	/**
	 * A slide type that will render a grid of images, either all at once or one at a time
	 * 
	 * @author Joshua Evans
	 */
	public class ImageSlide extends BaseSlide
	{
		//********** CONSTRUCTOR **********//
		/**
		 * The constructor simply takes the stage the slide will be rendered on
		 * 
		 * @param	s	The stage the slide will be rendered on
		 */
		public function ImageSlide(s:Stage) 
		{
			super(s);
		}
		
		//********** CONSTANTS, VARIABLES, AND ACCESSORS **********//
		/**
		 * This getter allows for backwards compatibiliy of the `imageBuffer` variable. `_itemBuffer` should be used instead.
		 */
		protected function get imageBuffer():Number
		{
			trace("WARNING: Using depreciated variable `imageBuffer`, please us `_imageBuffer` instead");
			
			return this._itemBuffer;
		}
		
		/**
		 * This setter allows for backwards compatibiliy of the `imageBuffer` variable. `_itemBuffer` should be used instead.
		 */
		protected function set imageBuffer(value:Number):void 
		{
			trace("WARNING: Using depreciated variable `imageBuffer`, please us `_imageBuffer` instead");
			
			this._itemBuffer = value; 
		}
		
		/**
		 * The vector of images that will be rendered on the screen
		 */
		protected var _images:Vector.<Image> = new Vector.<Image>();
		
		/**
		 * This getter allows for backwards compatibiliy of the `images` variable. `_images` should be used instead.
		 */
		protected function get images():Vector.<Image> 
		{ 
			trace("WARNING: Using depreciated variable `images`, please us `_images` instead");	
			
			return this._images; 		
		}
		
		/**
		 * This setter allows for backwards compatibiliy of the `images` variable. `_images` should be used instead.
		 */
		protected function set images(value:Vector.<Image>):void
		{
			trace("WARNING: Using depreciated variable `images`, please us `_images` instead");
			
			this._images = value;
		}
		
		/**
		 * Where the available rendering space for images begins (taking into account the buffers and title size)
		 */
		private var _availableSpaceAnchor:Point;
		
		/**
		 * The number of columns of images
		 */
		private var _columns:Number = 0;
		
		/**
		 * Every image in this image grid is square, this value represents the image width and height
		 */
		private var _imageSize:Number = 0;
		
		/**
		 * The number of images that have been rendered so far
		 */
		private var _imagesRendered:Number = 0;
		
		/**
		 * The number of rows of images
		 */
		private var _rows:Number = 0;
		
		//********** PUBLIC FUNCTIONS **********//
		// No public functions
		
		//********** PROTECTED FUNCTIONS **********//
		/**
		 * When cleaning the image slide, the images need to be removed from the stage as well
		 */
		override protected function customClean():void
		{
			for (var i:Number = 0; i < this._images.length; i++)
			{
				if (this._stage.contains(this._images[i]))
				{
					this._stage.removeChild(this._images[i]);
				}
			}
		}
		
		/**
		 * The render action for the image slide will render a title, and then images
		 */
		override protected function renderAction():void
		{
			if (this._hasRendered == false)
			{
				// Make sure the number of list items that have been rendered is marked as 0
				this._imagesRendered = 0;
				
				// Calculate the number of columns and rows for our images
				// We try to keep things as square as possible, so we use the upper bound of the square root of the number of images to get the columns
				this._columns = Math.ceil(Math.sqrt(this._images.length));
				
				// The number of rows is determined by determining how many rows our images will fill, based on the number of columns
				this._rows = Math.ceil(this._images.length / this._columns);
								
				// Instantly render the title the first time a render action is made
				// Apply the text format for the title
				var format:TextFormat = new TextFormat();
				format.color = 0x000000;
				format.size = this._stage.nativeStageHeight * this._titleHeight;
				format.align = TextAlign.CENTER | TextAlign.TOP;
				this._shape.graphics.textFormat(format);
				
				// Draw the title so that it is at the top of the stage
				var titleY = this._itemBuffer;
				this._shape.graphics.drawTextLine(this._stage.nativeStageWidth / 2, titleY, this._title);
				
				// Determine the available space anchor
				this._availableSpaceAnchor = new Point(0 + this.getPixelImageBufferWidth(), 0 + format.size + this.getPixelImageBufferHeight());
				
				// Determine the width and height of the images
				// First determine the actual amount of screen space available for images, taking the title and buffer into account
				var availableSpaceHeight:Number = this._stage.nativeStageHeight - format.size - this.getPixelImageBufferHeight() * 2;
				var availableSpaceWidth:Number = this._stage.nativeStageWidth - this.getPixelImageBufferWidth() * 2;
				
				// Use the lesser of the 2 available space values to do further calculations
				var lesserSpaceDimension:Number;
				var lesserSpaceGridDimension:Number;
				if (availableSpaceHeight < availableSpaceWidth)
				{
					lesserSpaceDimension = availableSpaceHeight;
					lesserSpaceGridDimension = _rows;
				}
				else
				{
					lesserSpaceDimension = availableSpaceWidth;
					lesserSpaceGridDimension = _columns;
				}
				
				// Calculate the dimensions of the image!
				this._imageSize = Math.floor(((lesserSpaceDimension / lesserSpaceGridDimension) - (this.getPixelImageBufferHeight() * (lesserSpaceGridDimension - 1))));
				
				// This slide hasn't rendered anything, to calculate the number of renders we will need to do
				if (this._renderInstantly)
				{
					this.setTotalRenders(1);
					
					// If this slide is supposed to render instantly, just go ahead and do that
					for (var i:Number; i < this._images.length; i++)
					{
						this.renderNextImage();
					}
				}
				else
				{
					this.setTotalRenders(1 + this._images.length);
				}
			}
			else
			{
				// If this slide has already rendered once, render the next list item
				renderNextImage();
			}
			
		}
		
		//********** PRIVATE FUNCTIONS **********//
		/**
		 * Renders the next image
		 * 
		 * @return Whether or not there are any images to render
		 */
		private function renderNextImage():Boolean
		{
			if (this._imagesRendered == this._images.length) return false;
			
			// Determine the column and row of this particular item
			var columnNumber = this._imagesRendered % this._columns;
			var rowNumber = Math.floor(this._imagesRendered / this._columns);
			
			// Determine the x value of this image
			var imageX:Number = this._availableSpaceAnchor.x + columnNumber * this._imageSize + this.getPixelImageBufferWidth() * (columnNumber);
			
			// Determine the y value of this image
			var imageY:Number = this._availableSpaceAnchor.y + rowNumber * this._imageSize + this.getPixelImageBufferHeight() * (rowNumber);
			
			// Render the image!
			this._images[this._imagesRendered].width = this._imageSize;
			this._images[this._imagesRendered].height = this._imageSize;
			this._images[this._imagesRendered].x = imageX;
			this._images[this._imagesRendered].y = imageY;
			this._stage.addChild(this._images[this._imagesRendered]);
			
			this._imagesRendered++;
			
			return true;
		}
		
		/**
		 * Helper function takes the image buffer percentage value and uses it to calculate the pixel value of the buffer for dealing with vertical calculations
		 * 
		 * @return The pixel value of the vertical buffer
		 */
		private function getPixelImageBufferHeight():Number
		{
			return this._itemBuffer * this._stage.nativeStageHeight;
		}
		
		/**
		 * Helper function takes the image buffer percentage value and uses it to calculate the pixel value of the buffer for dealing with horizontal calculations
		 * 
		 * @return The pixel value of the horizontal buffer
		 */
		private function getPixelImageBufferWidth():Number
		{
			return this._itemBuffer * this._stage.nativeStageWidth;
		}
	}
}