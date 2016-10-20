package utils 
{
	import feathers.text.TextFormatAlign;
	import loom2d.display.Stage;
	import loom2d.display.TextAlign;
	import loom2d.display.TextFormat;
	/**
	 * This slide type renders a title and a list of objects that can be rendered either
	 * one at a time or all at once
	 * 
	 * @author Joshua Evans
	 */
	public class ListSlide extends BaseSlide
	{
		//********** CONSTRUCTOR **********//
		/**
		 * The constructor simply takes the stage that content will be rendered on
		 * 
		 * @param	s	The stage content will be rendered on
		 */
		public function ListSlide(s:Stage) 
		{
			super(s);
		}
		
		//********** CONSTANTS, VARIABLES, AND ACCESSORS **********//
		/**
		 * The items that will be listed, in the order that they will be rendered
		 */
		protected var _listItems:Vector.<String> = new Vector.<String>();
		
		/**
		 * A vector containing strings that will be listed as part of the list, in the order they will be rendered
		 */
		public function get listItems():Vector.<String>
		{
			return this._listItems;
		}
		
		/**
		 * The height of each list item
		 */
		protected var _listItemHeight = 0.08;
		
		// The number of list items that have been rendered in this render cycle
		private var _listItemsRendered:Number = 0;
		
		/**
		 * The anchor point's y position, in this case the bottom left corner, of the previously rendered list item
		 * 
		 * This is used to determine where to place the next list item to render
		 */
		private var previousListItemAnchor:Number = 0;
		
		//********** PUBLIC FUNCTIONS **********//
		/**
		 * Gets the pixel value of the height of each list item from the percentage value proviedd by the `_listItemHeight` variable
		 * 
		 * @return The pixel value of the height of each list item
		 */
		private function getPixelListItemHeight():Number
		{
			return this._stage.nativeStageHeight * this._listItemHeight;
		}
		
		//********** PROTECTED FUNCTIONS **********//
		/**
		 * This render action will render a title, and then render each list item
		 */
		override protected function renderAction():void
		{
			if (this._hasRendered == false)
			{
				// Make sure the number of list items that have been rendered is marked as 0
				this._listItemsRendered = 0;
				
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
				
				// Get the title's anchor point, the title's Y position plus it's size, plus a small buffer
				this.previousListItemAnchor = titleY + format.size + this._itemBuffer;
				
				// This slide hasn't rendered anything, to calculate the number of renders we will need to do
				if (this._renderInstantly)
				{
					this.setTotalRenders(1);
					
					// If this slide is supposed to render instantly, just go ahead and do that
					for (var i:Number; i < this._listItems.length; i++)
					{
						this.renderNextListItem();
					}
				}
				else
				{
					this.setTotalRenders(1 + this._listItems.length);
				}
			}
			else
			{
				// If this slide has already rendered once, render the next list item
				renderNextListItem();
			}
			
		}
		
		//********** PRIVATE FUNCTIONS **********//
		/**
		 * Renders the next list item underneath the previous list item, or directly below the title
		 * 
		 * @return Whether or not there was any items to list
		 */
		private function renderNextListItem():Boolean
		{
			if (this._listItemsRendered == this._listItems.length) return false;
			
			// Define the X value of the item
			var itemX = this._itemBuffer;
			
			// Create a circle bullet point
			this._shape.graphics.lineStyle(0.1);
			this._shape.graphics.beginFill(0x000000, 1);
			this._shape.graphics.drawCircle(itemX + this.getPixelListItemHeight() / 2, this.previousListItemAnchor + this.getPixelListItemHeight() / 2, this.getPixelListItemHeight() * 0.25);
			this._shape.graphics.endFill(); 
			
			// Apply the text format for the list item
			var format = new TextFormat();
			format.color = 0x000000;
			format.size = this.getPixelListItemHeight();
			format.align = TextAlign.LEFT | TextAlign.TOP;
			this._shape.graphics.textFormat(format);
			
			// Recalculate the item's x value to place the words to the right of the bullet point, and calculate the item's width
			itemX += this.getPixelListItemHeight() + this._itemBuffer;
			var itemWidth = this._stage.nativeStageWidth - itemX;
			
			// Draw the subTitle so that is directly underneath the previous anchor point
			this._shape.graphics.drawTextBox(itemX, this.previousListItemAnchor, itemWidth, this.listItems[this._listItemsRendered]);
			
			// Determine the next anchor point
			this.previousListItemAnchor += this._shape.graphics.textBoxBounds(format, itemX, this.previousListItemAnchor, itemWidth, this.listItems[this._listItemsRendered]).height + this._itemBuffer;
			_listItemsRendered++;
			
			return true;
		}
	}
}