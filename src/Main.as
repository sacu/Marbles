package{
	import com.struct.Container;
	import com.test.AngleBounce;
	import com.test.AngleBounceOpt;
	import com.test.MultiAngleBounce;
	import com.test.Rotate1;
	import com.test.Rotate2;
	import com.test.Rotate3;
	import com.test2.Billiard1;
	import com.test2.Billiard2;
	import com.test2.Billiard3;
	import com.test2.Billiard4;
	import com.test2.MultiBilliard;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(width = 800, height = 600)]
	public class Main extends Sprite{
		public function Main(){
			trace("HelloWorld");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
//			addChild(new Container());
//			addChild(new Rotate1());
//			addChild(new Rotate2());
//			addChild(new Rotate3());
//			addChild(new AngleBounce());
//			addChild(new AngleBounceOpt());
//			addChild(new MultiAngleBounce());
//			addChild(new Billiard1());
//			addChild(new Billiard2());
//			addChild(new Billiard3());
//			addChild(new Billiard4());
			addChild(new MultiBilliard());
		}
	}
}