package uk.co.gingerman.spinner.view
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	
	
	import uk.co.gingerman.spinner.configuration.Config;
	import uk.co.gingerman.spinner.model.WinObject;
	
	public class BalanceFeedbackView extends Sprite
	{
		private var _container:Sprite;
		private var _balanceText:TextField;
		private var _lastWinText:TextField;
		
		public function BalanceFeedbackView()
		{
			super();
			
			_container = new Sprite();
			addChild( _container );
			_balanceText = new TextField( 500, 100, "Balance:","Verdana",25 );
			_balanceText.border = true;
			_balanceText.x = 40;
			_balanceText.y = 120;
			_container.addChild( _balanceText );
			
			_lastWinText = new TextField( 500,100, "Last Win Amount:","Verdana",25 );
			_lastWinText.x = 40;
			_lastWinText.y = 0;
			_lastWinText.border = true;
			
			//_lastWinText.align = "left";
			
			
			
			//var textFormat:TextFormat = new TextFormat();
			//textFormat.align = TextFormatAlign.LEFT;
			
			//.
			_container.addChild( _lastWinText );
		
		}
		
		public function updateBalanceText( i:int ):void
		{
			
			_balanceText.text = "Balance: £"+i;
			
		}
		
		public function updateLastWinText( wO:WinObject ):void
		{
			
			_lastWinText.text = "Last win was: "+wO._winname + "\nYou won: " + wO._winpays *Config.STAKE_MINIMUM;
			
		}
	}
}