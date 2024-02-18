package uk.co.gingerman.spinner.control
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import uk.co.gingerman.spinner.events.RollerEvent;
	
	import uk.co.gingerman.spinner.configuration.Config;

	public class SpriteSheet extends Sprite
	{
		private var _atlasTexture:Texture;
		private var _atlasXML:XML;
		private var _textureLoader:Loader;
		private var _xmlLoader:URLLoader;
		public var _texvector:Vector.<String>
		private var _atlas:TextureAtlas;
		
		public function SpriteSheet(  )
		{
			
			//loadBitmapTexture:Bitmap
			//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html#includeExamplesSummary
			
			// looks like it loads in the real complete, but that's a texture atlas which gets cut up and recreated in a random order
			
			_textureLoader = new Loader();
			_textureLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, textureLoaderCompleteHandler );
			_textureLoader.load( new URLRequest( Config.SYMBOLS_SPRITE_SHEET ) );
			
			
			
		}
		
		protected function textureLoaderCompleteHandler( event:Event ):void
		{
			//trace( "textureLoaderCompleteHandler" );
			//trace( "_textureLoader = " + _textureLoader as BitmapData );
			
			var scale:Number = 1; //100%
			
			var bitmap:Bitmap = event.target.content;
			var bitMapData:BitmapData = bitmap.bitmapData;

			_atlasTexture = Texture.fromBitmapData( bitMapData, false, false, scale );
			
			loadAtlasTextureXML()
			
			
		}
		
		private function loadAtlasTextureXML():void
		{
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, xmlLoaderCompleteHandler);
			_xmlLoader.load( new URLRequest( Config.SYMBOLS_SPRITE_SHEET_TEXTURE_ATLAS ) );
			
		}
		
		protected function xmlLoaderCompleteHandler(event:Event):void
		{
			//trace( "xmlLoaderCompleteHandler _xmlLoader.data = " + _xmlLoader.data );
			_atlasXML = new XML( _xmlLoader.data );;
			
			createSpriteSheet();
			
			
		}
		
		private function createSpriteSheet():void
		{
			
			_atlas = new TextureAtlas( _atlasTexture, _atlasXML );
			_texvector = _atlas.getNames( "" );
			var texture:Texture = _atlas.getTexture( "bar");
			
			var image:Image = new Image( texture );
			
			//trace( "_atlas created" );
			
			dispatchEvent( new RollerEvent( RollerEvent.TEXTURE_ATLAS_LOADED_COMPLETE ) );
			
			
			
		}
		public function getSpriteByID( id:int ):Texture
		{
			var textureName:String = _texvector[id];
			var texture:Texture = getSpriteByName( textureName );
			return texture;
			
		}
		
		public function getSpriteByName( textureName:String ):Texture
		{
			
			var texture:Texture = _atlas.getTexture( textureName );
			return texture;
			
		}
	}
}