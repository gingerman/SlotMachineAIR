package uk.co.gingerman.spinner.model
{
	import flash.events.EventDispatcher;
	
	import uk.co.gingerman.spinner.events.XMLGetterEvent;
	import uk.co.gingerman.spinner.service.XMLGetter;

	
	public class ProbabilityAndReturnTable extends XMLTable
	{
		private var _XMLGetter:XMLGetter;
		public static var _winTypeArray:Array;
		public static var _numberOfPossibleWinBasicCombinations:int;
		
		
//		public function ProbabilityAndReturnTable()
//		{
//			super();
//						
//		}
		
		
		override public function parseXML ( d:Object ):void{
			
			var xml:XML = new XML( d );
			_winTypeArray = new Array();
			var numberOfWins:int = 0;
			
			
			for each( var win:XML in xml.win ){
				
				//var _numberOfReels:int = _reelsArray.push( singleReelArray );
				//trace( "-- Win name = " + win.name + "\t\t combination:" + win.combination + "\t\t\t pays out = " + win.pays );
				
				var winObject:WinObject = new WinObject( win.name, win.combination, win.pays, win.probability);
				_winTypeArray.push( winObject )
				
				numberOfWins++;
			}
			
			//trace ( "numberOfWins = " + numberOfWins );
			
			_numberOfPossibleWinBasicCombinations = numberOfWins;
			
			dispatchEvent( new XMLGetterEvent( XMLGetterEvent.PROBABILITY_AND_RETURN_TABLE_PARSED ) );
			
		}
		
		public static function getWinTypeObject( id:int ):WinObject
		{
			var winObj:WinObject = _winTypeArray[ id ];
			return winObj;
		}

	}
}

