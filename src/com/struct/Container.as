package com.struct{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 30, 2012 12:01:52 PM
	 * 类说明：Container.as, 容器类。
	 * 保函底图，士兵等层级
	 */
	import com.collection.ActionCollection;
	import com.event.SoldierEvent;
	import com.role.Soldier;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Container extends Sprite{
		private var mapLayer:Map_Layer;//底图层实例
		private var soldierLayer:Soldier_Layer;//士兵层
		public function Container()
		{
			super();
			mapLayer = new Map_Layer();
			soldierLayer = new Soldier_Layer();
			addChild(mapLayer);
			addChild(soldierLayer);
			init();
		}
		public function init():void{
			for(var i:uint = 0; i < 3; ++i){
				var s:Soldier = new Soldier();
				s.init(2 - Math.random(), 2 - Math.random(), 2 - Math.random(), 2 - Math.random());
				s.x = mapLayer.width * Math.random();
				s.y = mapLayer.height * Math.random();
				soldierLayer.addSoldier(s);
			}
			soldierLayer.nextSoldier();
		}
	}
}