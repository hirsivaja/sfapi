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
	import sfapi.core.ReferenceData;
	import sfapi.core.Tools;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class CheckBoxCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function CheckBoxCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/**
		 * Change the check state of a checkbox to checked or unchecked
		 * @param  id  The ID of the Flex object
		 * @param  args  check state ['true', 'false']['checked', 'unchecked']['check', 'uncheck']['1', '1']
		 * @return	'true' if the call succeeded. An error message if the call fails.
		 */
		public function doFlexCheckBox(id:String, args:String):String
		{
			var element:Object;
			var child:Object = appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}

			var childType:String = Tools.getOjectType(child); 
			if(childType != ReferenceData.CHECKBOX_DESCRIPTION)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [id, ReferenceData.CHECKBOX_DESCRIPTION]);
			}
			
			switch(argIsCheck(args))
			{
				case ReferenceData.CHECKSTATE_CHECKED :
					if(child.selected)
					{
						return 'true';
					}
					else
					{
						return dispatchCheckBoxEvent(child);
					}
					break;
				case ReferenceData.CHECKSTATE_UNCHECKED :
					if(child.selected)
					{
						return dispatchCheckBoxEvent(child);
					}
					else
					{
						return 'true';
					}
					break;
				case ReferenceData.CHECKSTATE_UNKNOWN :
					return ErrorMessages.getError(ErrorMessages.ERROR_UNKNOWN_CHECK_STATE, [id]);
					break;
				
			}
			return null;
		}
		
		/**
		 * Determine if a checkbox is checkde or unchecked
		 * @param  id  The ID of the Flex object
		 * @param  args  nothing
		 * @return	the check state of a checkbox. An error message if the call fails.
		 */
		public function getFlexCheckBoxChecked(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			// get the XML type description of the child node
			var childType:String = Tools.getOjectType(child);
			
			if(childType == ReferenceData.CHECKBOX_DESCRIPTION)
			{
				return child.selected.toString();
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [id, ReferenceData.CHECKBOX_DESCRIPTION]);
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
		
		/**
		 * dispatch a click and change event for when a checkbox state is changing
		 * @param  element  the target check box
		 * @return	'true' or 'false'
		 */
		private function dispatchCheckBoxEvent(element:Object):String
		{
			return String(element.dispatchEvent(new Event("change")) &&
				element.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
		}
	}
}