package com.test2{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:44:01 PM
	 * 类说明：Billiard2.as,
	 * Billiard1增强onEnterFrame
	 */
	import com.test.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Billiard2 extends Sprite {
		private var ball0:Ball;
		private var ball1:Ball;
		public function Billiard2() {
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		private function addToStage(e:Event):void{
			init();
		}
		private function init():void {
			ball0 = new Ball(40);
			ball0.mass = 2;
			ball0.x = 50;
			ball0.y = stage.stageHeight / 2 + 20;
			ball0.vx = 1;
			addChild(ball0);
			ball1 = new Ball(25);
			ball1.mass = 1;
			ball1.x = 300;
			ball1.y = stage.stageHeight / 2 - 20;
			ball1.vx = -1;
			addChild(ball1);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			ball0.x += ball0.vx;
			ball1.x += ball1.vx;
			var dist:Number = ball1.x - ball0.x;
			if (Math.abs(dist) < ball0.radius + ball1.radius) {
				var vxTotal:Number = ball0.vx - ball1.vx;
				ball0.vx = ((ball0.mass - ball1.mass) * ball0.vx +
					2 * ball1.mass * ball1.vx) /
					(ball0.mass + ball1.mass);
				ball1.vx = vxTotal + ball0.vx;
				ball0.x += ball0.vx;
				ball1.x += ball1.vx;
			}
		}
	}
}