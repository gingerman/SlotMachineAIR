package
{
	
	//import com.milkmangames.nativeextensions.GoViral;
	
	// import flash.display.Bitmap;
	// import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	//import starlingView.StarlingMain;
	
	//import uk.co.gingerman.configuration.Const;
	import uk.co.gingerman.spinner.configuration.Config;
	import uk.co.gingerman.spinner.control.Game;
	
	// steve
	
	
	[SWF(width="720", height="1280", frameRate="60", backgroundColor="#fabfab")]
		
	public class SlotMachineGame extends Sprite
	{
		private var _starling:Starling;

		

		
		public function SlotMachineGame()
		{
			
			super();
			addEventListener( Event.ADDED_TO_STAGE, init )
		}

		
		private function init( e:Event ):void
		{
			trace( "ADDED_TO_STAGE" );
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener( Event.RESIZE, handleResize );
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onOrientationChanging);
			
		}
		
		
		private function onOrientationChanging(e:StageOrientationEvent):void {
			/// don't change onOrientationChange always portrait :)
			stage.setAspectRatio( StageAspectRatio.PORTRAIT);
		}
		
		
		protected function handleResize(event:Event):void
		{			
			Config._viewWidth = stage.fullScreenWidth
			Config._viewHeight = stage.fullScreenHeight			
			
			// remove listener necause there is sometimes more than 1 event - also it's a good idea to do that unless you need to 
			stage.removeEventListener(Event.RESIZE, handleResize);
			
			startStarling();
		}	

		
		protected function startStarling(event:Event = null):void
		{
			
			trace( "Config._viewWidth, Config._viewHeight = " + Config._viewWidth + " x " + Config._viewHeight );
			
			var _starlingViewPortRect:Rectangle = new Rectangle( 0, 0, Config._viewWidth, Config._viewHeight );
			
			_starling = new Starling( Game, stage, _starlingViewPortRect );
			_starling.start();
			_starling.showStats = true;
			
		}
				
		private function initStarling():void
		{
//			Starling.handleLostContext = true;
//			Starling.multitouchEnabled = true;
//			
//			trace( "w= " + Const._viewWidth + " h= " +Const._viewHeight  );
//			
//			_starlingViewPortRect = new Rectangle( 0, 0, Const._viewWidth, Const._viewHeight );
//			
//			_starling = new Starling( StarlingMain, this.stage, _starlingViewPortRect );
//			_starling.enableErrorChecking = false;
//			_starling.showStats = false;
//			// _starling.start();
			
			startStarling();
			
		}
	}
}