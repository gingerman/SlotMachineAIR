package uk.co.gingerman.spinner.service
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import uk.co.gingerman.spinner.events.XMLGetterEvent;
	
	public class XMLGetter extends EventDispatcher
	{
		private var _xml:XML;
		private var _loader:URLLoader;
		
		public function XMLGetter(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function getXML( XML_URL:String):void
		{
			
			
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, XMLLoadedEventHandler );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, IOERRORErrorEventHandler );
			_loader.load( new URLRequest( XML_URL ) );
			
		}
		
		protected function XMLLoadedEventHandler( event:Event ):void
		{
			_xml = new XML( _loader.data );
			
			//trace( "XMLLoadedEventHandler \n" + _xml + "\n" );
			
			dispatchEvent( new XMLGetterEvent( XMLGetterEvent.XML_LOAD_COMPLETE, false, true, _xml ) );
			
		}
		
		protected function IOERRORErrorEventHandler( event:Event ):void
		{
			
			trace( "IOERRORErrorEventHandler \n" + event + "\n" );
			
			
		}
	}
}