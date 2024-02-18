package uk.co.gingerman.spinner.util
{
	public class Permute
	{

		
		
		/**
		 * Finds the permutations of an array by recursively permutating sub-arrays
		 *
		 * WARNING! For n elements there are n! permutations - ie. if you have
		 * 6 elements in your array you will find returned an array containing
		 * 6*5*4*3*2 = 720 arrays of your elements. 10 elements returns an
		 * array containing more than 3.5 million arrays, which is not
		 * recommended.
		 *
		 * @param elements The elements to be permutated
		 * @return An array of all of the permutations of the elements in the array.
		 */
		public static function permutate( elements:Array ):Array
		{
			if (elements.length == 1){
				return [elements[0]];
			}
			
			var permutations:Array = [];
			var length:int = elements.length;
			
			var i:int, j:int;
			var tmp:Array;
			var sub:Array;
			
			i = length;
			while (i--)
			{
				tmp = elements.slice( 0, i ).concat( elements.slice(  i + 1, length ) );
				sub = permutate(tmp);
				
				j = sub.length;
				while (j--)
				{
					tmp = [elements[i]].concat(sub[j]);
					
					//if ( wrapper ){
						//tmp = wrapper[0] + tmp + wrapper[1];
					//}
					permutations.push(tmp.join(""));
				}
			}
			
			return permutations;
		}
		
		public static function delimitedPermute( elements:Array, delimiter:String ):String
		{
			/// /\b(abc|acb|cba|cab|bca|bac)\b/g
			//var wrapper:Array = new Array( "[", "]" );
			var permutatedArray:Array = permutate( elements );
			var ret:String = permutatedArray.join( delimiter );
			
			return ret;
			
		}

	}
}