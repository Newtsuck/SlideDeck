package
{
    import loom.Application;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
    import loom2d.textures.Texture;
    import loom2d.ui.SimpleLabel;
	
	import utils.*;

    public class SlideDeck extends Application
    {
        override public function run():void
        {
			// Make the stage white
            this.stage.color = 0xFFFFFF;
			
			var titleSlide:TitleSlide = new TitleSlide(this.stage);
			
			titleSlide.render();
        }
    }
}