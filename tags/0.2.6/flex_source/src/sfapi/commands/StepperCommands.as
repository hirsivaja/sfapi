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
	import flash.events.MouseEvent;
	import mx.events.NumericStepperEvent;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	
	public class StepperCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function StepperCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		/**
		 * Sets the value of a numeric stepper control
		 * @param  id  The ID of the Flex object
		 * @param  args  the numeric value to set the control
		 * @return  'true' if the value is set. An error message if the call fails.
		 */
		public function doFlexStepper(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("value"))
			{
				child.value = parseInt(args);
				return String(child.dispatchEvent(new MouseEvent(MouseEvent.CLICK)) && 
						child.dispatchEvent(new NumericStepperEvent('change')));	
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [id, "NumericStepper"]);
			}
			return null;
		}
		
		/**
		 * Gets the value of a numeric stepper control
		 * @param  id  The ID of the Flex object
		 * @return  the value of the stepper control An error message if the call fails.
		 */
		public function getFlexStepper(id:String, args:String):String
		{
			var retval:String;
			var child:Object = appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("value"))
			{
				return String(child.value);
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [id, "NumericStepper"]);
			}
			return null;
		}
	}
}