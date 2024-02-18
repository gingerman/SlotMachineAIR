package uk.co.gingerman.spinner.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import uk.co.gingerman.spinner.configuration.Config;
	import uk.co.gingerman.spinner.events.ModelsEvent;
	import uk.co.gingerman.spinner.events.XMLGetterEvent;
	import uk.co.gingerman.spinner.model.Balance;
	import uk.co.gingerman.spinner.model.ProbabilityAndReturnTable;
	import uk.co.gingerman.spinner.model.ReelTable;
	import uk.co.gingerman.spinner.model.SymbolTable;
	import uk.co.gingerman.spinner.model.WinObject;
	import uk.co.gingerman.spinner.util.CheckWin;
	import uk.co.gingerman.spinner.util.RandomNumberArray;
	
	public class ModelsController extends EventDispatcher
	{
		private var _testMode:Boolean;
		public var _reeltable:ReelTable;
		public var _symbolTable:SymbolTable;
		public var _probabilityAndReturnTable:ProbabilityAndReturnTable;
		private var _reelTableParsedBool:Boolean;
		private var _symbolsTableParsedBool:Boolean;
		private var _probabilityAndReturnTableParsedBool:Boolean;
		private var _testReelSpinArray:Array;
		private var _testCount:int = 0
		
		public var _balance:Balance;
		
		
		public function ModelsController(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public function test():void{
			
			//_testMode = true;
		}
		
		public function init():void
		{
			if ( _testMode ){
				
				trace ( "Random Numbers Array 3 \n" + RandomNumberArray.GetRandomNumberArray( 3, 30 ) );

				
				
			} else {
				
				_balance = new Balance();
				
				_reeltable = new ReelTable();
				_reeltable.addEventListener( XMLGetterEvent.REEL_TABLE_PARSED, tableParsedEventHandler );
				_reeltable.createTableFromXML( Config.REEL_TABLE_XML_URL );
				
				_symbolTable = new SymbolTable();
				_symbolTable.addEventListener( XMLGetterEvent.SYMBOLS_TABLE_PARSED, tableParsedEventHandler );
				_symbolTable.createTableFromXML( Config.SYMBOLS_TABLE_XML_URL );
				
				_probabilityAndReturnTable = new ProbabilityAndReturnTable();
				_probabilityAndReturnTable.addEventListener( XMLGetterEvent.PROBABILITY_AND_RETURN_TABLE_PARSED, tableParsedEventHandler );
				_probabilityAndReturnTable.createTableFromXML( Config.PROBABILITY_AND_RETURN_TABLE_XML_URL );
				
			}
			
		}
		
		private function ready():void
		{
			//start();
			
			dispatchEvent( new ModelsEvent( ModelsEvent.MODELS_ALL_READY ) );
			
		}
		
		public function detectWin( combination:Array ):WinObject
		{
			//_testReelSpinArray = RandomNumberArray.GetRandomNumberArray( _reeltable._numberOfReels, _reeltable._numberOfSymbols );
			
			trace( "detectWin = "  + combination );
			
			var windetect:WinObject = CheckWin.CheckforWinningCombination( combination, this );
			
			_testCount++;
			
			if ( windetect._winpays <1 ) {
				
				trace( "lose " + _testCount );
				
			} else {
				
				trace( "you win - after " + _testCount + " tries" );
				
				
				dispatchEvent( new ModelsEvent( ModelsEvent.WIN, false, true, windetect ));
				// tell updateLastWinText
			}
			
			return windetect;
		}

		
		protected function tableParsedEventHandler(event:Event):void
		{
			if (event.type == XMLGetterEvent.REEL_TABLE_PARSED ){
				_reelTableParsedBool = true;
			}
			
			if (event.type == XMLGetterEvent.SYMBOLS_TABLE_PARSED ){
				_symbolsTableParsedBool = true;
			}
			if (event.type == XMLGetterEvent.PROBABILITY_AND_RETURN_TABLE_PARSED ){
				_probabilityAndReturnTableParsedBool = true;
			}
			
			if( _reelTableParsedBool && _symbolsTableParsedBool && _probabilityAndReturnTableParsedBool ){
				trace( "data loaded successfully");
				ready();
			}
			
		}		
		
	}
}