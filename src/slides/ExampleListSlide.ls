package slides 
{
	import loom2d.display.Stage;
	import utils.ListSlide;
	
	/**
	 * This is an example list slide that goes through some of the functionality of the list slide
	 * 
	 * @author Joshua Evans
	 */
	public class ExampleListSlide extends ListSlide
	{
		
		public function ExampleListSlide(s:Stage) 
		{
			// Always be sure to call super!
			super(s);
			
			// Change the title of the slide
			this._title = "Example List Slide";
			
			// Change the size of the title as a function of the total height of the stage
			this._titleHeight = 0.14; // 0.14 is the default
			
			// Add the list items one at a time, in the order that they will appear
			this._listItems.push("Item number 1");
			this._listItems.push("Item number 2 happens to be quite long, and should wrap around the screen");
			this._listItems.push("Item number 3");
			this._listItems.push("Item number 4");
			
			// Change the height of the list items
			this._listItemHeight = 0.08; // 0.08 is the default
			
			// Change whether or not the list items should render instantly
			this.renderInstantly = false; // false is the default
		}
	}
}