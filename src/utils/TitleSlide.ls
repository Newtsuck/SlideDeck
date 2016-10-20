package utils 
{
	import feathers.text.TextFormatAlign;
	import loom2d.display.Stage;
	import loom2d.display.TextAlign;
	import loom2d.display.TextFormat;
	
	/**
	 * The TitleSlide is a simple slide type that will display a large title and
	 * a smaller subtitle.
	 * 
	 * @author Joshua Evans
	 */
	public class TitleSlide extends BaseSlide
	{
		//********** CONSTRUCTOR **********//
		/**
		 * The constructor simply takes the stage that content will be rendered on
		 * @param	s	The stage content will be rendered on
		 */
		public function TitleSlide(s:Stage) 
		{
			super(s);
		}
		
		//********** CONSTANTS, VARIABLES, AND ACCESSORS **********//
		/**
		 * The Y value of the horizontal line that seperates the title and the subtitle, the items will still be seperated by the item buffer
		 */
		protected var _partLineY:Number = 0.5;
		
		/**
		 * The smaller subtitle that will be displayed
		 */
		protected var _subTitle:String = "Default Subtitle";
		
		/**
		 * A number between 0 and 1 that represents the height of the subtitle as a function of percentage of native stage height. For example, a
		 * value of `0.25` will make the subtitle as tall as one quarter the height of the stage
		 */
		protected var _subTitleHeight:Number = 0.1;
		
		//********** PUBLIC FUNCTIONS **********//
		// No public functions
		
		//********** PROTECTED FUNCTIONS **********//
		/**
		 * The render action for a title slide will render a large title, and a smaller subtitle
		 */
		override protected function renderAction():void
		{
			// Apply the text format for the title
			var format:TextFormat = new TextFormat();
			format.color = 0x000000;
			format.size = this._stage.nativeStageHeight * this._titleHeight;
			format.align = TextAlign.CENTER | TextAlign.TOP;
			this._shape.graphics.textFormat(format);
			
			// Draw the title so that it is resting on top of the horizontal center of the stage
			// First determine the part line, and the buffer values
			var pixelPartLineY = this._stage.nativeStageHeight * this._partLineY;
			var pixelItembufferVertical = this._stage.nativeStageHeight * this._itemBuffer;
			
			// Determine where the y value of the title needs to be and draw it!
			var titleWidth = this._stage.nativeStageWidth;
			var titleHeight = this._stage.nativeStageHeight;
			var titleYModifier = this._shape.graphics.textBoxBounds(format, 0, 0, titleWidth, this._title).height;
			this._shape.graphics.drawTextBox(0, pixelPartLineY - pixelItembufferVertical - titleYModifier, titleWidth, this._title);
			
			// Apply the text format for the subTitle
			format = new TextFormat();
			format.color = 0x000000;
			format.size = this._stage.nativeStageHeight * this._subTitleHeight;
			format.align = TextAlign.CENTER | TextAlign.TOP;
			this._shape.graphics.textFormat(format);
			
			// Draw the subTitle so that is directly underneath the title
			this._shape.graphics.drawTextBox(0, pixelPartLineY + pixelItembufferVertical / 2, this._stage.nativeStageWidth, this._subTitle);
		}
		
		//********** PRIVATE FUNCTIONS **********//
		// No private functions
	}
}