package slides 
{
	import loom2d.display.Stage;
	import utils.BaseSlide;
	import utils.ImageSlide;
	import loom2d.display.Image;
    import loom2d.textures.Texture;
	
	/**
	 * This is an example image slide that goes through some of the functionality of the image slide
	 * 
	 * @author Joshua Evans
	 */
	public class ExampleImageSlide extends ImageSlide
	{
		///CONSTRUCTOR
		public function ExampleImageSlide(s:Stage) 
		{
			// Always be sure to call super!
			super(s);
			
			// Change the title of the slide
			this._title = "Example Image Slide";
			
			// Change the size of the title as a function of the total height of the stage
			// TIP: If there is no title for this slide, set this value to 0
			this._titleHeight = 0.14; // 0.14 is the default
			
			// Add images to the slide one at a time, in the order they will be appear
			this._images.push(new Image(Texture.fromAsset("assets/logo.png")));
			this._images.push(new Image(Texture.fromAsset("assets/logo.png")));
			this._images.push(new Image(Texture.fromAsset("assets/logo.png")));
			this._images.push(new Image(Texture.fromAsset("assets/logo.png")));
			this._images.push(new Image(Texture.fromAsset("assets/logo.png")));
			
			// Change whether or not the images should render instantly
			this._renderInstantly = true; // false is the default
			
			// The address of the background image for this slide, if no address is provided background will be white
			this._backgroundLocation = "assets/bg.png";
		}
	}
}