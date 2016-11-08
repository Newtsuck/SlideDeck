package
{
    import loom.Application;

    import loom.platform.LoomKey;
	
    import loom2d.display.Image;
    import loom2d.display.Stage;
    import loom2d.display.TextAlign;
    import loom2d.display.TextFormat;

    import loom2d.events.KeyboardEvent;
	
	import components.*;

	/**
	 * This slide deck app was created so that presentations could be given using any platform that Loom is compatible with,
	 * including the Raspberry Pi!
	 * 
	 * In order to create slides, first make TextElements and ImageElements and add them to a slide, then add that slide to the slide deck, the
	 * internal systems will take care of the rest!
	 * 
	 * For more specific details, check out the functions within this class that help to define these slides
	 * 
	 * Written by Ben Garney - LoomSDK.com
	 * Refined by Joshua Evans - TheJoshuaEvans@gmail.com
	 */
    public class SlideDeck extends Application
    {
		/**
		 * The slide deck!
		 */
        public var deck:Deck = new Deck();


        public function s01_title():Slide
        {
            var s = new Slide();

            var titleA = new TextElement("Bringing IoT\nto the Visual World", 0.1, 0);
			
			// By setting the "xFactor" field the title will start on the left side of the screen, then when "rendered" will
			// move to the center of the screen, then wil leave out the right side of the screen when finished
            titleA.before["xFactor"] = -0.5;
            titleA.during["xFactor"] = 0.5;
            titleA.after["xFactor"] = 1.5;
            titleA.vertAlign = TextAlign.TOP;
            s.add(titleA);

            var titleB = new TextElement("Ben Garney\nben@theengine.co", 0.6, 1);
            titleB.fontName = "Regular";
            titleB.vertAlign = TextAlign.BOTTOM;
            titleB.fontScale = 0.1;
            s.add(titleB);

            var logo = new ImageElement("assets/01_logo.png", 0.5, 0.8, 2);
            s.add(logo);

            return s;
        }

        public function s02_whowhatwhy():Slide
        {
            var s = new Slide();

            var titleA = new TextElement("Who are you?\nWho am I?\nWhy am I here?", 0.55, 0);
            titleA.vertAlign = TextAlign.MIDDLE;
            s.add(titleA);

            return s;
        }

        public function s03_usecases():Slide
        {
            var s = new Slide();

            var titleA = new TextElement("Use Cases", 0.75, 0);
            titleA.vertAlign = TextAlign.TOP;
            s.add(titleA);

            var left = new ImageElement("assets/03_left.png", 0.15, 0.45, 1);
            left.scaleFactor = 0.9;
            s.add(left);

            var mid = new ImageElement("assets/03_middle.png", 0.5, 0.4, 2);
            mid.scaleFactor = 0.9;
            s.add(mid);

            var right = new ImageElement("assets/03_right.png", 0.85, 0.425, 3);
            right.scaleFactor = 0.9;
            s.add(right);

            return s;
        }

        public function s04_options():Slide
        {
            var s = new Slide();

            var titleA = new TextElement("Options", 0.05, 0);
            titleA.vertAlign = TextAlign.TOP;
            s.add(titleA);

			// If multiple slide elements are given the same "step" value they will all be rendered simultaniously!
            s.add(new ImageElement("assets/04_rasp.png",   0.17,  0.27, 1, 0.9));
            s.add(new ImageElement("assets/04_bbb.png",    0.2,   0.75, 1, 0.75));
            s.add(new ImageElement("assets/04_vulkan.png", 0.5,   0.40, 1, 0.9));
            s.add(new ImageElement("assets/04_tegra.png",  0.53,  0.76, 1, 0.77));
            s.add(new ImageElement("assets/04_linux.png",  0.80,  0.20, 1, 0.9));
            s.add(new ImageElement("assets/04_opengl.png", 0.80,  0.5,  1, 0.9));
            s.add(new ImageElement("assets/04_qcom.png",   0.825, 0.8,  1, 0.9));

            return s;
        }

        public function s05_webkit():Slide
        {
            var s = new Slide();
            s.add(new ImageElement("assets/05_webkit.png",  0.5, 0.5, 0, 1.3));
            return s;
        }

        public function s06_burninate():Slide
        {
            var s = new Slide();
            s.add(new ImageElement("assets/05_webkit.png",  0.5, 0.5, 0, 1.3));
            s.add(new ImageElement("assets/06_flame.png",  0.5, 0.5, 0, 0.9));
            return s;
        }

        public function s07_line(text:String, pos:Number):TextElement
        {
			// If the slide only contains a single slide element, the element itself can be added to the slide deck as
			// if it is a slide
            var te = new TextElement("• " + text, pos, 0);
            te.fontName = "Regular";
            te.fontScale = 0.1;
            te.vertAlign = TextAlign.TOP;
            te.horizAlign = TextAlign.LEFT;
            return te;
        }

        public function s07_whynot():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Why not WebKit?", 0.2, 0));
            s.add(s07_line("CSS/HTML/JS introduce overhead, complexity, abstraction.", 0.25));
            s.add(s07_line("Many behaviors are triggered indirectly -> hard to debug or control.", 0.50));
            s.add(s07_line("Huge codebase -> difficult to debug or reason about.", 0.75));
            return s;
        }

        public function s08_whynot2():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Why not WebKit?", 0.98, 0));
            s.add(new ImageElement("assets/08_watch.png",   0.15,  0.2,  1, 0.95));
            s.add(new ImageElement("assets/08_eug.png",     0.25,  0.6,  2, 0.95));
            s.add(new ImageElement("assets/08_gear.png",    0.75,  0.6,  3, 0.75));
            s.add(new ImageElement("assets/08_laptop.png",  0.8,   0.22, 4, 0.84));
            return s;
        }

        public function s09_thenwhat():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Then what?", 0.5, 0));
            return s;
        }

        public function s10_native():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Native\nRuntime",        0.4, 0));
            s.add(new ImageElement("assets/10_lua.png",     0.17,  0.3,   1, 1.3));
            s.add(new ImageElement("assets/10_nanovg.png",  0.22,  0.75,  2, 0.9));
            s.add(new ImageElement("assets/10_map.png",     0.5,   0.66,  3, 0.75));
            s.add(new ImageElement("assets/10_sqlite.png",  0.5,   0.86,  4, 0.8));
            s.add(new ImageElement("assets/10_sdl.png",     0.8,   0.75,  5, 1.15));
            s.add(new ImageElement("assets/10_js.png",      0.8,   0.3,   6, 0.75));
            return s;
        }

        public function s11_workflow():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Workflow & Tooling",     0.28, 0));
            s.add(new ImageElement("assets/11_chart.png",   0.25,  0.65,  1, 1.3));
            s.add(new ImageElement("assets/11_ide.png",     0.75,  0.65,  2, 0.8));
            return s;
        }

        public function s12_genie():Slide
        {
            var s = new Slide();
            s.add(new ImageElement("assets/black.png",      0.50,  0.50,  0, 10));

            var overall = 0.85;
            var aspect = 1.95;

            var img = new ImageElement("assets/12_genie1.png",  0.25,  0.25,  0, overall);
            img.scaleX = aspect;
            s.add(img);

            var img2 = new ImageElement("assets/12_genie2.png",  0.75,  0.70,  1, overall);
            img2.scaleX = aspect;
            s.add(img2);

            return s;
        }

        public function s13_perf():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Performance",     0.28, 0));
            s.add(new ImageElement("assets/13_book.png",   0.17,  0.65,  1, 0.9));
            s.add(new ImageElement("assets/13_telem.png",  0.66,  0.65,  2, 1.4));
            return s;
        }

        public function s14_perfiot():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Performance on IoT", 0.25, 0));
            s.add(s07_line("You are on the edge.", 0.27));
            s.add(s07_line("Budgeting for performance is vital.", 0.42));
            s.add(s07_line("Profiling and tuning is a way of life,\n\tnot a last step.", (0.42-0.27) + 0.42));
            s.add(s07_line("The system conspires against you.", (0.42-0.27) + 0.42 + 0.23));
            return s;
        }

        public function s15_line(text:String, pos:Number, italic:Boolean = false):TextElement
        {
            var te = new TextElement(text, pos, 0);
            te.horizAlign = TextAlign.LEFT;
            if(italic) te.fontName = "Bold Italic";
            te.fontScale = 0.23;
            return te;
        }

        public function s15_paranoia():Slide
        {
            var s = new Slide();
            var offset = 0.23;
            s.add(s15_line("It's not paranoia", offset + 0.00));
            s.add(s15_line("if they are",       offset + 0.25));
            s.add(s15_line("really",            offset + 0.50, true));
            s.add(s15_line("out to get you.",   offset + 0.75));
            return s;
        }

        public function s16_production():Slide
        {
            var s = new Slide();

            var title = new TextElement("Production Concerns\naka\nThe Black Arts", 0.2, 0);
            title.fontScale = 0.10;
            title.fontName = "Bold";
            s.add(title);

            var left = new TextElement(
                "• Resource exhaustion.\n" + 
                "• GPU and driver bugs.\n" + 
                "• Thermal issues.\n" + 
                "• System configuration.\n" + 
                "• Remote update/management.\n" + 
                "• Logging and reporting.\n" + 
                "• Analytics.\n" + 
                "• Crash tracking.\n" + 
                "• Enclosure design.",
                    0.68, 0);
            left.fontScale = 0.075;
            left.fontName = "Regular";
            left.horizAlign = TextAlign.LEFT;
            left.xFactorDelay = 0.43;
            left.during["alpha"] = 0.6;
            s.add(left);

            var right = new TextElement(
               "• Broken internet.\n" +
               "• Field support.\n" +
               "• Power failures.\n" +
               "• UI framework bugs.\n" +
               "• Certificate/SSL problems.\n" +
               "• Full disk.\n" +
               "• Bad RAM.\n" +
               "• Don’t turn into a zombie.\n" +
               "• Resource starvation.\n",
                    0.68, 0);
            right.fontScale = 0.075;
            right.fontName = "Regular";
            right.horizAlign = TextAlign.LEFT;
            right.xFactorDelay = 0.93;
            right.during["alpha"] = 0.6;
            s.add(right);

            return s;
        }

        public function s17_loom():Slide
        {
            var s = new Slide();
            s.add(new ImageElement("assets/17_logo.png", 0.5, 0.40, 0, 0.9));

            var te = new TextElement("www.loomsdk.com", 1.0, 0);
            s.add(te);

            return s;
        }

        public function s18_line(text:String, pos:Number):TextElement
        {
            var te = new TextElement("• " + text, pos, 0);
            te.fontName = "Regular";
            te.fontScale = 0.15;
            te.vertAlign = TextAlign.TOP;
            te.horizAlign = TextAlign.LEFT;
            return te;
        }

        public function s18_conclusions():Slide
        {
            var s = new Slide();
            s.add(new TextElement("Conclusions", 0.2, 0));
            s.add(s18_line("How to build.", 0.25));
            s.add(s18_line("How to ship.", 0.45));
            s.add(s18_line("How to run in production.", 0.65));
            return s;            
        }

        public function s19_thanks():Slide
        {
            var s = new Slide();

            var te = new TextElement("Thanks for coming", 0.2, 0);
            s.add(te);

            var te1 = new TextElement("Q&A", 0.86, 0);
            te1.fontScale = 0.80;
            s.add(te1);

            var te2 = new TextElement("@bengarney / ben@theengine.co", 0.95, 0);
            te2.fontName = "Regular";
            te2.fontScale = 0.125;
            s.add(te2);

            return s;
        }

        override public function run():void
        {
            // Make the stage white
            this.stage.color = 0xFDFDFD;
            
            TextFormat.load("Bold", "assets/SourceSansPro-Black.ttf");
            TextFormat.load("Bold Italic", "assets/SourceSansPro-BlackItalic.ttf");
            TextFormat.load("Regular", "assets/SourceSansPro-Regular.ttf");

            deck.add(s01_title());
            deck.add(s02_whowhatwhy());
            deck.add(s03_usecases());
            deck.add(s04_options());
            deck.add(s05_webkit());
            deck.add(s06_burninate());
            deck.add(s07_whynot());
            deck.add(s08_whynot2());
            deck.add(s09_thenwhat());
            deck.add(s10_native());
            deck.add(s11_workflow());
            deck.add(s12_genie());
            deck.add(s13_perf());
            deck.add(s14_perfiot());
            deck.add(s15_paranoia());
            deck.add(s16_production());
            deck.add(s17_loom());
            deck.add(s18_conclusions());
            deck.add(s19_thanks());

            this.stage.addChild(deck);
            deck.render(stage);

            // Force advance.
            var forceAdvance = 1;
            for(var i:int=0; i<forceAdvance; i++)
                deck.step();
            
            // Add the listener for keyboard input
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        }
        
        /**
         * This event handler takes care of key input for progressing slides.
         * 
         * The left arrow key will render the previous slide, and any other key will
         * render the next available renderable
         * 
         * @param   event   The keyboard event tied to the listener
         */
        function keyDownHandler(event:KeyboardEvent):void
        {
            var keycode = event.keyCode;
            
            if (keycode == LoomKey.LEFT_ARROW)
            {
                deck.back();
            }           
            else if (keycode == LoomKey.RIGHT_ARROW) 
            {
                deck.step();
            }
        }
    }
}