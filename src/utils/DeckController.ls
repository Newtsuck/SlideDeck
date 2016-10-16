package utils 
{
	
	/**
	 * The Deck Controller class uses static functionality to control the rendering of slides
	 * 
	 * @author Joshua Evans
	 */
	public static class DeckController 
	{
		/**
		 * Adds a slide to the slide deck
		 * 
		 * @param	slide	The slide that will be added to the deck
		 */
		public static function addSlide(slide:BaseSlide):void
		{
			DeckController.slides.push(slide);
		}
		
		/**
		 * The number of slides in the slide deck
		 */
		public static function get numberOfSLides():Number
		{
			return DeckController.slides.length;
		}
		
		/**
		 * Will render the next slide, or the next renderable action within the current slide
		 */
		public static function renderNext():void
		{
			// First attempt to render the current slide
			if (DeckController.slides[DeckController._slideNumber].render() == false && DeckController.slides.length - 1 > DeckController._slideNumber)
			{
				// If the render function returns false, render the next slide (if there is another slide to render)
				DeckController.slides[DeckController._slideNumber].clean();
				DeckController._slideNumber++;
				DeckController.slides[DeckController._slideNumber].render();
			}
		}
		
		/**
		 * Will render the previous slide, if available.
		 * 
		 * Note that this will NOT move backwards in render steps on a single slide. It will always render the previous slide from the start
		 */
		public static function renderPrevious():void
		{
			// Make sure there is a slide to render before we continue
			if (DeckController._slideNumber > 0)
			{
				DeckController.slides[DeckController._slideNumber].clean();
				DeckController._slideNumber--;
				DeckController.slides[DeckController._slideNumber].render();
			}
		}
		
		/**
		 * The slides that will be rendered, in the ordered that they will be rendered
		 */
		private static var slides:Vector.<BaseSlide> = new Vector.<BaseSlide>();
		
		/**
		 * The index of the slide that is currently being rendered
		 */
		private static var _slideNumber:Number = 0;
		
		/**
		 * The number of the slide that is currently being rendered
		 */
		private static function get slideNumber():Number
		{
			return DeckController._slideNumber;
		}
	}
}