package com.struct{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 30, 2012 12:02:02 PM
	 * 类说明：Object.as,
	 */
	import com.collection.ActionCollection;
	import com.event.SoldierEvent;
	import com.role.Base;
	import com.role.MoveBase;
	import com.role.Soldier;
	import com.utils.Arrow;
	import com.utils.Collide;
	import com.utils.Physical;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Soldier_Layer extends Sprite{
		public var soldiers:Array;//士兵数组
		public var movement:Array;//运动数组
		private var timer:Timer;//只是一个Timer
		
		private var id:uint;//当前士兵下标
		private var current:Soldier;//当前士兵对象
		private var arrow:Arrow;//移动提示箭头
		public function Soldier_Layer()
		{
			super();
			timer = new Timer(0);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			arrow = new Arrow();
			addChild(arrow);
			arrow.visible = false;
			soldiers = [];
			movement = [];
			id = 0;
		}
		/**
		 * 加入一个士兵到战场
		 */
		public function addSoldier(s:Soldier):void{
			if(soldiers.indexOf(s) == -1){
				soldiers.push(s);
				addChild(s);
			}
		}
		/**
		 * 下一个士兵
		 */
		public function nextSoldier():void{
			current = soldiers[id] as Soldier;
			current.selected(true);
			arrow.x = current.x;
			arrow.y = current.y;
			current.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			if(++id >= soldiers.length){
				id = 0;
			}
		}
		/**
		 * 移除一个士兵
		 */
		public function removeSoldier(s:Soldier):void{
			var index:int = soldiers.indexOf(s);
			if(index != -1){
				soldiers.splice(index, 1);
				removeChild(s);
			}
		}
		private function mouseDownHandler(e:MouseEvent):void{
			arrow.visible = true;
			arrow.setAngle(current.mouseX, current.mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function mouseMoveHandler(e:MouseEvent):void{
			arrow.setAngle(current.mouseX, current.mouseY);
		}
		private function mouseUpHandler(e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			current.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			current.buttonMode = false;
			arrow.visible = false;
			current.fire(arrow.angle, arrow.speed);
			movement.push(current);
			timer.start();
			current.selected(false);
			current = null;
		}
		
		public function execution():Boolean{
			for(var i:uint = 0; i <  movement.length; ){
				var s:Soldier = movement[i];
				if(s.execution()){
					var isHit:Boolean;
					isHit = checkSoldier(s);//士兵碰撞检测
					checkBody(s);//刚体碰撞检测
					checkOther(s)//静动可摧毁物体碰撞检测
					++i;
//					if(isHit){//临时这样写,之后正式代码的碰撞不需要停止运行对象
//						movement.splice(i, 1);
//					} else {
//						++i;
//					}
				} else {
					movement.splice(i, 1);
				}
			}
			return movement.length > 0;
		}
		/**
		 * 士兵碰撞检测
		 */
		public function checkSoldier(s:MoveBase):Boolean{
			var check:Base;
			for each(check in soldiers){
				if(check != s && Physical.Circle2Hit(s.position, 8, check.position, 8)){
					conservationOfMomentum(s, check);
					return true;
//					break;
				}
			}
			return false;
		}
		/**
		 * 刚体碰撞检测
		 */
		public function checkBody(s:MoveBase):Boolean{
			return false;
		}
		/**
		 * 静动可摧毁物体碰撞检测
		 */
		public function checkOther(s:MoveBase):Boolean{
			return false;
		}
		/**
		 * 物体动量换算
		 */
		public function conservationOfMomentum(base1:Base, base2:Base):void{
			var c1:Collide = base1.collide;
			var c2:Collide = base2.collide;
			var c1x:Number = c1.speed * Math.cos(c1.angle /180 * Math.PI);
			var c2x:Number = c2.speed * Math.cos(c2.angle /180 * Math.PI);
			var vx:Number = Physical.ConservationOfMomentum(c1.quality + c2.quality, c1x + c2x);
			
			var speedY:Number = c1.speed * Math.sin(c1.angle / 180 * Math.PI);
			//计算双方的 动量守恒 Physical.ConservationOfMomentum
			//获取出来以后给base1.collide和 base1.collide的碰撞系数赋值
//			base1.collide方法需要自己写下
//			赋值完毕后加入到 movement数组里
		}
		private function timerHandler(e:TimerEvent):void{
			if(!execution()){
				timer.stop();
				nextSoldier();
			}
		}
	}
}