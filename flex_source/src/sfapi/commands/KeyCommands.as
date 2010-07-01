package sfapi.commands
{
	import mx.events.FlexEvent;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	
	public class KeyCommands extends AbstractCommand
	{
		public function KeyCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}

		public function doFlexEnterKey(locator:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(locator);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [locator]);
			}
			return String(child.dispatchEvent(new FlexEvent(FlexEvent.ENTER)));
		}
	}
}