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
		/**
		 * The render action for a title slide will render a large title, and a smaller subtitle
		 */
		override protected function renderAction():void
		{
			// Apply the text format for the title
			var format:TextFormat = new TextFormat();
			format.color = 0x000000;
			format.size = this.stage.nativeStageHeight * this._titleHeight;
			format.align = TextAlign.CENTER | TextAlign.BASELINE;
			this.shape.graphics.textFormat(format);
			
			// Draw the title so that it is resting on top of the horizontal center of the stage
			this.shape.graphics.drawTextLine(this.stage.nativeStageWidth / 2, this.stage.nativeStageHeight / 2, this._title);
			
			// Apply the text format for the subTitle
			format = new TextFormat();
			format.color = 0x000000;
			format.size = this.stage.nativeStageHeight * this._subTitleHeight;
			format.align = TextAlign.CENTER | TextAlign.TOP;
			this.shape.graphics.textFormat(format);
			
			// Draw the subTitle so that is directly underneath the title
			this.shape.graphics.drawTextBox(0, this.stage.nativeStageHeight * 0.55, this.stage.nativeStageWidth, this._subTitle);
		}
		
		/**
		 * The smaller subtitle that will be displayed
		 */
		protected var _subTitle:String = "Default Subtitle";
		
		/**
		 * A number between 0 and 1 that represents the height of the subtitle as a function of percentage of native stage height. For example, a
		 * value of `0.25` will make the subtitle as tall as one quarter the height of the stage
		 */
		protected var _subTitleHeight:Number = 0.1;
		
		/**
		 * The constructor simply takes the stage that content will be rendered on
		 * @param	s	The stage content will be rendered on
		 */
		public function TitleSlide(s:Stage) 
		{
			super(s);
		}
	}
}