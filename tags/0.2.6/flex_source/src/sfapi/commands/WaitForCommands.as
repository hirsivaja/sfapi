/*	
 *	License
 *	
 *	This file is part of The SeleniumFlex-API.
 *	
 *	The SeleniumFlex-API is free software: you can redistribute it and/or
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
 *	If not, see http://www.gnu.org/licenses/
 *
 */
package sfapi.commands
{
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	
	public class WaitForCommands{

		private var appTreeParser:AppTreeParser;

		public function WaitForCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		// TODO comments
		public function doFlexWaitForElementVisible(id:String, timeout:Number):String
		{
			var child:Object = appTreeParser.getElement(id);
			var count:Number = 0;
			while (child == null || ! child.hasOwnProperty("visible"))
			{
				child = appTreeParser.getElement(id);
				if(count >= timeout)
				{
					break;
				}
				count += 1;
			}
			if(child !== null && child.hasOwnProperty("visible"))
			{
				return 'true';
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
		}
		
		/**
		 * Wait for an element to exist 
		 * @param  id  The ID of the Flex object
		 * @param  timeout The number of loops to wait
		 * @return	'true' if the element if found
		 */
		public function doFlexWaitForElement(id:String, timeout:Number):String
		{
			var child:Object = appTreeParser.getElement(id);
			var count:Number = 0;
			while(! child)
			{
				child = appTreeParser.getElement(id);
				if (count >= timeout)
				{
					break;
				}
				count += 1;
			}
			
			if(child)
			{
				return 'true';
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
		}
	}
}