package uk.co.gingerman.spinner.model
{
	public class SymbolObject
	{
		
		private var _name:String;
		private var _id:int;
		private var _imageURL:String;
		private var _like:Array; // this symbol is equivalent to 'like' the symbols in this array - optional
		
	
		public function SymbolObject( __nam:String, __id:int, __imageURL:String, __symbolLike:String = "" )
		{
			name = __nam;
			id = __id;
			imageURL = __imageURL;
			like = __symbolLike.split( "," )
		}

		public function get like():Array
		{
			return _like;
		}

		public function set like(value:Array):void
		{
			_like = value;
		}

		public function get imageURL():String
		{
			return _imageURL;
		}

		public function set imageURL(value:String):void
		{
			_imageURL = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}