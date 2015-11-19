package sfapi.commands
{
	import flash.events.KeyboardEvent;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	
	public class KeyCommands extends AbstractCommand
	{
		public function KeyCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}

		public function doFlexKeyDown(locator:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(locator);
			var keyCode:int = parseInt(args);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [locator]);
			}
			return String(child.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, keyCode)));
		}
		
		public function doFlexKeyUp(locator:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(locator);
			var keyCode:int = parseInt(args);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [locator]);
			}
			return String(child.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, keyCode)));
		}
	}
}