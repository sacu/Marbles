package com.utils{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 30, 2012 12:21:58 PM
	 * 类说明：Arrow.as,
	 */
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Arrow extends Sprite{
		public const tensile:Number = 100;
		
		public var speed:Number;
		public var angle:Number;
		public function Arrow()
		{
			super();
			mouseEnabled = false;
		}
		public function setAngle(x:Number, y:Number):void{
			angle = Physical.Point2Angle(new Point(x, y), new Point()) - 90;//Math.atan2(y, x) * 180 / Math.PI - 90;//Math.atan(y / x);
			
			var length:Number = Math.min(Point.distance(new Point(), new Point(x, y)), tensile);
			
			rotation = angle;
			graphics.clear();
			graphics.beginFill(0x00ff00);
			graphics.drawRect(-3, -length, 5, length);
			graphics.endFill();
			speed = length/tensile;
		}
	}
}