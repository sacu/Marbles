package com.test2{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 1:02:05 PM
	 * 类说明：Billiard4.as,
	 */
	import com.test.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Billiard4 extends Sprite {
		private var ball0:Ball;
		private var ball1:Ball;
		private var bounce:Number = -1.0;
		public function Billiard4() {
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		private function addToStage(e:Event):void{
			init();
		}
		private function init():void {
			ball0 = new Ball(50);
			ball0.mass = 2;
			ball0.x = stage.stageWidth - 200;
			ball0.y = stage.stageHeight - 200;
			ball0.vx = Math.random() * 10 - 5;
			ball0.vy = Math.random() * 10 - 5;
			addChild(ball0);
			ball1 = new Ball(60);
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
			checkCollision(ball0, ball1);
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
		private function checkCollision(ball0:Ball, ball1:Ball):void {
			var dx:Number = ball1.x - ball0.x;
			var dy:Number = ball1.y - ball0.y;
			var dist:Number = Math.sqrt(dx*dx + dy*dy);
			if (dist < ball0.radius + ball1.radius) {
				// 计算角度和正余弦值
				var angle:Number = Math.atan2(dy, dx);
				var sin:Number = Math.sin(angle);
				var cos:Number = Math.cos(angle);
				// 旋转 ball0 的位置
				var pos0:Point = new Point(0, 0);
				// 旋转 ball1 的速度
				var pos1:Point = rotate(dx, dy, sin, cos, true);
				// 旋转 ball0 的速度
				var vel0:Point = rotate(ball0.vx, ball0.vy,
					sin, cos, true);
				// 旋转 ball1 的速度
				var vel1:Point = rotate(ball1.vx, ball1.vy,
					sin, cos, true);
				// 碰撞的作用力
				var vxTotal:Number = vel0.x - vel1.x;
				vel0.x = ((ball0.mass - ball1.mass) * vel0.x +
					2 * ball1.mass * vel1.x) /
					(ball0.mass + ball1.mass);
				vel1.x = vxTotal + vel0.x;
				// 更新位置
				pos0.x += vel0.x;
				pos1.x += vel1.x;
				// 将位置旋转回来
				var pos0F:Object = rotate(pos0.x, pos0.y,
					sin, cos, false);
				var pos1F:Object = rotate(pos1.x, pos1.y,
					sin, cos, false);
				// 将位置调整为屏幕的实际位置
				ball1.x = ball0.x + pos1F.x;
				ball1.y = ball0.y + pos1F.y;
				ball0.x = ball0.x + pos0F.x;
				ball0.y = ball0.y + pos0F.y;
				// 将速度旋转回来
				var vel0F:Object = rotate(vel0.x, vel0.y,
					sin, cos, false);
				var vel1F:Object = rotate(vel1.x, vel1.y,
					sin, cos, false);
				ball0.vx = vel0F.x;
				ball0.vy = vel0F.y;
				ball1.vx = vel1F.x;
				ball1.vy = vel1F.y;
			}
		}
		private function rotate(x:Number, y:Number,
								sin:Number, cos:Number, reverse:Boolean):Point {
			var result:Point = new Point();
			if (reverse) {
				result.x = x * cos + y * sin;
				result.y = y * cos - x * sin;
			} else {
				result.x = x * cos - y * sin;
				result.y = y * cos + x * sin;
			}
			return result;
		}
	}
}