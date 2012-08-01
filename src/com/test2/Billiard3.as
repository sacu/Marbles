package com.test2{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:53:33 PM
	 * 类说明：Billiard3.as,
	 * 二维动量守恒，设置舞台
	 */
	import com.test.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Billiard3 extends Sprite {
		private var ball0:Ball;
		private var ball1:Ball;
		private var bounce:Number = -1.0;
		public function Billiard3() {
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		private function addToStage(e:Event):void{
			init();
		}
		private function init():void {
			ball0 = new Ball(30);
			ball0.mass = 2;
			ball0.x = stage.stageWidth - 200;
			ball0.y = stage.stageHeight - 200;
			ball0.vx = Math.random() * 10 - 5;
			ball0.vy = Math.random() * 10 - 5;
			addChild(ball0);
			ball1 = new Ball(20);
			ball1.mass = 1;
			ball1.x = 100;
			ball1.y = 100;
			ball1.vx = Math.random() * 10 - 5;
			ball1.vy = Math.random() * 10 - 5;
			addChild(ball1);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			ball0.x += ball0.vx;
			ball0.y += ball0.vy;
			ball1.x += ball1.vx;
			ball1.y += ball1.vy;
			checkWalls(ball0);
			checkWalls(ball1);
		}
		private function checkWalls(ball:Ball):void {
			if (ball.x + ball.radius > stage.stageWidth) {
				ball.x = stage.stageWidth - ball.radius;
				ball.vx *= bounce;
			} else if (ball.x - ball.radius < 0) {
				ball.x = ball.radius;
				ball.vx *= bounce;
			}
			if (ball.y + ball.radius > stage.stageHeight) {
				ball.y = stage.stageHeight - ball.radius;
				ball.vy *= bounce;
			} else if (ball.y - ball.radius < 0) {
				ball.y = ball.radius;
				ball.vy *= bounce;
			}
		}
	}
}