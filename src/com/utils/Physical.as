package com.utils{
	import flash.geom.Point;

	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 31, 2012 10:45:10 AM
	 * 类说明：Physical.as,
	 * 
	 *  基本三角函数的计算：
	 * 角的正弦值 = 对边 / 斜边
	 * 角的余弦值 = 邻边 / 斜边
	 * 角的正切值 = 对边 / 邻边
	 * 
	 * 角度制与弧度制的相互转换：
	 * 弧度 = 角度 * Math.PI / 180
	 * 角度 = 弧度 * 180 / Math.PI
	 */
	public class Physical{
///----------------------------撞球物理
		/**
		 * 动量
		 * @param m 总质量
		 * @param v 速度
		 * @return 返回一个动量值
		 */
		public static function ConservationOfMomentum(m:Number, v:Number):Number{
			return m * v;
		}
		/**
		 * 动量守恒：（m0 * v0) + (m1 * v1) = (m0 * v0Final) + (m1 * v1Final) 
		 */
		/**
		 * 动能：KE = 0.5 * m * v²
		 */
		/**
		 * 动能守恒：(0. 5 * m0 * v0²) + (0.5 * m1 * v1²) = (0.5 * m0 * v0Final²) + (0.5 * m1 * v1Final²)
		 * 动量守恒的数学表达式：
		 * v0Final = ((m0 - m1) * v0 + 2 * m1 * v1 ) / (m0 + m1)
		 * v1Final = ((m1 - m0) * v1 + 2 * m0 * v0 ) / (m0 + m1)
		 * 
		 * 动量守恒代码：
		 * var vxTotal:Number = vx0 - vx1;
		 * vx0 = ((quality0 - quality1) * vx0 + 2 * quality1 * vx1 ) / (quality0 + quality1);
		 * vx1 = vxTotal + vx0;
		 */
		
///------------------------------粒子(Particles)引力和重力
		/**
		 * 引力	force = G * m1 * m2 / distance²
		 */
		
		/**
		 * 万有引力
		 */
		public static function gravitate (a:Point, av:Point, aquality:Number, 
								   b:Point, bv:Point, bquality:Number): void{
			var dx:Number = b.x - a.x;
			var dy:Number = b.y - a.y;
			var distSQ:Number = dx * dx + dy * dy;
			var dist:Number = Math.sqrt(distSQ);
			var force:Number = aquality * bquality / distSQ;
			var ax:Number = force * dx / dist;
			var ay:Number = force * dy / dist;
			av.x += ax / aquality;
			av.y += ay / aquality;
			bv.x -= ax / bquality;
			bv.y -= ay / bquality;
		}
		
///------------------------速度与加速度
		/**
		 * 角速度转换为x,y速度向量
		 */
		public static function Angle2SpeedX(speed:Number, angle:Number):Number{
			return speed * Math.cos(angle);
		}
		public static function Angle2SpeedY(speed:Number, angle:Number):Number{
			return speed * Math.sin(angle);
		}
		/**
		 * 角加速度（作用于物体上的force）转换为x,y加速度
		 */
		public static function Angle2ForceX(force:Number, angle:Number):Number{
			return Angle2SpeedX(force, angle);
		}
		public static function Angle2ForceY(force:Number, angle:Number):Number{
			return Angle2SpeedY(force, angle);
		}
		/**
		 * 波形运动y
		 * 注意变化angle角度
		 */
		public function Angle2MoveX(range:Number, angle:Number):Number {
			return Angle2SpeedX(range, angle);//Math.cos(angle) * range;
		}
		public function Angle2MoveY(range:Number, angle:Number):Number {
			return Angle2SpeedY(range, angle);//Math.sin(angle) * range;
		}
		/**
		 *  摩擦力应用（正确方法）：
		 * speed = Math.sqrt ( vx*vx + vy*vy );
		 * angle = Math.atan2 ( vy,vx );
		 * if ( speed > friction ) {
		 * speed -= friction;
		 * } else {
		 * speed = 0;
		 * }
		 * vx = Math.cos(angle) * speed;
		 * vy = Math.sin(angle) * speed;
		 * 摩擦力应用（简便方法）：
		 * vx *= friction;
		 * vy *= friction;
		 */
		
///-----------------缓动
		/**
		 * 缓动
		 * sprite.x += (targetX – sprite.x) * easing;//easing为缓动系数变量
		 * sprite.y += (targetY – sprite.y) * easing;
		 */
		public static function Easing(angle:Number, origin:Number, easing:Number):Number{
			return (origin - angle) *easing;
		}
		/**
		 * 弹性
		 * vx += (targetX – sprite.x) * spring;//spring为弹性系数
		 * vy += (targetY – sprite.y) * spring;
		 * sprite.x += (vx *= friction);//friction为摩擦力
		 * sprite.y += (vy *= friction);
		 */
		public static function Elasticity(origin:Number, angle:Number, elasticity:Number, friction:Number):Number{
			return (origin - angle) * elasticity * friction;
		}
		
		/**
		 * 偏移弹性公式:
		 * var dx:Number = sprite.x – fixedX;
		 * var dy:Number = sprite.y – fixedY;
		 * var angle:Number = Math.atan2(dy, dx);
		 * var targetX:Number = fixedX + Math.cos(angle) * springLength;
		 * var targetY:Number = fixedX + Math.sin(angle) * springLength;
		 */
		public static function OffsetElasticity():void{
			
		}
		
		/**
		 * 角度旋转
		 */
		public static function Point2Angle(angle:Point, origin:Point):Number{
			return Math.atan2(angle.y - origin.y, angle.x - origin.x) * 180 / Math.PI;
		}
		
		/**
		 * 勾股定理
		 * var dx:Number = p1.x – p2.x;
		 * var dy:Number = p1.y – p2.y;
		 * var dist:Number = Math.sqrt(dx * dx + dy * dy);
		 */
		public static function PythagoreanTheorem(p1:Point, p2:Point):Number{
			return Point.distance(p1, p2);
		}
		
		/**
		 * AS3颜色运算得到透明值
		 */
		public static function Color2Transparent(color:uint):uint{
			return (color&0xff000000)>>>24;
		}
		/**
		 * 十进制转换为十六进制
		 */
		public function Decimal2Hexadecimal(value:uint):String{
			return value.toString(16);
		}
		/**
		 * AS3颜色提取:
		 * var red:uint = color24 >> 16;
		 * var green:uint = color24 >> 8 & 0xFF;
		 * blue = color24 & 0xFF;
		 * alpha = color32 >> 24;
		 * red = color32 >> 16 & 0xFF;
		 * green = color32 >> 8 & 0xFF;
		 * blue = color232 & 0xFF;
		 * 按位计算得到颜色值:
		 * color24 = red < < 16 | green << 8 | blue;
		 * color32 = alpha << 24 | red << 16 | green << 8 | blue;
		 */
		
		/**
		 * 距离碰撞检测
		 */
		public static function Circle2Hit(a:Point, aradius:Number, b:Point, bradius:Number):Boolean{
//			var dx:Number = b.x - a.x;
//			var dy:Number = b.y - a.y;
//			var dist:Number = Math.sqrt(dx*dx + dy*dy);
//			return dist < aradius + bradius;
			return PythagoreanTheorem(a, b) < aradius + bradius;
		}
	}
}