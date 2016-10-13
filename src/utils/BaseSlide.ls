package utils 
{
	import loom2d.display.DisplayObject;
	import loom2d.display.Graphics;
	import loom2d.display.Shape;
	import loom2d.display.Stage;
	import loom2d.display.TextFormat;
	import system.errors.Error;
	
	/**
	 * This interface defines functionality for the various types of
	 * slides
	 * 
	 * @author Joshua Evans
	 */
	public class BaseSlide
	{
		/**
		 * This helper adds provided shape to a provided stage, ensuring that the shape is only added once
		 * @param	sh	The shape that will be added to the stage
		 * @param	st	The stage that the shape will be added to
		 */
		protected function addShapeToStage(sh:Shape, st:Stage):void
		{
			if (st.contains(sh)) return;
			
			st.addChild(sh);
		}
		
		/**
		 * The base constructor will establish NanoVG objects
		 * 
		 * @param	s	The stage that content will be rendered on
		 */
		public function BaseSlide(s:Stage)
		{
			this.shape = new Shape();
			this.shape.x = 0;
			this.shape.y = 0;
			
			this.stage = s;
			
			// Load the default font
			this.loadFont("default", "assets/SourceSansPro-Regular.ttf");
		}
		
		/**
		 * Will clean up the content that is rendered on the stage provided in the `render` function
		 * 
		 * This function should always be called when the slide is finished
		 */
		public function clean():void
		{
			// Clear the graphics
			this.shape.graphics.clear();
			
			// Remove the shape from the stage, if the stage contians the shape
			if (this.stage.contains(this.shape))
			{
				this.stage.removeChild(this.shape);
			}
		}
		
		/**
		 * Helper function takes the number of renders remaining and reduces it by one, ensuring that the number is never less than 0
		 */
		protected function decrementRendersRemaining():void
		{
			if (--this._rendersRemaining < 0) this._rendersRemaining = 0;
		}
		
		/**
		 * The fonts that have so far been loaded into the system. This is used to prevent loading multiple of the same font
		 */
		protected static var loadedFonts:Vector.<String> = new Vector.<String>();
		
		/**
		 * This helper function will load a font into the TextFormat class, ensuring that fonts aren't loaded more than once
		 * 
		 * @param	name	The alias that the font will use
		 * @param	path	The path to the font within the assets folder
		 */
		protected function loadFont(name:String, path:String)
		{
			if (BaseSlide.loadedFonts.contains(name)) return;
			
			TextFormat.load(name, path);
			BaseSlide.loadedFonts.push(name);
		}
		
		/**
		 * The render function will render the content of the slide on the stage that was provided in the constructor.
		 * 
		 * After the initial call to `render`, subsequent calls will move the slide forward in its animations. For example,
		 * an image rendering slide will only render the first image when `render` is called the first time, and will render
		 * more images as render continues to be called. Once all slide aspects are rendered the `render` function will do nothing.
		 * 
		 * The boolean that is returned represents if there is more content that can be rendered. If there IS content to render
		 * then a value of `true` will be returned, otherwise a value of `false` will be returned.
		 * 
		 * This function MUST be overriden in subclasses
		 * 
		 * @return	Will return whether or not there is more content available to render
		 */
		public function render():Boolean
		{
			// This function MUST be overriden in subclasses
			Debug.assertException(new Error("Attempting to call Base version of `render` from `BaseSlide`. This function MUST be overridden in subclasses"));
			
			return false;
		}
		
		/**
		 * The number of render actions available from this slide
		 */
		protected var _rendersRemaining = 1;
		
		/**
		 * Get the number of renders remaining, when this number is greater than 0 calling the `render` function
		 * should render new things on the screen. When this number is equal to 0 there is nothing left to render.
		 */
		public function get rendersRemaining():Number { return this._rendersRemaining; }
		
		/**
		 * The `shape` used for rendering NanoVG content
		 */
		protected var shape:Shape;
		
		/**
		 * The `stage` that content will be rendered on to
		 */
		protected var stage:Stage;
	}
}