package components 
{
	import loom2d.display.Stage;
	import loom2d.display.Sprite;
	
	/**
	 * A slide deck that contains slides that can be rendered
	 * 
	 * Written by Ben Garney - LoomSDK.com
	 * Refined by Joshua Evans - TheJoshuaEvans@gmail.com
	 */
	public class Deck extends Sprite
    {
		/**
		 * The slides that will be rendered
		 */
        public var slides:Vector.<Slide> = new Vector.<Slide>();
		
		/**
		 * The slide that was previously rendered
		 */
        public var prevSlide:Slide;
		
		/**
		 * The slide that is currently being rendered
		 */
        public var curSlide:Slide;
		
		/**
		 * The index of the slide that is currently being rendered
		 */
        public var curIndex:int = 0;
		
		/**
		 * Do initialization of every slide and their slide elements. This MUST be called before the deck can be operated
		 * 
		 * @param	s	The stage that the deck is to be rendered on
		 */
        public function render(s:Stage)
        {
            for(var i:int=0; i<slides.length; i++)
                for(var j:int=0; j<slides[i].elements.length; j++)
                    slides[i].elements[j].render(s);
        }
		
		/**
		 * Adds a slide to the slide deck
		 * 
		 * @param	slide	The slide that is being added
		 */
        public function add(slide:Slide):void
        {
            slides.pushSingle(slide);
        }

		/**
		 * Step forward in the slide deck, either rendering a new slide element on the current slide, or moving on to the next slide
		 */
        public function step():void
        {
            if(prevSlide)
            {
                prevSlide.reset();
                removeChild(prevSlide);
                prevSlide = null;
            }

            var curDone = true;
            if(curSlide)
                curDone = curSlide.step();

            if(curDone)
            {
                // At this time end animation has already begun.
                prevSlide = curSlide;

                if(curIndex < slides.length)
                {
                    // Get the next slide and advance state.
                    curSlide = slides[curIndex];
                    addChild(curSlide);
                    curIndex++;

                    // And get it showing up.
                    curSlide.step();
                }
                else
                {
                    trace("Finished with deck.");
                    curIndex = 0;
                    curSlide = null;
                }
            }
        }

		/**
		 * Go back to the previous slide
		 * 
		 * NOT YET IMPLEMENTED
		 */
        public function back():void
        {
            trace("back NYI");
        }
    }
	
}