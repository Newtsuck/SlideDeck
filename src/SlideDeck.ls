package
{
    import loom.Application;
	import loom.platform.LoomKey;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
	import loom2d.events.KeyboardEvent;
    import loom2d.textures.Texture;
    import loom2d.ui.SimpleLabel;
	import slides.*;
	
	import utils.*;

    public class SlideDeck extends Application
    {
        override public function run():void
        {
			// Make the stage white
            this.stage.color = 0xFFFFFF;
			
			// Add all of our slides to the deck
			DeckController.addSlide(new ExampleTitleSlide(this.stage));
			DeckController.addSlide(new ExampleTitle2Slide(this.stage));
			
			// Do the initial render!
			DeckController.renderNext();
			
			// Add the listener for keyboard input
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        }
		
		/**
		 * This event handler takes care of key input for progressing slides.
		 * 
		 * The left arrow key will render the previous slide, and any other key will
		 * render the next available renderable
		 * 
		 * @param	event	The keyboard event tied to the listener
		 */
		function keyDownHandler(event:KeyboardEvent):void
		{
			var keycode = event.keyCode;
			
			if (keycode == LoomKey.LEFT_ARROW)
			{
				DeckController.renderPrevious();
			}
			else
			{
				DeckController.renderNext();
			}
		}
    }
}