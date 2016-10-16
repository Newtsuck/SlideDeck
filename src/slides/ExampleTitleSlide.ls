package slides 
{
	import loom2d.display.Stage;
	import utils.TitleSlide;
	
	/**
	 * This is an example title slide that goes through some of the functionality of the title slide
	 * 
	 * @author Joshua Evans
	 */
	public class ExampleTitleSlide extends TitleSlide
	{
		
		public function ExampleTitleSlide(s:Stage) 
		{
			// Always be sure to call super!
			super(s);
			
			// Change the title of the slide
			this._title = "Example Title 1";
			
			// Change the size of the title as a function of the total height of the stage
			this._titleHeight = 0.22; // 0.14 is the default
			
			// Change the subtitle of the slide
			this._subTitle = "Example subtitle";
			
			// Chang ethe size of the sub title as a function of the total height of the stage
			this._subTitleHeight = 0.10; // 0.10 is the default
		}
	}
}