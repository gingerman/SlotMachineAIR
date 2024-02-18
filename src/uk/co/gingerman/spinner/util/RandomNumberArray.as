package uk.co.gingerman.spinner.util
{
	public class RandomNumberArray extends Object
	{
		
		// you can ask for a million random numbers with a range of 0 to very large
		public static function GetRandomNumberArray( numberOfRandomNumbers:int, rangeFromZero:int ):Array
		{
			var rna:Array = new Array();
			
			for ( var c:int = 0; c < numberOfRandomNumbers; c++ ){
				
				rna[c] = Math.round( Math.random() * rangeFromZero );
				
				
			}
			
			return rna;
		}
	}
}