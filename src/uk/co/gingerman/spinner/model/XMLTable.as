package uk.co.gingerman.spinner.model
{
	import flash.events.EventDispatcher;
	
	import uk.co.gingerman.spinner.events.XMLGetterEvent;
	import uk.co.gingerman.spinner.service.XMLGetter;
	
	
	public class XMLTable extends EventDispatcher
	{
		
		private var _XMLGetter:XMLGetter;
		
		public function XMLTable()
		{
		}
		
		public function createTableFromXML( xmlURL:String ):void
		{
			
			_XMLGetter = new XMLGetter();
			_XMLGetter.addEventListener( XMLGetterEvent.XML_LOAD_COMPLETE, gotSymbolXMLHandler )
			
			_XMLGetter.getXML( xmlURL );
			
		}
		
		private function gotSymbolXMLHandler( e:XMLGetterEvent ):void
		{
			trace( "got symbol table xml = "  + e.data );
			parseXML( e.data );
			
		}
		
		public function parseXML ( d:Object ):void{
			
			
		}
	}
}