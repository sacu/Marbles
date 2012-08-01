package com.test{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:19:36 PM
	 * 类说明：Rotate1.as,
	 * 根据角度与半径使用简单的三角函数设置物体的 x,y 属性，并在每帧中改变角度。
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Rotate1 extends Sprite {
		private var ball:Ball;
		private var angle:Number = 0;
		private var radius:Number = 150;
		private var vr:Number = .05;
		public function Rotate1() {
			init();
		}
		private function init():void {
			ball = new Ball();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			ball.x = stage.stageWidth / 2 + Math.cos(angle) * radius;
			ball.y = stage.stageHeight / 2 + Math.sin(angle) * radius;
			angle += vr;
		}
	}
}