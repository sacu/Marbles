package com.struct{
	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 30, 2012 12:01:10 PM
	 * 类说明：Map.as, 底图类
	 */
	import flash.display.Sprite;
	
	public class Map_Layer extends Sprite{
		public function Map_Layer()
		{
			super();
			graphics.beginFill(0xcccccc);
			graphics.drawRect(0, 0, 400, 400);
			graphics.endFill();
		}
	}
}