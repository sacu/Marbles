package com.role{
	import com.collection.ConfigCollection;
	import com.utils.Collide;

	/**
	 * 创建者：薛恒杰
	 * 工程名称：Marbles
	 * 创建时间：Jul 31, 2012 1:06:27 PM
	 * 类说明：CycleBase.as,
	 */
	public class CycleBase extends Base{
		protected var life:Number;//生命
		protected var quality:Number;//质量
		protected var speed:Number;//速度
		protected var defense:Number;//防御
		public function CycleBase()
		{
			super();
		}
		//生命、力量、速度、防御 的百分比
		public function init(life:Number, quality:Number, speed:Number, defense:Number):void{
			this.life = life * ConfigCollection.BaseLife;
			this.quality = quality * ConfigCollection.BaseQuality;
			this.speed = speed * ConfigCollection.BaseSpeed;
			this.defense = defense * ConfigCollection.BaseDefense;
			_collide = new Collide(quality);
		}
	}
}