package uk.co.gingerman.spinner.model
{
	import uk.co.gingerman.spinner.configuration.Config;
	
	public class Balance
	{
		
		private var _amount:int; 
		
		public function Balance()
		{
			amount = Config.INITIAL_BALANCE;
		}
		
		public function spend( spendAmount:int ):void
		{
			
			amount = amount - spendAmount;
		}
		
		public function win( winAmount:int ):void
		{
			
			amount = amount + winAmount;
		} 

		public function get amount():int
		{
			return _amount;
		}

		public function set amount(value:int):void
		{
			_amount = value;
		}

	}
}