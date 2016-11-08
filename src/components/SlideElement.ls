package components 
{
	import loom2d.Loom2D;
	
	import loom2d.animation.Tween;
	import loom2d.animation.Transitions;
	
	import loom2d.display.Stage;
	import loom2d.display.Sprite;
	
	/**
	 * This is the base class for slide elements. There are 2 types of slide elements - TextElement
	 * and ImageElement and those types should always be used for creating slides.
	 * 
	 * Written by Ben Garney - LoomSDK.com
	 * Refined by Joshua Evans - TheJoshuaEvans@gmail.com
	 */
    public class SlideElement extends Sprite
    {
		/**
		 * Tween data for the slide element before it is rendered by calling `play` (The slide element's initial values)
		 */
        public var before:Dictionary = { alpha: 0, transition: Transitions.EASE_OUT };
		
		/**
		 * Tween data for the slide element after it is rendered by calling `play`. This is the slide element's values
		 * for when it is being displayed on the screen
		 */
        public var during:Dictionary = { alpha: 1, transition: Transitions.EASE_OUT };
		
		/**
		 * Tween data for the slide element after it is finished by calling `finish`. This data is applied to the slide element
		 * once the slide is completed
		 */
        public var after:Dictionary = { alpha: 0, transition: Transitions.EASE_OUT };
		
		/**
		 * How long the tween actions for this slide element take to complete, in seconds
		 */
        public var duration:Number = 0.5;
		
		/**
		 * The index of the slide element within the slide. This value is established in the constructor
		 */
        public var step:int = 0;
		
		/**
		 * The x position of the slide element as a factor of the total stage width
		 */
        public var xFactorDelay:Number = 0.5;
		
		/**
		 * The y position of the slide element as a factor od the total stage height
		 */
		public var yFactorDelay:Number = 0.5;

		/**
		 * Empty Constructor
		 */
        public function SlideElement()
        {
        }
		
		/**
		 * Remove the current tweens effecting this slide element, and tween the slide element back to its initial position
		 * 
		 * @return Returns the Tween object
		 */
        public function reset():Tween
        {
            Loom2D.juggler.removeTweens(this);

            // Will take a frame to apply.
            if(before)
                return Loom2D.juggler.tween(this, 0.001, before);
            else
                return Loom2D.juggler.tween(this, 0.001, during);
        }
		
		/**
		 * Tweens the slide element to the "during" position. In general, this will show the slide element!
		 * 
		 * @return Returns the Tween object
		 */
        public function play():Tween
        {
            return Loom2D.juggler.tween(this, duration, during);
        }
		
		/**
		 * Tweens the slide element to the "after" position OR resets the slide element if there is no "after" position
		 * 
		 * @return
		 */
        public function finish():Tween
        {
            if(after)
                return Loom2D.juggler.tween(this, duration, after);
            else
                return reset();
        }

		/**
		 * Reset the slide element, and manages the X and Y variables. This function must be called before `play()`
		 * 
		 * @param	s	The stage that the slide is being rendered on
		 */
        public function render(s:Stage)
        {
            reset();

            x = s.nativeStageWidth * xFactorDelay;
            y = s.nativeStageHeight * xFactorDelay;
        }
		
		/**
		 * Set the x position as a factor of the total stage width
		 */
        public function set xFactor(value:Number)
        {
            if(!stage)
                return;

            x = value * stage.nativeStageWidth;
        }
		
		/**
		 * Get the x position as a factor of the total stage width
		 */
        public function get xFactor():Number
        {
            if(!stage)
                return 0;

            return x / stage.nativeStageWidth;
        }

		/**
		 * Set the y position as a factor of the total stage height
		 */
        public function set yFactor(value:Number)
        {
            if(!stage)
                return;

            y = value * stage.nativeStageHeight;
        }

		/**
		 * Get the y position as a factor of the total stage height
		 */
        public function get yFactor():Number
        {
            if(!stage)
                return 0;

            return y / stage.nativeStageHeight;
        }

    }
	
}