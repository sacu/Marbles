package com.test{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:26:32 PM
	 * 类说明：AngleBounce.as,
	 * 实现旋转
	 * 首先需要一个类似斜面的东西，只为了能够看到，并无实际用途。对于平面反弹，我们
	 * 可以使用舞台的边界。对于斜面反弹，我们就需要一条带有角度的线(line)来表示，以便看
	 * 到小球在斜面上的反弹。
	 * 因此，创建一个 Sprite 影片，加入显示列表，然后使用绘图 API 绘制一条水平线，
	 * 再将影片进行一定角度的旋转。
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class AngleBounce extends Sprite {
		private var ball:Ball;
		private var line:Sprite;
		private var gravity:Number = 0.3;
		private var bounce:Number = -0.6;
		public function AngleBounce() {
			init();
		}
		private function init():void {
			ball = new Ball();
			addChild(ball);
			ball.x = 100;
			ball.y = 100;
			line = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.lineTo(300, 0);
			addChild(line);
			line.x = 50;
			line.y = 200;
			line.rotation = 30;
//			var timer:Timer = new Timer(100);
//			timer.addEventListener(TimerEvent.TIMER, timerHandler);
//			timer.start();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
//		private function timerHandler(e:TimerEvent):void{
		private function onEnterFrame(event:Event):void {
			// 普通的运动代码
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			// 获得角度及正余弦值
			var angle:Number = line.rotation * Math.PI / 180;
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			// 获得 ball 与 line 的相对位置
			var x1:Number = ball.x - line.x;
			var y1:Number = ball.y - line.y;
			// 旋转坐标
			var x2:Number = cos * x1 + sin * y1;
			var y2:Number = cos * y1 - sin * x1;
			// 旋转速度向量
			var vx1:Number = cos * ball.vx + sin * ball.vy;
			var vy1:Number = cos * ball.vy - sin * ball.vx;
			// 实现反弹
			if (y2 > -ball.height / 2) {
				y2 = -ball.height / 2;
				vy1 *= bounce;
			}
			// 将一切旋转回去
			x1 = cos * x2 - sin * y2;
			y1 = cos * y2 + sin * x2;
			ball.vx = cos * vx1 - sin * vy1;
			ball.vy = cos * vy1 + sin * vx1;
			ball.x = line.x + x1;
			ball.y = line.y + y1;
		}
	}
}