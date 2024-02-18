package uk.co.gingerman.spinner.view
{
	
	import flash.events.Event;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	
	import uk.co.gingerman.spinner.configuration.Config;
	import uk.co.gingerman.spinner.control.Game;
	import uk.co.gingerman.spinner.events.RollerEvent;
	import uk.co.gingerman.spinner.model.SymbolTable;
	
	public class ReelsView extends Sprite
	{
		private var _symbolNamesVector:Vector.<String>;
		public var _numberOfSprites:int;
		private var _game:Game;
		private var _container:Sprite;
		private var _imagesVector:Vector.<Image>;		
		
		private var _currentWinLineSpriteID:Number; // rename ?
		private var _destinationID:Number;
		private var _timeOfAnimation:int;
		private var _numberOfLoops:int;
		private var _finalNumberOfRowsVisible:int = 3; // after animation complete ( eg if 3 - 1 before - 1 middle - 1 after )
		private var _actualNumberOfRowsVisible:int; // as above +1 transitioning in
		private var _numberOfExtraRowsEitherSideVisible:int; // as above +1 transitioning in
		
		private var _spriteHeight:int; 
		private var _startY:int = 250;
		private var _currentPosition:Number;
		private var _animating:Boolean;
		private var _reelOrder:Array;
		private var _symbolTable:SymbolTable;
		public var _decay:Number;
		
		public function ReelsView(  __symbolTable:SymbolTable, sprites:Vector.<String>, reelOrder:Array, game:Game, startPoint:int )
		{
			super();
			
			_symbolTable = __symbolTable;
			_reelOrder = reelOrder;
			_animating = false;
			//_currentWinLineSpriteID = startPoint;
			_currentPosition = startPoint;
			rollerStartPosition = startPoint ;
			trace( "_currentWinLineSpriteID = " + _currentWinLineSpriteID );
			_actualNumberOfRowsVisible = _finalNumberOfRowsVisible + 2;
			_numberOfExtraRowsEitherSideVisible = (_actualNumberOfRowsVisible - 1 )/2
			
			_numberOfSprites = _reelOrder.length;//sprites.length;
			
			_symbolNamesVector = sprites;
			//shuffleObject(_spriteNames);
			_game = game;
			_container = new Sprite();
			addChild( _container );
			
			//placeSprites();
			
			placeSpritesInDefinedOrder();
			
		}
		
		public static function shuffleObject(obj:Object):void{
			var i:int = obj.length;
			while (i > 0) {
				var j:int = Math.floor(Math.random() * i);
				i--;
				var temp:* = obj[i];
				obj[i] = obj[j];
				obj[j] = temp;
			}				
		}
		
//		/**
//		 * Simply add the sprites to the display list and _imagesVector, but do not position them etc 
//		 * 
//		 */		
//		private function placeSprites():void
//		{
//			//var yOffset:int = 0;
//			_imagesVector = new Vector.<Image>;
//			
//			for each ( var spriteName:String in _spriteNamesVector ){
//				
//				trace
//				var thisSpriteName:String = spriteName;
//				var texture:Texture = _game._spriteSheet.getSpriteByName( thisSpriteName );
//				var img:Image = new Image( texture );
//				_imagesVector.push( img );
//				_container.addChild( img );				
//			}
//			
//			_spriteHeight = img.height;
//			
//			
//		}
//		
		/**
		 * Simply add the sprites to the display list and _imagesVector, but do not position them etc 
		 * 
		 */		
		private function placeSpritesInDefinedOrder():void
		{
			trace( '\n\nplaceSpritesInDefinedOrder()' );
			//var yOffset:int = 0;
			var numberOfSprites:int = _reelOrder.length;
				
			_imagesVector = new Vector.<Image>;
			
			
			
			for ( var c:int = 0; c< numberOfSprites; c++ ) {
				
				// use the reel order to place the sprites
				var thisSymbolTypeID:int = _reelOrder[c];
				// _symbolNamesVector[
				var thisSymbolName:String = _symbolTable.getSymbolByID( thisSymbolTypeID ).name
				
				trace( 'thisSpriteName= ' + thisSymbolName );
				var texture:Texture = _game._spriteSheet.getSpriteByName( thisSymbolName );
				var img:Image = new Image( texture );
				_imagesVector[c] = img ;
				_container.addChild( img );				
			}
			
			_spriteHeight = img.height;

			
		}
	
		public function positionSprites( animate:Boolean = false ):void
		{	
			_animating = animate;
			
			var currentSpriteID:int = 0;
			//var decay:Number = 0;
			
			var distanceToDestinationID:Number =  ( _destinationID - 9 ) - _currentPosition;
			
			var minimumKillAnimationDistance:Number = 0.1;
			
			
			
			// if the distance is large enough then animate, if not then kill the animation 
			if ( Math.abs( distanceToDestinationID ) > minimumKillAnimationDistance && distanceToDestinationID!= 0 ){
				
				if ( _animating ){
					//trace( "animating" );
					_decay = _decay * Config.DECAY_MULTIPLIER;// 1.05;
				} else {
					//trace( "distanceToDestinationID = " + distanceToDestinationID );
					_decay = 0;
					//trace( "not animating" );
	
				}
				
				if ( Math.abs( distanceToDestinationID ) < minimumKillAnimationDistance && _animating  )
				{
					distanceToDestinationID = 0;
				 	_currentPosition = _destinationID;
				}
				
				_currentPosition = _currentPosition + ( distanceToDestinationID * _decay );
								
				for each ( var img:Image in _imagesVector ){
					
					var _loopedPosition:Number = normalisedPosition(   _currentPosition - ( currentSpriteID + 1) );
					var newPosY:Number = _startY + ( ( _loopedPosition  ) * _spriteHeight) ;
					img.visible = true;
					img.y = newPosY;
					//img.filter = updateMotionBlur( distanceToDestinationID );
					
					if ( Math.abs( _loopedPosition ) < 2.5 ){
						img.alpha = 1;
					} else {
						//img.alpha = 0.25;	
					}
					currentSpriteID++;
				} 
				
				
			}
			else
			{	
				this.removeEventListener( Event.ENTER_FRAME, handleEnterFrame );	
				dispatchEvent( new RollerEvent( RollerEvent.REEL_STOPPED ) );
				_animating = false;
				
				rollerStartPosition = rollerStartPosition + _numberOfSprites * 2;
			}
		}
		
		public function animate():void
		{
			this.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		private function handleEnterFrame():void
		{
			positionSprites( true );
		}
		
		private function normalisedPosition( pos:Number ):Number
		{
			
			/* the value of the position could be out of rage to display,
			  but the reel is a wrap around device, so the value needs to be mapped on to the reel
			  the reel will have a fixed number of places for symbols ( the number of symbols on the reel )
				So if the reel has 10 places - but the position of the symbol is
				25 - the symbol needs to be placed at 5.
			
				25 % 10 = 5 seems to work
			
				if the symbol is at -3 what happens?
			
				-3 % 10 = -3
			
				So Modulo % seems to solve the problem ( apart from if the figure is negative )
			
				Where should -3 map to?
			
			*/
			
			var normPos:Number = pos % _numberOfSprites;
			
			
			if ( normPos < 0 )
			{
				
				normPos = normPos + _numberOfSprites;
				
			} else if ( normPos > _numberOfSprites ) {
				normPos = normPos - _numberOfSprites;
			}
			
			//trace( "normPos = " + normPos );
			
			return normPos;
		}
		
		public function setRollerDestinationPosition( destination:int ):void
		{
			_destinationID = destination;
			
		}
		
		public function set rollerStartPosition( start:int ):void
		{
			// is this setting the most logical var ??
			_currentPosition = start;
			
		}
		
		public function get rollerStartPosition( ):int
		{
			// is this setting the most logical var ??
			return _currentPosition;
			
		}
		
		public function updateMotionBlur( amountSource:Number ):BlurFilter
		{
			//trace( "updateMotionBlur = " + amountSource );
			var blurAmount:int = Math.floor( amountSource / 500 );
			
			var _blurFilter:BlurFilter = new BlurFilter( 0, blurAmount );
			return _blurFilter;
		}
	}
}