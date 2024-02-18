/** * extends event class to add a data object */package uk.co.gingerman.spinner.events{		import starling.events.Event		/**	 * 	 */	public dynamic class RollerEvent extends Event	{				public static const TEXTURE_ATLAS_LOADED_COMPLETE:String 			= "TEXTURE_ATLAS_LOADED_COMPLETE";		public static const REEL_STOPPED:String 							= "REEL_STOPPED";		public static const ALL_REELS_STOPPED:String 						= "ALL_REELS_STOPPED";						//data object		private var _data:Object;						/**		 * 		 */		public function RollerEvent (type:String, bubbles:Boolean=false, cancelable:Boolean=true, data_object:Object=null):void		{			super (type,bubbles,cancelable);//			if(data_object!=null)//			{//				for(var prop:* in data_object)//				{//					data[prop] = data_object[prop];//				}//			}						if(data_object!=null)			{				//data = new Object();				data = data_object;							}		}				public override function get data():Object
		{
			return _data;
		}		public function set data(value:Object):void
		{
			_data = value;
		}					}//end class	}//end package