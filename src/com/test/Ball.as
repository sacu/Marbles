package com.test{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Aug 1, 2012 12:20:02 PM
	 * 类说明：Ball.as,
	 */
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	public class Ball extends Sprite {
		public var radius:Number;
		public var color:uint;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		public var mass:Number;
		private var txt:TextField;
		public var execution:Boolean;
		
		public function Ball(radius:Number=40, mass:Number = 1, color:uint=0xff0000) {
			this.mass = mass;
			this.radius = radius;
			this.color = color;
			execution = true;
			txt = new TextField();
			txt.mouseEnabled = false;
			txt.x = -radius;
			txt.y = -radius / 2;
			txt.text = mass.toString();
			txt.width = radius * 2;
			txt.autoSize = TextFormatAlign.CENTER;
			addChild(txt);
			init();
		}
		public function get vx():Number{
			return _vx;
		}
		public function set vx(value:Number):void{
			_vx = Math.min(radius, value);
//			_vx = value;
		}
		public function get vy():Number{
			return _vy;
		}
		public function set vy(value:Number):void{
			_vy = Math.min(radius, value);
//			_vy = value;
		}
		public function init():void {
			graphics.lineStyle(1, 0x000);
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
	}
}