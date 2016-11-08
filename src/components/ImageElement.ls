package components 
{
	import loom2d.display.Image;
	import loom2d.display.Stage;
	
	import loom2d.textures.Texture;
	
	/**
	 * This class defines image elements for use on slides. Instances of this class should be created for every slide element that
	 * is an image. Each Image Element only contains a single image, and no text
	 * 
	 * Written by Ben Garney - LoomSDK.com
	 * Refined by Joshua Evans - TheJoshuaEvans@gmail.com
	 */
	public class ImageElement extends SlideElement
    {
		/**
		 * The image that will be rendered
		 */
        public var image:Image;
		
		/**
		 * The scale of the image
		 */
        public var scaleFactor:Number = 1.0;
	
		/**
		 * Constructor takes multiple parameters for initializing the image element
		 * 
		 * @param	path		The system path where the image can be found. NOTE: Only bitmap images are currently supported!
		 * @param	_xFactor	The x position of the image as a factor of the stage width
		 * @param	_yFactor	The y position of the image as a factor of the stage height
		 * @param	_step		The place in the queue for render in the slide. Default: 0
		 * @param	_scale		A scale factor for the image. Default: 1.0
		 */
        public function ImageElement(path:String, _xFactor:Number, _yFactor:Number, _step:int = 0, _scale:Number = 1.0)
        {
            super();
            
            step = _step;
            
            xFactorDelay = _xFactor;
            yFactorDelay = _yFactor;

            scaleFactor = _scale;

            image = new Image(Texture.fromAsset(path));

            this.addChild(image);
        }
		
		/**
		 * Renders the image by centering it, and applying scale and positonal data
		 * 
		 * @param	s	The stage the image will be rendered on
		 */
        public function render(s:Stage)
        {
            super(s);
            image.center();
            image.scaleX = image.scaleY = scaleFactor;
            x = xFactorDelay * s.nativeStageWidth;
            y = yFactorDelay * s.nativeStageHeight;
        }
    }
	
}