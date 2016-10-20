package utils 
{
	
	/**
	 * The Deck Controller class uses static functionality to control the rendering of slides
	 * 
	 * @author Joshua Evans
	 */
	public static class DeckController 
	{
		//********** CONSTRUCTOR **********//
		// No constructor, this is a static class!
		
		//********** CONSTANTS, VARIABLES, AND ACCESSORS **********//
		/**
		 * The slides that will be rendered, in the ordered that they will be rendered
		 */
		private static var _slides:Vector.<BaseSlide> = new Vector.<BaseSlide>();
		
		/**
		 * The index of the slide that is currently being rendered
		 */
		private static var _slideNumber:Number = 0;
		
		/**
		 * The number of the slide that is currently being rendered
		 */
		public static function get slideNumber():Number
		{
			return DeckController._slideNumber;
		}
		
		//********** PUBLIC FUNCTIONS **********//
		/**
		 * Adds a slide to the slide deck
		 * 
		 * @param	slide	The slide that will be added to the deck
		 */
		public static function addSlide(slide:BaseSlide):void
		{
			DeckController._slides.push(slide);
		}
		
		/**
		 * The number of slides in the slide deck
		 */
		public static function get numberOfSLides():Number
		{
			return DeckController._slides.length;
		}
		
		/**
		 * Will render the next slide, or the next renderable action within the current slide
		 */
		public static function renderNext():void
		{
			// First attempt to render the current slide
			if (DeckController._slides[DeckController._slideNumber].render() == false && DeckController._slides.length - 1 > DeckController._slideNumber)
			{
				// If the render function returns false, render the next slide (if there is another slide to render)
				DeckController._slides[DeckController._slideNumber].clean();
				DeckController._slideNumber++;
				DeckController._slides[DeckController._slideNumber].render();
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
				DeckController._slides[DeckController._slideNumber].clean();
				DeckController._slideNumber--;
				DeckController._slides[DeckController._slideNumber].render();
			}
			else if (DeckController._slideNumber == 0)
			{ 
				// If the slide number is 0 then just re-render the current slide
				DeckController._slides[DeckController._slideNumber].clean();
				DeckController._slides[DeckController._slideNumber].render();
			}
		}
		
		//********** PROTECTED FUNCTIONS **********//
		// No protected functions
		
		//********** PRIVATE FUNCTIONS **********//
		// No private functions
	}
}