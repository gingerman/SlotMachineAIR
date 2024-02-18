/**
 * 
 * @author gingerman
 * An attempt at efficiently checking out a win of any order from a list of known wins
 */	

package uk.co.gingerman.spinner.util
{

	import flash.display.Sprite;
	
	import uk.co.gingerman.spinner.configuration.Config;
	import uk.co.gingerman.spinner.control.ModelsController;
	import uk.co.gingerman.spinner.model.ProbabilityAndReturnTable;
	import uk.co.gingerman.spinner.model.WinObject;
	import uk.co.gingerman.spinner.util.Permute;
	
		
	
	public class CheckWin extends Sprite
	{
		private static var _inputCombination:Array;
		private static var _modelsController:ModelsController;
		
		
		
		/**
		 * Input an array ( the combination of Symbol IDs from the slot machine )
		 * To find out whether ther has been a win.
		 * Outputs the best possible Win Object, as there may be more than one.
		 * 
		 * Also check whether any sybols have more than one alternate ( some have 2 alternatives )
		 * Explore all of those alternatives  eg 10,1,5 - could be 2 possible alternatives as symbol ID 
		 * 10 stands for 2 other symbols.
		 * 
		 * Also check every combination of the alternative checked sequences are checked against the 
		 * probability and return table to see if there are wins, and decide which is the greatest value 
		 * if there are more than one win
		 * 
		 *  
		 * @param inputCombination
		 * @param __ModelsController
		 * @return 
		 * 
		 */		
		public static function CheckforWinningCombination( inputCombination:Array, __ModelsController:ModelsController ):WinObject
		{	
			_modelsController = __ModelsController;
			
			// check for alternative sequences
			var alternateSequences:Array = getAlternatePossibleSequences( inputCombination );
			
			var win:WinObject = new WinObject();
			
			// check each sequence for wins ( there may be just one ) 
			for each ( var sequenceCombinationString:String in alternateSequences ){
								
				var sequenceCombinationArray:Array = sequenceCombinationString.split("");				
				var tempWin:WinObject;
				
				if ( Config.ALL_PERMUTATIONS_MODE ){
					
					var delimitedPermutation:String = Permute.delimitedPermute( sequenceCombinationArray, "|" );
					tempWin = checkForWin(delimitedPermutation);
					//trace ( "delimitedPermutation " + delimitedPermutation  );
					
				} else {
					
					var nonPermutedString:String = sequenceCombinationArray.join("");
					
					tempWin = checkForWin( nonPermutedString );
				}
				
				trace( "win._winpays = " + win._winpays );
				trace( "tempWin._winpays = " + tempWin._winpays );
				
				if ( win._winpays < tempWin._winpays  ){
					win  = tempWin;
				}
				//trace( "returning win = " + win );
				
			}
			
			return win;
		}
		
		
		private static function checkForWin( permutationsOfSequence:String ):WinObject
		{
			
			var tempWinObjectArray:Array;
			var win:Boolean = false;
			var winReturnObject:WinObject = new WinObject( 'null', "0", 0, 1000000);
						
			var numberOfWinCombinationsCountCheck:int = ProbabilityAndReturnTable._numberOfPossibleWinBasicCombinations;
			var winCombosArray:Array = ProbabilityAndReturnTable._winTypeArray;
			
			for ( var w:int = 0; w<winCombosArray.length ; w++ ){
				
				var thisWinObjString:String = ProbabilityAndReturnTable.getWinTypeObject(w)._wincombination;
				
				var thisWinString:String = thisWinObjString.split(",").join("");
				
				//trace( "checkForWin >> thisWinString = " + thisWinString );
				
				var regex:RegExp = new RegExp("\\b(" + thisWinString + ")\\b","/g");
				
				//trace( "regex for(" + thisWinObjString.split(",").join("") + ") = " + regex.test( permutationsOfSequence ) );
				
				if ( regex.test( permutationsOfSequence ) ){
					
					//trace( " ProbabilityAndReturnTable.getWinTypeObject(w)._winpays = "+ ProbabilityAndReturnTable.getWinTypeObject(w)._winpays );
					//trace( " winReturnObject._winpays = " + winReturnObject._winpays )		
					
						
						if( ProbabilityAndReturnTable.getWinTypeObject(w)._winpays > winReturnObject._winpays )
						{
							winReturnObject = ProbabilityAndReturnTable.getWinTypeObject(w);
						}
						
					
				}
				
			}			
			
			return winReturnObject;
			
		}
		
		/**
		 * 
		 * Sometimes a symbol represents 2 other symbols
		 * It's value won't be in any win lines, so we search to see if any of the 
		 * symbols do represent any others, then we return an array of ( 2 ) arrarys 
		 * for win checking.
		 * We don't disregard the array fed in - but add it to the array of arrays returned
		 * as it could contain 1 or more other valid win combinations
		 * 
		 * @param sequence
		 * @return 
		 * 
		 */		
		private static function getAlternatePossibleSequences(sequence:Array):Array
		{
//			var testArr:Array = new Array ( 10,11,10 ); // test sequence ( for debug - remove )
//			sequence = testArr;
			
			/*
			// for the test value above 
			so 3 is a valid value
			10 is equivalent to 3 and 6
			11 is equiv to 7 and 1
			therefore we need to test 
			
			3,7,3
			3,7,6
			3,1,3
			3,1,6
			6,7,3
			6,7,6
			6,1,3
			6,1,6
			
			( like binary ? )
			
			ab  - possible equivalents 
			cd
			ef
			
			ace
			bce
			ade
			bde
			acf
			bcf
			adf
			bdf
			
			so find 3 arrays of possible equivs
			loop through the first until exhausted
			update the second - reset the first
			repeat until second is exhausted
			reset second and first 
			update third
			
				
			*/
			
			// pull each symbol equivalent out - or not and place them into arrays - in to an array
			var numberOfCombinations:int = 1;
			var equivalentsArray:Array = new Array();
			
			for each ( var itemInSequence:Number in sequence )
			{
				var symbolEquivalents:Array = _modelsController._symbolTable.getSymbolEquivalents( itemInSequence )		
				equivalentsArray.push( symbolEquivalents );
				numberOfCombinations = numberOfCombinations * symbolEquivalents.length;
			}
		
						
			var alternativeSequences:Array = [];
			//alternativeSequences[0] = sequence;
			
			var sequenceElementID:int = 0;
			
			for each ( var symbolID:Number in sequence )
			{
				// there's only possibly going to ever be 2 equivs
				var equivalents:Array = _modelsController._symbolTable.getSymbolEquivalents( symbolID );
				//so
				if ( equivalents.length < 2 ){
					
					equivalents[0] = symbolID;
					equivalents[1] = symbolID;
					
				}
				
				//trace( " equivalent for " + symbolID + " is " + _modelsController._symbolTable.getSymbolEquivalents( symbolID ) );
				
				alternativeSequences[ sequenceElementID ] = equivalents
								
				sequenceElementID++;
				
			}
			
			trace( "alternativeSequences = " + alternativeSequences[0] );
			var equivalentsCombinations:Array = allPossibleCases( alternativeSequences );
			trace( "equivalentsCombinations = " + equivalentsCombinations );
			
			return equivalentsCombinations;
		}
		
		
		/**
		 * 
		 * feed in an array of arrays, to find every combination of those arrays without changing their order
		 * 
		 * so ( [3,6],[5,4],[3,6] )
		 * becomes ( 353,653,343,643,356,656,346,646 )
		 * 
		 * so ( [3,6],[5,5],[3,6] ) 
		 * actually becomes ( 353,653,353,653,356,656,356,656 )
		 * It's itereating over the middle array which is two 5s so it looks like it's duplicating results
		 * 
		 * @param arr
		 * @return 
		 * 
		 */		
		private static function allPossibleCases( arr:Array ):Array {
			
			trace( "allPossibleCases input = " + arr )
			
			if (arr.length == 1) {
				
				return arr[0];
				
			} else {
				
				var result:Array = [];
				
				var allCasesOfRest:Array = allPossibleCases( arr.slice(1) ); // recur with the rest of array
				
				for ( var i:int = 0; i < allCasesOfRest.length; i++ ) {
					
					for ( var j:int = 0; j < arr[0].length; j++ ) {
						
						var toPush:String = arr[0][j] +""+ allCasesOfRest[i] ;
						
						result.push( toPush );
						
					}
					
				}
				trace( "allPossibleCases output = " + result )
				
				return result;
				
			}
		}
		
		private static function findRecursiveCombinations( equivalentsArray:Array ):Array
		{
			
//			ace
//			bce
//			ade
//			bde
//			acf
//			bcf
//			adf
//			bdf
			
			if ( equivalentsArray.length == 1 )
			{
				return equivalentsArray[0];
			} else {
			
			var lengthArray:int = equivalentsArray.length;
			
			while( lengthArray-- ){
				
				var thisArrayElement:Array = equivalentsArray.pop();
				
				for each ( var arrayValue:Array in thisArrayElement )
				{
					
					trace( "arrayValue = " +arrayValue );
					
					//findRecursiveCombinations( thisArrayElement );
					
				}
				
			}
		}
	
			return null;
	}		
		
//		private static function checkStraightMatches():void
//		{
//			// TODO Auto Generated method stub
//			
//		}		
	}
}