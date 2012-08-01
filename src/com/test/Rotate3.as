package com.test{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:24:22 PM
	 * 类说明：Rotate3.as,
	 * 解释一下最后这个概念。举个例子，用鼠标位置控制多个物体旋转的速度。如果鼠标在
	 * 屏幕中心，则不产生旋转。如果鼠标向左移动，则物体逆时针旋转，并且越向左速度越快。
	 * 如果向右移动，则顺时针旋转。
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Rotate3 extends Sprite {
		private var balls:Array;
		private var numBalls:uint = 10;
		private var vr:Number = .05;
		public function Rotate3() {
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		private function addToStage(e:Event):void{
			init();
		}
		private function init():void {
			balls = new Array();
			for (var i:uint = 0; i < numBalls; i++) {
				var ball:Ball = new Ball();
				balls.push(ball);
				addChild(ball);
				ball.x = Math.random() * stage.stageWidth;
				ball.y = Math.random() * stage.stageHeight;
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			var angle:Number = (mouseX - stage.stageWidth / 2) * .001;
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			for (var i:uint = 0; i < numBalls; i++) {
				var ball:Ball = balls[i];
				var x1:Number = ball.x - stage.stageWidth / 2;
				var y1:Number = ball.y - stage.stageHeight / 2;
				var x2:Number = cos * x1 - sin * y1;
				var y2:Number = cos * y1 + sin * x1;
				ball.x = stage.stageWidth / 2 + x2;
				ball.y = stage.stageHeight / 2 + y2;
			}
		}
	}
}