package com.role{
	import com.utils.Collide;

	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 31, 2012 1:03:41 PM
	 * 类说明：MoveBase.as,
	 */
	public class MoveBase extends CycleBase{
		
		///移动参数
		protected const aSpeed:int = -1;//加速度
		protected var _speed:Number;//初始速度
		protected var angle:Number;//角度
		protected var time:uint;//移动时间
		
		protected var runSpeed:Number;
		public function MoveBase()
		{
			super();
		}
		/**
		 * 获取即时碰撞系数。
		 */
		override public function get collide():Collide{
			_collide.speed = _speed + aSpeed * time;
			return _collide;
		}
		/**
		 * 执行移动操作，一般在fire方法设置参数后启动。
		 * @return 返回true则移动上为结束，否则结束。
		 */
		public function execution():Boolean{
			runSpeed = _speed + aSpeed * ++time;
			if(runSpeed <= 0){
				time = 0;
				runSpeed = 0;
				return false;
			} else {
				var speedX:Number = runSpeed * Math.cos(angle /180 * Math.PI);
				var speedY:Number = runSpeed * Math.sin(angle / 180 * Math.PI);
				y += speedY;
				x += speedX;
				return true;
			}
		}
		/**
		 * 移动前的参数设置。
		 * @param angle 要移动的角度
		 * @param speed 移动注入的速度比例
		 */
		public function fire(angle:Number, speed:Number):void{
			_speed = this.speed * speed;
			this.angle = angle - 90;
			time = 0;
		}
	}
}