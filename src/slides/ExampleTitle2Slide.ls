package slides 
{
	import loom2d.display.Stage;
	import utils.TitleSlide;
	
	/**
	 * This is the second example title slide and just exists to showcase slide transitioning.
	 * 
	 * See ExampleTitleSlide for information on slide customization
	 * 
	 * @author Joshua Evans
	 */
	public class ExampleTitle2Slide extends TitleSlide
	{
		
		public function ExampleTitle2Slide(s:Stage) 
		{
			super(s);
			this._title = "Example Title 2";
		}
	}
}