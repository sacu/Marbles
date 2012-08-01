package com.role{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 30, 2012 12:04:28 PM
	 * 类说明：Soldier.as,士兵类
	 */
	import com.collection.ConfigCollection;
	import com.utils.Collide;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Soldier extends MoveBase{
		
		public function Soldier()
		{
			super();
			_position = new Point();
			selected(false);
		}
		/**
		 * 设置士兵颜色，以后使用图形元素后改为高亮方式
		 * @param value true为选中(红色)，false为绿色。
		 */
		public function selected(value:Boolean):void{
			buttonMode = value;
			graphics.clear();
			graphics.beginFill(value?0xff0000:0x00ff00);
			graphics.drawCircle(0, 0, 8);
			graphics.endFill();
		}
		/**
		* 获取即时碰撞系数。
		*/
		override public function get collide():Collide{
			_collide.speed = runSpeed;
			_collide.angle = angle;
			return _collide;
		}
		/**
		 * 承受一个外来碰撞系数。
		 */
		override public function setcollide(value:Collide):void{
			//这里把新给进来的碰撞系数进行运算
		}
	}
}