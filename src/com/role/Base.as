package com.role{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 31, 2012 1:01:35 PM
	 * 类说明：Base.as,
	 */
	import com.utils.Collide;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Base extends Sprite{
		protected var _collide:Collide;//碰撞系数
		protected var _position:Point;//位置
		public function Base()
		{
			super();
		}
		override public function set x(value:Number):void{
			super.x = value;
			_position.x = value;
		}
		override public function set y(value:Number):void{
			super.y = value;
			_position.y = value;
		}
		public function get position():Point{
			return _position;
		}
		/**
		 * 获取即时碰撞系数。
		 */
		public function get collide():Collide{
			return _collide;
		}
		/**
		 * 承受一个外来碰撞系数。
		 */
		public function setcollide(value:Collide):void{
			//这里把新给进来的碰撞系数进行运算
		}
	}
}