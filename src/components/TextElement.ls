package components 
{
	import loom2d.display.Shape;
    import loom2d.display.Stage;
	import loom2d.display.TextAlign;
    import loom2d.display.TextFormat;
	
	import loom2d.math.Rectangle;
	
	/**
	 * This class defines text elements for use on slides. Instances of this class should be created for every slide element that
	 * is a string. Each Image Element only contains a single string, and no images
	 * 
	 * Written by Ben Garney - LoomSDK.com
	 * Refined by Joshua Evans - TheJoshuaEvans@gmail.com
	 */
    public class TextElement extends SlideElement
    {
		/**
		 * The text that will be rendered
		 */
        public var text:String = "";
		
		/**
		 * The y position as a factor of the stage height
		 */
        public var vertFactor:Number = 0.5;
		
		/**
		 * The shape used internally to display the text
		 */
        public var shape:Shape = new Shape();

		/**
		 * The vertical alignment of the text
		 */
        public var vertAlign:TextAlign = TextAlign.MIDDLE;
		
		/**
		 * The horizontal alignment of the text
		 */
        public var horizAlign:TextAlign = TextAlign.CENTER;

		/**
		 * The text's font scale
		 */
        public var fontScale = 0.2;
	
		/**
		 * The name of the font to be used
		 */
        public var fontName:String = "Bold";
	
		/**
		 * The color of the text
		 */
        public var fontColor:Number = 0x0;
		
		/**
		 * Constructor takes multiple parameters for the initialization of the text element
		 * 
		 * @param	_text			The text that will be rendered
		 * @param	_vertFactor		The y position as a factor of the stage height
		 * @param	_step			The place in the queue for render in the slide. Default: 0
		 */
        public function TextElement(_text:String = "Hello World", _vertFactor:Number = 0.5, _step:int = 0)
        {
            super();
            step = _step;
            text = _text;
            vertFactor = _vertFactor;
            addChild(shape);
        }
	
		/**
		 * Renders the text element by applying text formats and drawing a text box containing the text to be rendered
		 * 
		 * @param	s	The stage the text will be rendered on
		 */
        public function render(s:Stage)
        {
            super.render(s);

            // Apply the text format for the title
            var format:TextFormat = new TextFormat(fontName, s.nativeStageHeight * fontScale, fontColor);
            format.align = horizAlign | vertAlign;
            shape.graphics.textFormat(format);
            var b = shape.graphics.textBoxBounds(format, 0, 0, s.nativeStageWidth * 0.8, text);

            var yOffset = 0;
            if(vertAlign == TextAlign.MIDDLE)
                yOffset = b.height / -2;

            shape.graphics.drawTextBox(s.nativeStageWidth / -2 + s.nativeStageWidth * 0.1, yOffset, s.nativeStageWidth * 0.8, text);

            y = vertFactor * s.nativeStageHeight;
        }
    }
	
}