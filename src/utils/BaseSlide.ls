package utils 
{
	import feathers.controls.NumericStepper;
	import loom2d.display.DisplayObject;
	import loom2d.display.Graphics;
	import loom2d.display.Shape;
	import loom2d.display.Stage;
	import loom2d.display.TextFormat;
	import loom2d.display.Image;
    import loom2d.textures.Texture;
	import system.errors.Error;
	
	/**
	 * This interface defines functionality for the various types of
	 * slides
	 * 
	 * @author Joshua Evans
	 */
	public class BaseSlide
	{
		//********** CONSTRUCTOR **********//
		/**
		 * The base constructor will establish NanoVG objects
		 * 
		 * @param	s	The stage that content will be rendered on
		 */
		public function BaseSlide(s:Stage)
		{
			this._shape = new Shape();
			this._shape.x = 0;
			this._shape.y = 0;
			
			this._stage = s;
			
			// Load the default font
			this.loadFont("default", "assets/SourceSansPro-Regular.ttf");
		}
		
		//********** CONSTANTS, VARIABLES, AND ACCESSORS **********//
		/**
		 * The fonts that have so far been loaded into the system. This is used to prevent loading multiple of the same font
		 */
		static private var _loadedFonts:Vector.<String> = new Vector.<String>();
		
		/**
		 * The file location of the background to apply to this slide
		 * 
		 * NOTE: Vector graphics for the background are not (yet) supported!
		 */
		protected var _backgroundLocation:String;
		
		/**
		 * This getter allows for backwards compatibiliy of the `background` variable. `_backgroundLocation` should be used instead.
		 */
		protected function get background():String
		{
			trace("WARNING: Using depreciated variable `background`, please us `_backgroundLocation` instead");
			
			return this._backgroundLocation;
		}
		
		/**
		 * This setter allows for backwards compatibiliy of the `background` variable. `_backgroundLocation` should be used instead.
		 */
		protected function set background(value:String):void
		{
			trace("WARNING: Using depreciated variable `background`, please us `_backgroundLocation` instead");
			
			this._backgroundLocation = value;
		}
		
		/**
		 * Whether or not this slide should instantly render the items on the list, or if it should render them one by one
		 * 
		 * NOTE: This does nothing for the Title slide type
		 */
		protected var _renderInstantly:Boolean = false;
		
		/**
		 * This setter allows for backwards compatibiliy of the `renderInstantly` variable. `_renderInstantly` should be used instead.
		 */
		protected function get renderInstantly():Boolean 
		{
			trace("WARNING: Using depreciated variable `renderInstantly`, please us `_renderInstantly` instead");
			
			return this._renderInstantly;
		}
		
		/**
		 * This setter allows for backwards compatibiliy of the `renderInstantly` variable. `_renderInstantly` should be used instead.
		 */
		protected function set renderInstantly(value:Boolean):void
		{
			trace("WARNING: Using depreciated variable `renderInstantly`, please us `_renderInstantly` instead");
			
			this._renderInstantly = value;
		}
		
		/**
		 * If this slide has rendered yet
		 */
		protected var _hasRendered = false;
		
		/**
		 * This getter allows for backwards compatibiliy of the `hasRendered` variable. `_hasRendered` should be used instead.
		 */
		protected function get hasRendered():Boolean
		{
			trace("WARNING: Using depreciated variable `hasRendered`, please us `_hasRendered` instead");
			
			return this._hasRendered;
		}
		
		/**
		 * This setter allows for backwards compatibiliy of the `hasRendered` variable. `_hasRendered` should be used instead.
		 */
		protected function set hasRendered(value:Boolean):void
		{
			trace("WARNING: Using depreciated variable `hasRendered`, please us `_hasRendered` instead");
			
			this._hasRendered = value;
		}
		
		/**
		 * A buffer between renderable items, as a function of screen height
		 */
		protected var _itemBuffer = 0.01;
		
		/**
		 * This getter allows for backwards compatibiliy of the `itemBuffer` variable. `_itemBuffer` should be used instead.
		 */
		protected function get itemBuffer():Number
		{
			trace("WARNING: Using depreciated variable `itemBuffer`, please us `_itemBuffer` instead");
			
			return this._itemBuffer;
		}
		
		/**
		 * This setter allows for backwards compatibiliy of the `itemBuffer` variable. `_itemBuffer` should be used instead.
		 */
		protected function set itemBuffer(value:Number):void
		{
			trace("WARNING: Using depreciated variable `itemBuffer`, please us `_itemBuffer` instead");
			
			this._itemBuffer = value;
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
		protected var _shape:Shape;
		
		/**
		 * The `stage` that content will be rendered on to
		 */
		protected var _stage:Stage;
		
		/**
		 * The title of the page
		 */
		protected var _title:String;
		
		/**
		 * The large title that will be displayed
		 */
		public function get title():String
		{
			return this._title;
		}
		
		/**
		 * A number between 0 and 1 that represents the height of the title as a function of percentage of native stage height. For example, a
		 * value of `0.5` will make the title as tall as half the native height of the stage
		 */
		protected var _titleHeight:Number = 14;
		
		/**
		 * The total number of renders actions that the slide can make
		 */
		protected var _totalRenders:Number = 1;
		
		/**
		 * The total number of things that this slide can render
		 */
		public function get totalRenders():Number { return this._totalRenders; }
		
		/**
		 * The actual background image
		 */
		private var _backgroundImage:Image;
		
		//********** PUBLIC FUNCTIONS **********//
		/**
		 * Will clean up the content that is rendered on the stage provided in the `render` function
		 * 
		 * This function should always be called when the slide is finished
		 */
		public function clean():void
		{
			// Clear the graphics
			this._shape.graphics.clear();
			
			// Remove the shape from the stage, if the stage contians the shape
			if (this._stage.contains(this._shape))
			{
				this._stage.removeChild(this._shape);
			}
			
			// Remove the background from the stage, if it exists
			if (this._backgroundImage != null && this._stage.contains(this._backgroundImage) == true)
			{
				this._stage.removeChild(this._backgroundImage);
			}
			
			// Do custom cleaning
			this.customClean();
			
			// Reset the number of renders
			this._rendersRemaining = this._totalRenders;
			
			// This slide has not rendered yet
			this._hasRendered = false;
		}
		
		/**
		 * The render function will render the content of the slide on the stage that was provided in the constructor.
		 * 
		 * After the initial call to `render`, subsequent calls will move the slide forward in its animations. For example,
		 * an image rendering slide will only render the first image when `render` is called the first time, and will render
		 * more images as render continues to be called. Once all slide aspects are rendered the `render` function will do nothing.
		 * 
		 * The boolean that is returned represents if content was rendered in the call. If there WAS content to render
		 * then a value of `true` will be returned, otherwise a value of `false` will be returned.
		 * 
		 * @return	Will return whether or not content was rendered
		 */
		public function render():Boolean
		{
			if (this._rendersRemaining == 0) return false;
			
			// Render the background if there is a background to try and render (and it hasn't already been rendered
			if (this._backgroundLocation != null && this._backgroundLocation != "" && this._stage.contains(_backgroundImage) == false)
			{
				_backgroundImage = new Image(Texture.fromAsset(this._backgroundLocation));
				_backgroundImage.width = _stage.stageWidth;
				_backgroundImage.height = _stage.stageHeight;
				_stage.addChild(_backgroundImage);
			}
			
			// Add the shape to the stage if the shape is not already in the stage
			if (this._stage.contains(this._shape) == false);
			{
				this._stage.addChild(this._shape);
			}
			
			this.renderAction();
			
			this._hasRendered = true;
			
			this.decrementRendersRemaining();
			
			return true;
		}
		
		//********** PROTECTED FUNCTIONS **********//
		/**
		 * Some slide types require custom clearning procedures. This function allows a subclass to do extra cleaning steps if overritten.
		 */
		protected function customClean():void
		{
			// Functionality is only in subclasses
		}
		
		/**
		 * Helper function takes the number of renders remaining and reduces it by one, ensuring that the number is never less than 0
		 */
		protected function decrementRendersRemaining():void
		{
			if (--this._rendersRemaining < 0) this._rendersRemaining = 0;
		}
		
		/**
		 * This helper function will load a font into the TextFormat class, ensuring that fonts aren't loaded more than once
		 * 
		 * @param	name	The alias that the font will use
		 * @param	path	The path to the font within the assets folder
		 */
		protected function loadFont(name:String, path:String)
		{
			if (BaseSlide._loadedFonts.contains(name)) return;
			
			TextFormat.load(name, path);
			BaseSlide._loadedFonts.push(name);
		}
		
		/**
		 * The render action does the bulk of rendering actions and will differ for each subclass type. This function MUST be overridden in subclasses
		 */
		protected function renderAction():void
		{
			// This function MUST be overridden in subclasses
			Debug.assertException(new Error("Attempting to call Base version of `render` from `BaseSlide`. This function MUST be overridden in subclasses"));
		}
		
		/**
		 * Sets the total number of renders that can be made by the slide and the number of renders used so far to match
		 * 
		 * @param	renders
		 */
		protected function setTotalRenders(renders:Number):void
		{
			this._totalRenders = renders;
			this._rendersRemaining = renders;
		}
		
		//********** PRIVATE FUNCTIONS **********//
		// No private functions
	}
}