package uk.co.gingerman.spinner.model
{
	import uk.co.gingerman.spinner.events.XMLGetterEvent;
	import uk.co.gingerman.spinner.service.XMLGetter;

	
	public class SymbolTable extends XMLTable
	{
		private var _XMLGetter:XMLGetter;
		private var _symbolsArray:Array;
		
		
		public function SymbolTable()
		{
			super();
						
		}
		
		
		override public function parseXML ( d:Object ):void{
			
			var xml:XML = new XML( d );
			_symbolsArray = new Array();
			var numberOfSymbols:int = 0;
			
			
			for each( var symbol:XML in xml.symbol ){
				
				//var _numberOfReels:int = _reelsArray.push( singleReelArray );
				//trace( "-- Symbol name = " + symbol.name + "\t\t\t id:" + numberOfSymbols + "\t\t\t graphic name = " + symbol.image );
				
				
				var symbolObject:SymbolObject = new SymbolObject( symbol.name, symbol.id, symbol.image, symbol.like );
				_symbolsArray[numberOfSymbols] = symbolObject;
				
				numberOfSymbols++;
			}
			
			//trace ( "numberOfSymbols = " + numberOfSymbols );
			
			dispatchEvent( new XMLGetterEvent( XMLGetterEvent.SYMBOLS_TABLE_PARSED ) )
			
		}
		
		
		
		
		public function getSymbolByID( id:int ):SymbolObject
		{
			var ret:SymbolObject = _symbolsArray[ id ];
			
			return ret;
			
		}
		
		public function getSymbolEquivalents( id:int ):Array
		{
			var ret:Array = _symbolsArray[ id ].like;
			
			
			
			if ( ret == [] )
			{
				ret[0] = id;
			}
			//trace( "getSymbolEquivalents = " + ret );
			return ret;

			
		}

	}
}

