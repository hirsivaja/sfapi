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
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.ReferenceData;
	import sfapi.core.Tools;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class CheckBoxCommands extends AbstractCommand
	{
		public function CheckBoxCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}
		
		/**
		 * Change the check state of a checkbox to checked or unchecked
		 * @param  id  The ID of the Flex object
		 * @param  args  check state ['true', 'false']['checked', 'unchecked']['check', 'uncheck']['1', '1']
		 * @return  'true' if the call succeeded. An error message if the call fails.
		 */
		public function doFlexCheckBox(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);

			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}

			return rawFlexCheckBox(child, args);
		}
		
		/**
		 * Change the check state of a checkbox to checked or unchecked
		 * @param  child  Flex object which state to change
		 * @param  args  check state ['true', 'false']['checked', 'unchecked']['check', 'uncheck']['1', '1']
		 * @return  'true' if the call succeeded. An error message if the call fails.
		 */
		public function rawFlexCheckBox(child:Object, args:String):String
		{
			if (!Tools.isA(child, ReferenceData.CHECKBOX_DESCRIPTION))
			{
				if (Tools.isA(child, ReferenceData.TRI_CHECKBOX_DESCRIPTION, true))
				{
					// Handle a tri-state checkbox:
					return rawFlexTristateCheckBox(child, args);
				}
				// Not a checkbox?
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, [child, ReferenceData.CHECKBOX_DESCRIPTION]);

			}
			// Normal checkbox:
			switch (argIsCheck(args))
			{
				case ReferenceData.CHECKSTATE_CHECKED :
					if (child.selected)
					{
						return 'true';
					}
					else
					{
						return dispatchCheckBoxEvent(child);
					}
					break;
				case ReferenceData.CHECKSTATE_UNCHECKED :
					if (child.selected)
					{
						return dispatchCheckBoxEvent(child);
					}
					else
					{
						return 'true';
					}
					break;
				case ReferenceData.CHECKSTATE_UNKNOWN :
					return ErrorMessages.getError(ErrorMessages.ERROR_UNKNOWN_CHECK_STATE, [child]);
					break;

			}
			return null;
		}
		private function rawFlexTristateCheckBox(child:Object, args:String):String
		{
			var state:int = argIsCheck(args);
			switch (state)
			{
				case ReferenceData.CHECKSTATE_UNKNOWN :
					return ErrorMessages.getError(ErrorMessages.ERROR_UNKNOWN_CHECK_STATE, [child]);
				default:
					child.state = state;
					return 'true';
			}
			return null;
		}
		/**
		 * Determine if a checkbox is checked or unchecked
		 * @param  id  The ID of the Flex object
		 * @param  args  nothing
		 * @return  the check state of a checkbox. An error message if the call fails.
		 */
		public function getFlexCheckBoxChecked(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if (child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return getFlexCheckBoxStatus(child);
		}

		/**
		 * Get checkbox status
		 * @param object  Check box widget
		 * @return  The status, 'true', 'false', 'no change' or 'unkwnown'.
		 */
		public function getFlexCheckBoxStatus(object:Object):String
		{
			try
			{
				if (Tools.isA(object, ReferenceData.TRI_CHECKBOX_DESCRIPTION))
				{
					// Custom tri-state box:
					switch (object.state)
					{
						case 1:
							return "true";
						case 0:
							return "false";
						case -1:
							return "no change";
					}
				}
				// Normal - or unknown - checkbox: return the old, normal, way.
				if (object.selected)
				{
					return "true";
				}
				else
				{
					return "false";
				}
			}
			catch (error:Error)
			{
				return "Error: " + error.message;
			}
			return "unknown";
		}
		/**
		 * return if a string specifies a particular check state for a check box
		 * @param  arg  the check state string
		 * @return  checked or unchecked or null
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
			else if (arg.toLowerCase() == 'no change' || arg =='-1')
			{
				return ReferenceData.CHECKSTATE_NO_CHANGE;
			}
			return ReferenceData.CHECKSTATE_UNKNOWN;
		}
		
		/**
		 * dispatch a click and change event for when a checkbox state is changing
		 * @param  element  the target check box
		 * @return  'true' or 'false'
		 */
		private function dispatchCheckBoxEvent(element:Object):String
		{
			return String(element.dispatchEvent(new Event("change")) &&
				element.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
		}
	}
}