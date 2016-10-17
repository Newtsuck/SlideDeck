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
		/// CONSTRUCTOR
		/**
		 * The constructor simply takes the stage the slide will be rendered on
		 * 
		 * @param	s	The stage the slide will be rendered on
		 */
		public function ImageSlide(s:Stage) 
		{
			super(s);
		}
		
		/// CONSTANTS, VARIABLES, AND ACCESSORS
		/**
		 * Where the available rendering space for images begins (taking into account the buffers and title size)
		 */
		private var availableSpaceAnchor:Point;
		
		/**
		 * The number of columns of images
		 */
		private var columns:Number = 0;
		
		/**
		 * The amount of space between images, between images and the title, and between images and the edges of the stage
		 */
		protected var imageBuffer:Number = 0.01;
		
		/**
		 * The vector of images that will be rendered on the screen
		 */
		protected var images:Vector.<Image> = new Vector.<Image>();
		
		/**
		 * Every image in this image grid is square, this value represents the image width and height
		 */
		private var imageSize:Number = 0;
		
		/**
		 * The number of images that have been rendered so far
		 */
		private var imagesRendered:Number = 0;
		
		/**
		 * The number of rows of images
		 */
		private var rows:Number = 0;
		
		/// PUBLIC FUNCTIONS
		
		/// PROTECTED FUNCTIONS
		/**
		 * When cleaning the image slide, the images need to be removed from the stage as well
		 */
		override protected function customClearn():void
		{
			for (var i:Number = 0; i < this.images.length; i++)
			{
				if (this.stage.contains(this.images[i]))
				{
					this.stage.removeChild(this.images[i]);
				}
			}
		}
		
		/**
		 * The render action for the image slide will render a title, and then images
		 */
		override protected function renderAction():void
		{
			if (this.hasRendered == false)
			{
				// Make sure the number of list items that have been rendered is marked as 0
				this.imagesRendered = 0;
				
				// Calculate the number of columns and rows for our images
				// We try to keep things as square as possible, so we use the upper bound of the square root of the number of images to get the columns
				this.columns = Math.ceil(Math.sqrt(this.images.length));
				
				// The number of rows is determined by determining how many rows our images will fill, based on the number of columns
				this.rows = Math.ceil(this.images.length / this.columns);
								
				// Instantly render the title the first time a render action is made
				// Apply the text format for the title
				var format:TextFormat = new TextFormat();
				format.color = 0x000000;
				format.size = this.stage.nativeStageHeight * this._titleHeight;
				format.align = TextAlign.CENTER | TextAlign.TOP;
				this.shape.graphics.textFormat(format);
				
				// Draw the title so that it is at the top of the stage
				var titleY = this.itemBuffer;
				this.shape.graphics.drawTextLine(this.stage.nativeStageWidth / 2, titleY, this._title);
				
				// Determine the available space anchor
				this.availableSpaceAnchor = new Point(0 + this.getPixelImageBufferWidth(), 0 + format.size + this.getPixelImageBufferHeight());
				
				// Determine the width and height of the images
				// First determine the actual amount of screen space available for images, taking the title and buffer into account
				var availableSpaceHeight:Number = this.stage.nativeStageHeight - format.size - this.getPixelImageBufferHeight() * 2;
				var availableSpaceWidth:Number = this.stage.nativeStageWidth - this.getPixelImageBufferWidth() * 2;
				
				// Use the lesser of the 2 available space values to do further calculations
				var lesserSpaceDimension:Number;
				var lesserSpaceGridDimension:Number;
				if (availableSpaceHeight < availableSpaceWidth)
				{
					lesserSpaceDimension = availableSpaceHeight;
					lesserSpaceGridDimension = rows;
				}
				else
				{
					lesserSpaceDimension = availableSpaceWidth;
					lesserSpaceGridDimension = columns;
				}
				
				// Calculate the dimensions of the image!
				this.imageSize = Math.floor(((lesserSpaceDimension / lesserSpaceGridDimension) - (this.getPixelImageBufferHeight() * (lesserSpaceGridDimension - 1))));
				
				// This slide hasn't rendered anything, to calculate the number of renders we will need to do
				if (this.renderInstantly)
				{
					this.setTotalRenders(1);
					
					// If this slide is supposed to render instantly, just go ahead and do that
					for (var i:Number; i < this.images.length; i++)
					{
						this.renderNextImage();
					}
				}
				else
				{
					this.setTotalRenders(1 + this.images.length);
				}
			}
			else
			{
				// If this slide has already rendered once, render the next list item
				renderNextImage();
			}
			
		}
		
		/// PRIVATE FUNCTIONS
		/**
		 * Renders the next image
		 * 
		 * @return Whether or not there are any images to render
		 */
		private function renderNextImage():Boolean
		{
			if (this.imagesRendered == this.images.length) return false;
			
			// Determine the column and row of this particular item
			var columnNumber = this.imagesRendered % this.columns;
			var rowNumber = Math.floor(this.imagesRendered / this.columns);
			
			// Determine the x value of this image
			var imageX = this.availableSpaceAnchor.x + columnNumber * this.imageSize + this.getPixelImageBufferWidth() * (columnNumber);
			
			// Center the value
			
			
			// Determine the y value of this image
			var imageY = this.availableSpaceAnchor.y + rowNumber * this.imageSize + this.getPixelImageBufferHeight() * (rowNumber);
			
			// Render the image!
			this.images[this.imagesRendered].width = this.imageSize;
			this.images[this.imagesRendered].height = this.imageSize;
			this.images[this.imagesRendered].x = imageX;
			this.images[this.imagesRendered].y = imageY;
			this.stage.addChild(this.images[this.imagesRendered]);
			
			this.imagesRendered++;
			
			return true;
		}
		
		
		/// PRIVATE FUNCTIONS
		private function getPixelImageBufferHeight():Number
		{
			return this.imageBuffer * this.stage.nativeStageHeight;
		}
		
		private function getPixelImageBufferWidth():Number
		{
			return this.imageBuffer * this.stage.nativeStageWidth;
		}
	}
}