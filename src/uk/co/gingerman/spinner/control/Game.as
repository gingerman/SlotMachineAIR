package uk.co.gingerman.spinner.control
{
	import flash.events.Event;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	import uk.co.gingerman.spinner.control.ModelsController;
	import uk.co.gingerman.spinner.events.ModelsEvent;
	import uk.co.gingerman.spinner.events.RollerEvent;
	import uk.co.gingerman.spinner.model.WinObject;
	
	public class Game extends Sprite
	{
		public var _spriteSheet:SpriteSheet;
		private var _graphicsController:GraphicsController;
		public var _usingHardware:Boolean;
		private var _modelsController:ModelsController;
		
		public function Game()
		{
			_usingHardware = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			trace( "Hardware rendering = " + _usingHardware );	
			
			setUp();
			
		}
		
		private function setUp():void
		{
			
			_modelsController = new ModelsController();
			_modelsController.init();
			_modelsController.addEventListener( ModelsEvent.MODELS_ALL_READY , handleAllModelsReadyEvent );
			
			_modelsController.addEventListener( ModelsEvent.WIN , handleWinEvent );

			
			
		}
		
		protected function handleWinEvent( event:ModelsEvent ):void
		{
			_graphicsController._balanceFeedBackView.updateLastWinText( event.data as WinObject );
			
		}
		
		protected function handleAllModelsReadyEvent(event:Event):void
		{
			createSpriteSheet( );
			
		}
		
		private function createSpriteSheet():void
		{
			_spriteSheet = new SpriteSheet( );
			_spriteSheet.addEventListener( RollerEvent.TEXTURE_ATLAS_LOADED_COMPLETE, doTextureAtlasLoadedHandler )
			
		}		
		
		private function doTextureAtlasLoadedHandler( re:RollerEvent):void
		{			
			_graphicsController = new GraphicsController( this, _modelsController );
			_graphicsController.drawScreen()
			
		}
		
	}
	
}