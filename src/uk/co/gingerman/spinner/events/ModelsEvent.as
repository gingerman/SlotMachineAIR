package uk.co.gingerman.spinner.events
{
	import flash.events.Event;
	
	public class ModelsEvent extends Event
	{
		
			public static const MODELS_ALL_READY:String = "MODELS_ALL_READY";
			
			public static const WIN:String = "WIN";
			
			
			//data object
			private var _data:Object;
			
			
			/**
			 * 
			 */
			public function ModelsEvent (type:String, bubbles:Boolean=false, cancelable:Boolean=true, data_object:Object=null):void
			{
				super (type,bubbles,cancelable);
				//			if(data_object!=null)
				//			{
				//				for(var prop:* in data_object)
				//				{
				//					data[prop] = data_object[prop];
				//				}
				//			}
				
				if(data_object!=null)
				{
					//data = new Object();
					data = data_object;
					
				}
			}
			
			
			public function get data():Object
			{
				return _data;
			}
//			
			public function set data(value:Object):void
			{
				_data = value;
			}
			
			
		}//end class
		
	}//end package