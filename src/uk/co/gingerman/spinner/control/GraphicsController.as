package uk.co.gingerman.spinner.control
{
	import flash.display.Bitmap;
	import flash.utils.setTimeout;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	
	import uk.co.gingerman.spinner.configuration.Config;
	import uk.co.gingerman.spinner.control.ReelsViewsArray;
	import uk.co.gingerman.spinner.events.RollerEvent;
	import uk.co.gingerman.spinner.model.WinObject;
	import uk.co.gingerman.spinner.view.BalanceFeedbackView;
	import uk.co.gingerman.spinner.view.ReelsView;
	
	
	
	public class GraphicsController
	{
		[ Embed( source = "/assets/mask.png" ) ] 
		private static const TempMask:Class;
		
		[ Embed( source = "/assets/button.png" ) ] 
		private static const TempButton:Class;
		
		private var _masker:Sprite;
		
		private var _game:Game;
		private var _roller:ReelsView;
		private var _buttonHolder:Sprite;
		private var _reelsViewsArray:Array;
		private var butt:Button;
		private var _numberOfRollersToDetectStopped:int;
		
		private var _modelsController:ModelsController;
		public var _balanceFeedBackView:BalanceFeedbackView;
		private var _winSequence:Array;

		
		
		
		public function GraphicsController( game:Game, modelsController:ModelsController )
		{
			_game = game;
			_modelsController = modelsController; // access to all the models
			
		}
		
		
		
		public function drawScreen():void
		{
			
			addRollers();
			
			addRollerMask();
			
			addStartButton();
			
			addBalanceFeedback();
			
			initRollers();
			
			butt.addEventListener( Event.TRIGGERED, startRollers ); 
			
		}
		
		private function addBalanceFeedback():void
		{
			_balanceFeedBackView = new BalanceFeedbackView();
			_game.addChild( _balanceFeedBackView );
			
		}		

		
		private function addRollers():void
		{
			_reelsViewsArray = new Array();
			var currentOffsetX:Number = + Config.ROLLER_OFFSET_X
			
			for ( var c:int = 0; c < _modelsController._reeltable._numberOfReels ; c++ ){
				
				var numberOfSprites:int = _modelsController._reeltable._numberOfSymbols;
				var numberOfLoops:int = 5;

				var startPoint:int = Number( Math.round( Math.random() * numberOfSprites  ) + ( numberOfLoops * numberOfSprites ) );
				var reelTableOrder:Array =  _modelsController._reeltable.getReelArrayByID(c);
				
				_roller = new ReelsView( _modelsController._symbolTable, _game._spriteSheet._texvector, reelTableOrder, _game, startPoint );
				
				
				
				_roller.x = ( c * Config.ROLLER_WIDTH ) + currentOffsetX; //
				_roller.y = Config.ROLLER_OFFSET_Y;
				_game.addChild( _roller );
				_reelsViewsArray[c] = _roller ;
				
				currentOffsetX = currentOffsetX + Config.ROLLER_OFFSET_GAP ;
			}
			
		}		
		
		
		public function initRollers():void
		{
			trace( "initRollers" );
			var numberOfRollers:int = _reelsViewsArray.length;
			var animateTime:Number = 3;
			
			 _winSequence = new Array();
			var winSequenceNames:Array = new Array();
			
			for ( var c:int = 0; c < numberOfRollers ; c++ ){
				
				// select ROLLER
				var thisRoller:ReelsView = _reelsViewsArray[c];
				thisRoller.addEventListener( RollerEvent.REEL_STOPPED, checkReelsStoppedHandler );
				var destinationPoint:Number = getWinDestination( _modelsController._reeltable._numberOfSymbols );
				thisRoller.setRollerDestinationPosition( destinationPoint );
				animateTime = animateTime + Math.random() * 1;
				thisRoller.positionSprites( false );
				//thisRoller.animate();
				
				
				_winSequence[c] = _modelsController._reeltable.getReelArrayByID( c )[ destinationPoint ];
				winSequenceNames[c] = _modelsController._symbolTable.getSymbolByID( _winSequence[c] );
				//winSequenceNames[c] = _modelsController._symbolTable.
				
					
			}
			
			_numberOfRollersToDetectStopped = numberOfRollers;
			
			trace( "winSequence arr = " + _winSequence );
			trace( "winSequenceNames = " + winSequenceNames[0].name, winSequenceNames[1].name, winSequenceNames[2].name );
			
			
			// win sequence to symbol names
		}
		
		private function getWinDestination( numberOfDestinations:int ):Number
		{
			var destination:Number = Math.floor( Math.random() *  numberOfDestinations );
			trace( "++ WinDestination = " + destination );

			return destination;
		}
		
		private function startRollersAfterDelay( delayInMilliseconds:int ):void {
			
			setTimeout(startRollers, delayInMilliseconds );
		}
		
		
		public function startRollers():void
		{
			
			_modelsController._balance.spend( Config.STAKE_MINIMUM );
			_balanceFeedBackView.updateBalanceText( _modelsController._balance.amount );
			
			initRollers();
			butt.enabled = false;
			
			var numberOfRollers:int = _reelsViewsArray.length;
			
			for ( var c:int = 0; c < numberOfRollers ; c++ ){
				var thisRoller:ReelsView = _reelsViewsArray[c];
				thisRoller._decay = Config.REELS_MOVEMENT_DECAY;
				thisRoller.animate();
			}
		}
		
		
		
		private function checkReelsStoppedHandler():void
		{				
			if ( --_numberOfRollersToDetectStopped == 0 ){
				trace( "checkReelsStoppedHandler >> all Reels stopped <<" );
				butt.enabled = true;
				
				
				checkWin( _winSequence );
				
				if( Config.DEBUG_CONTINUOUS_MODE ){
					startRollersAfterDelay( Config.DEBUG_CONTINUOUS_MODE_DELAY ); //uncomment for continuous test mode
				}
			}	
			
		}
		
		private function checkWin( winSequence:Array ):void
		{
			
			
			var wintestsequence:Array = winSequence; //new Array( 3,3,3 ); //
				
			var winObject:WinObject = _modelsController.detectWin( wintestsequence);// winSequence );//wintestsequence );
			
			
			
			if ( winObject != null){
				
				trace( "- winObject pays " + winObject._winpays + "x" );
				trace( "- winObject combination " + winObject._wincombination  );
				trace( "- winObject name " + winObject._winname  );
				
			
				var winMultiplier:Number = winObject._winpays;
				var winAmount:int = Config.STAKE_MINIMUM * winMultiplier;
				
				_modelsController._balance.amount = _modelsController._balance.amount + winAmount;
				_balanceFeedBackView.updateBalanceText( _modelsController._balance.amount );
			}
			
		}
		
		private function addStartButton():void
		{
			var tb:Bitmap = new TempButton()
			var buttTexture:Texture = Texture.fromBitmap( tb );
			butt = new Button( buttTexture, "go");
			butt.x = 500;
			butt.y = 246;
			_game.addChild(butt);
			
		}
		
		private function addRollerMask():void
		{
			_masker = new Sprite();
			var tm:Bitmap = new TempMask()
			var bgTexture:Texture = Texture.fromBitmap( tm );
			var _tempMaskImage:Image = new Image( bgTexture );
			_masker.addChild( _tempMaskImage );
			//_masker.width = 1000;
			_game.addChild( _masker );
			
		}
	}
}