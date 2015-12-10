/*  
 *  License
 *  
 *  This file is part of The SeleniumFlex-API.
 *  
 *  The SeleniumFlex-API is free software: you can redistribute it and/or
 *  modify it  under  the  terms  of  the  GNU  General Public License as 
 *  published  by  the  Free  Software Foundation,  either  version  3 of 
 *  the License, or any later version.
 *
 *  The SeleniumFlex-API is distributed in the hope that it will be useful,
 *  but  WITHOUT  ANY  WARRANTY;  without  even the  implied  warranty  of
 *  MERCHANTABILITY   or   FITNESS   FOR  A  PARTICULAR  PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with The SeleniumFlex-API.
 *  If not, see http://www.gnu.org/licenses/
 *
 */
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
		
		/**
		 * Dispatches a KEY_DOWN Keyboard event on an Element
		 * @param  locator  The ID of the Flex object
		 * @param  args  The key code of the key to send.
		 * @return  'true' if the event dispatched. An error message if the call fails.
		 */
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
		
		/**
		 * Dispatches a KEY_UP Keyboard event on an Element
		 * @param  locator  The ID of the Flex object
		 * @param  args  The key code of the key to send.
		 * @return  'true' if the event dispatched. An error message if the call fails.
		 */
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