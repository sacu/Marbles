package com.event{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 30, 2012 6:13:24 PM
	 * 类说明：SoliderEvent.as,
	 */
	import com.role.Soldier;
	
	import flash.events.Event;
	
	public class SoldierEvent extends Event{
		public var current:Soldier;
		public function SoldierEvent(type:String, soldier:Soldier)
		{
			this.current = soldier;
			super(type, false, false);
		}
	}
}