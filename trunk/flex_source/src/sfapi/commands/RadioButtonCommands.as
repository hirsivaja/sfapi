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
	import flash.events.Event;
	import flash.events.MouseEvent;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.ReferenceData;
	import sfapi.core.Tools;
	
	public class RadioButtonCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function RadioButtonCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/**
		 * Change the state of a radio button
		 * @param  id  The ID of the Flex object
		 * @param  args  check state ['true', 'false']['checked', 'unchecked']['check', 'uncheck']['1', '1']
		 * @return	'true' if the call succeeded. An error message if the call fails.
		 */
		public function doFlexRadioButton(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			
			if(Tools.getOjectType(child) != ReferenceData.RADIOBUTTON_DESCRIPTION)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [id, ReferenceData.RADIOBUTTON_DESCRIPTION]);
			}
			
			switch(argIsCheck(args))
			{
				case ReferenceData.CHECKSTATE_UNKNOWN :
					return ErrorMessages.getError(ErrorMessages.ERROR_UNKNOWN_STATE, [args, id]);
					break;
				case ReferenceData.CHECKSTATE_CHECKED :
					if(! child.selected) return dispatchRadioEvent(child);
					else return 'true';
					break;
				case ReferenceData.CHECKSTATE_UNCHECKED :
					if(child.selected) return dispatchRadioEvent(child);
					else return 'true';
					break;
			}
			return null;
		}
		
		/**
		 * dispatch a click and change event for when a checkbox state is changing
		 * @param  element  the target check box
		 * @return	'true' or 'false'
		 */
		private function dispatchRadioEvent(child:Object):String
		{
			return String(child.dispatchEvent(new Event(flash.events.Event.CHANGE)) &&
						  child.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
		}
		
		/**
		 * Determine if a RadioButton is selected
		 * @param  id  The ID of the Flex object
		 * @param  args  nothing
		 * @return	the check state of a checkbox. An error message if the call fails.
		 */
		public function getFlexRadioButton(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(Tools.getOjectType(child) == ReferenceData.RADIOBUTTON_DESCRIPTION)
			{
				return String(child.selected);
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [id, ReferenceData.RADIOBUTTON_DESCRIPTION]);
			}
			return null;
		}
		
		/**
		 * return if a string specifies a particular check state for a check box
		 * @param  arg  the check state string
		 * @return	checked or unchecked or null
		 */
		private function argIsCheck(arg:String):int
		{
			if(arg == 'true' || arg.toLowerCase() == 'checked' || arg.toLowerCase() == 'check' || arg == '1')
			{
				return ReferenceData.CHECKSTATE_CHECKED;
			}
			else if(arg == 'false' || arg.toLowerCase() == 'unchecked' || arg.toLowerCase() == 'uncheck' || arg == '0')
			{
				return ReferenceData.CHECKSTATE_UNCHECKED;
			}
			return ReferenceData.CHECKSTATE_UNKNOWN;
		}
	}
}