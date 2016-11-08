package components 
{
	import loom2d.display.Sprite;
	
	/**
	 * This class represents a single slide
	 * 
	 * Written by Ben Garney - LoomSDK.com
	 * Refined by Joshua Evans - TheJoshuaEvans@gmail.com
	 */
    public class Slide extends Sprite
    {
        public var curStep:int = 0;
        public var elements:Vector.<SlideElement> = new Vector.<SlideElement>();
		
		/**
		 * Adds a slide element to the slide
		 * 
		 * @param	elem	The slide element that will be added to the slide
		 */
        public function add(elem:SlideElement):void
        {
            addChild(elem);
            elements.pushSingle(elem);
        }

		/**
		 * Resets the slide and all of its elements
		 */
        public function reset():void
        {
            curStep = 0;
            for(var i:int=0; i < elements.length; i++)
                elements[i].reset();
        }
        
		/**
		 * Steps forward in the slide, rendering the next slide element, or finishing all of the slide elements if there
		 * are no more elements to render
		 * 
		 * @return	True when done with slide, ie, we tried to step and there was nothing to step.
		 */
        public function step():Boolean
        {
            var numDone:int = 0;

            for(var i:int=0; i < elements.length; i++)
            {
                var curElement = elements[i];
                if(curElement.step < curStep)
                {
                    numDone++;
                    continue;
                }

                if(curElement.step == curStep)
                    curElement.play();
            }

            trace("Slide " + this + " on step " + curStep);
            curStep++;

            var done = (numDone == elements.length);

            if(done)
            {
                trace("Slide " + this + " done");
                curStep = 0;
                for(i=0; i < elements.length; i++)
                    elements[i].finish();
            }

            return done;
        }
    }
	
}