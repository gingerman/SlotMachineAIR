package uk.co.gingerman.spinner.model
{
	public class WinObject extends Object
	{
		public var _winname:String;
		public var _wincombination:String;
		public var _winpays:int
		public var _winprobability:int;
		
		public function WinObject( winname:String ="" , wincombination:String ="" , winpays:int = 0 , winprobability:int = 0 )
		{
			_winname = winname;
			_wincombination = wincombination;
			_winpays = winpays
			_winprobability = winprobability;
		}
	}
}