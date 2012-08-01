package com.test2{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 1:04:00 PM
	 * 类说明：MultiBilliard.as,
	 */
	import com.test.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class MultiBilliard extends Sprite {
		private var balls:Array;
		private var numBalls:uint = 10;
		private var bounce:Number = -1.0;
		private const acceleration:Number = -0.1;
		public function MultiBilliard() {
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}
		private function addToStage(e:Event):void{
			init();
		}
		private function init():void {
			balls = new Array();
			for (var i:uint = 0; i < numBalls; i++) {
				var radius:Number = Math.random() * 10 + 10;
				var mass:Number = Math.pow(2, i) + 10;
				var ball:Ball = new Ball(radius, mass, 0xffffff - Math.pow(2, i))//mass);
				ball.x = (i + 1) * 40;
				ball.y = 250;
				ball.addEventListener(MouseEvent.CLICK, clickHandler);
				addChild(ball);
				balls.push(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function clickHandler(e:MouseEvent):void{
			var ball:Ball = e.target as Ball;
			ball.vx = Math.random() * 50 + 5;
			ball.vy = Math.random() * 50 + 5;
		}
		private function onEnterFrame(event:Event):void {
			for (var i:uint = 0; i < numBalls; i++) {
				var ball:Ball = balls[i];
				var speed:Number = Math.sqrt(Math.pow(ball.vx, 2) + Math.pow(ball.vy, 2));
				speed += acceleration;
				ball.execution = speed>0;
				if(ball.execution){
					var angle:Number = Math.atan2(ball.vy, ball.vx);
					ball.vx = speed * Math.cos(angle);
					ball.vy = speed * Math.sin(angle);
					ball.x += ball.vx;
					ball.y += ball.vy;
					checkWalls(ball);
				}
			}
			for (i = 0; i < numBalls - 1; i++) {
				var ballA:Ball = balls[i];
				for (var j:Number = i + 1; j < numBalls; j++) {
					var ballB:Ball = balls[j];
					checkCollision(ballA, ballB);
				}
			}
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
				var absV:Number = Math.abs(vel0.x) + Math.abs(vel1.x);
				var overlap:Number = (ball0.radius + ball1.radius) - Math.abs(pos0.x - pos1.x);
				pos0.x += vel0.x / absV * overlap;
				pos1.x += vel1.x / absV * overlap;
//				pos0.x += vel0.x;
//				pos1.x += vel1.x;
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