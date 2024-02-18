package uk.co.gingerman.spinner.model
{

	import uk.co.gingerman.spinner.events.XMLGetterEvent;
	import uk.co.gingerman.spinner.service.XMLGetter;

	/**
	 * 
	 * @author gingerman
	 * A Reel table is the structure of all the reels on a slot machine - ( the order of the icons, number of reels, mapping etc ) 
	 */	
	public class ReelTable extends XMLTable
	{
		private var _XMLGetter:XMLGetter;
		public var _numberOfSymbols:int;
		public var _numberOfReels:int;
		private static var _reelsArray:Array;
		
		
	
		


		override public function parseXML ( d:Object ):void{
			
			var xml:XML = new XML( d );
			_reelsArray = new Array();
			var numberOfSymbols:int = 0;
			
			var c:int = 0;
			
			for each( var reel:String in xml.reel ){
				
				var singleReelArray:Array = reel.split(",");
				
				
				// check reels are the same length
				if ( numberOfSymbols == singleReelArray.length || numberOfSymbols == 0 ){
					numberOfSymbols = singleReelArray.length;
					//trace( "numberOfSymbols = " + numberOfSymbols );
				} else {
					//trace( "Error previous reel length = " + numberOfSymbols + "\nDoes not match this reel length = " + singleReelArray.length ); 
				}
				// end of check - perhaps throw an error in future
				
				_reelsArray[c] = singleReelArray;
				_numberOfSymbols = numberOfSymbols;
				
				c++;
				
				_numberOfReels = c; 
				
			}
			
			//trace ( "_numberOfReels = " + _numberOfReels );
			
			dispatchEvent(new XMLGetterEvent( XMLGetterEvent.REEL_TABLE_PARSED ));
		
			
		}
		
		public static function translateToSymbolIds( permutationsArray:Array ):Array
		{
			var translatedArray:Array = new Array();
			
			var reel:int = 0;
			var count:int = 0;
			
			for each( var permutationCell:int in permutationsArray ){
				
				translatedArray[count] = _reelsArray[ count ][ permutationCell ];
				
				count++;
				
			}
			
			return translatedArray;
				
		}
		
		public function getReelArrayByID( id:int ):Array
		{
			return _reelsArray[ id ];
		}
		
		
		public function getRealSymbolID( realID:int, positionID:int ):int
		{
			
			return getReelArrayByID( realID )[ positionID ];
			
		}
		
	
		

		
	}
}