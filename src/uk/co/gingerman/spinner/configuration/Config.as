package uk.co.gingerman.spinner.configuration
{
	public class Config extends Object
	{
		
		// Set width and height of the webcam. after The resize event has been recieved info from stage.fullScreenWidth etc
		public static var _viewWidth:int;	
		public static var _viewHeight:int;
		
		public static var ALL_PERMUTATIONS_MODE:Boolean = true; // if true the result of symbols are permutated 
																 // and each combination checked for a win
		
		public static var REEL_TABLE_XML_URL:String = "xml/reeltable.xml";
		
		public static var SYMBOLS_TABLE_XML_URL:String = "xml/symbolstable.xml";
		
		public static var PROBABILITY_AND_RETURN_TABLE_XML_URL:String = "xml/probabilityandreturntable.xml";
		
		public static var SYMBOLS_SPRITE_SHEET:String = "assets/slotsymbols_160.png";
		
		public static var SYMBOLS_SPRITE_SHEET_TEXTURE_ATLAS:String = "assets/slotsymbols_160.xml";
		
		public static var REELS_MOVEMENT_DECAY:Number = 0.055;
		
		public static var DECAY_MULTIPLIER:Number = 1.05;
		
		public static var STAKE_MINIMUM:Number = 10;
		
		public static var INITIAL_BALANCE:Number = 1000;
		
		public static var ROLLER_WIDTH:Number = 160;
		public static var ROLLER_HEIGHT:Number = 160;
		public static var ROLLER_OFFSET_X:Number = 36;
		public static var ROLLER_OFFSET_Y:Number = -1394;
		public static var ROLLER_OFFSET_GAP:Number = 5;
		
		public static var DEBUG_CONTINUOUS_MODE:Boolean = true;
		
		public static var DEBUG_CONTINUOUS_MODE_DELAY:int = 300; // milliseconds

	}
}