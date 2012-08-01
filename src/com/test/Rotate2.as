package com.test{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:21:36 PM
	 * 类说明：Rotate2.as,
	 * 角度(angle)就是某一时刻内旋转物体位置的大小。这并非当前的角度，也不是旋转后
	 * 的角度，而是这两者之间的差值。换句话讲，如果物体在离中心点 45 度的位置，而这次的
	 * 角度是 5 度，我们就要在当前角度的基础上再旋转 5 度，到达 50 度这个位置上。这里我
	 * 们并不关心最初或最终的角度，只关心旋转了多少度。
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Rotate2 extends Sprite {
		private var ball:Ball;
		private var vr:Number = .05;
		private var cos:Number = Math.cos(vr);
		private var sin:Number = Math.sin(vr);
		public function Rotate2() {
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		private function addToStage(e:Event):void{
			init();
		}
		public function init():void {
			ball = new Ball();
			addChild(ball);
			ball.x = Math.random() * stage.stageWidth;
			ball.y = Math.random() * stage.stageHeight;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			var x1:Number = ball.x - stage.stageWidth / 2;
			var y1:Number = ball.y - stage.stageHeight / 2;
			var x2:Number = cos * x1 - sin * y1;
			var y2:Number = cos * y1 + sin * x1;
			ball.x = stage.stageWidth / 2 + x2;
			ball.y = stage.stageHeight / 2 + y2;
		}
	}
}