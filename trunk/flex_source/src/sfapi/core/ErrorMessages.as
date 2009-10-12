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
package sfapi.core
{
	public class ErrorMessages
	{
		public static const ERROR_CANNOT_FIND_BUTTON:String = 						"Error: Could not find a button with label {0}";
		public static const ERROR_CANNOT_FIND_MENUITEM:String = 					"Error: Could not find a menu item with label {0}";
		public static const ERROR_ENABLED_NOT_APPLY:String = 						"Error: The enabled property does not apply to {0}";
		public static const ERROR_ELEMENT_NOT_FOUND:String = 						"Error: The element '{0}' was not found in the application";
		public static const ERROR_UNKNOWN_CHECK_STATE:String = 						"Error: Unknown check state type for {0}";
		public static const ERROR_TYPE_MISMATCH:String = 							"Error: The Element '{0}' is not of type '{1}'";
		public static const ERROR_CANNOT_TYPE:String = 								"Error: Cannot type text into {0}";
		public static const ERROR_CANNOT_RETURN_TEXT:String = 						"Error: Cannot return text or label data from the control {0}";
		public static const ERROR_MESSAGE:String = 									"Error: {0}";
		public static const ERROR_BAD_LOCATOR:String = 								"Error: Bad locator '{0}'";
		public static const ERROR_NO_MATCH:String = 								"Error: Did not find a match";
		public static const ERROR_NO_SELECTION:String = 							"Error: Did not find selection for '{0}' on control {1}";
		public static const ERROR_NO_PROPERTY:String = 								"Error: There is no '{0}' property for the element '{1}'";
		public static const ERROR_ALERT_BUTTON:String = 							"Error: The {0} button wass not found on the alert control";
		public static const ERROR_NO_ALERT:String = 								"Error: Alert not found";
		public static const ERROR_ALERT_TEXT:String = 								"Error: Cannot find Alert text control";
		public static const ERROR_UNKNOWN_STATE:String = 							"Error: Unknown state type {0} for {1}";
		public static const ERROR_INCOMPATABLE_CONTROL:String = 					"Error: The {0} control is not compatable with the {1} command in this context";
		public static const ERROR_PROPERTY_NOT_FOUND:String = 						"Error: The {0} was not found on the {1} component";
		public static const ERROR_DATAGRID_UICOMPONENT_LABEL_NOT_FOUND:String = 	"Error: A Label was not found on the {0} data grid UIComponent at row:{1} col:{2}";
		public static const ERROR_NO_CHILD_INDEX:String = 							"Error: There is no child at index '{0}' on the {1} control";
		public static const ERROR_NO_CHILD_UICOMPONENT:String = 					"Error: The UIComponent was not found on the {0} parent component at row:{1} col:{2}";
		public static const ERROR_TEXT_NOT_FOUND:String =							"Error: Could not find text: '{0}' in column '{1}'";
		public static const ERROR_NOT_DOUBlE_CLICKABLE:String =						"Error: Control is not double-clickable: {0}";
		public static const ERROR_EXT_INTERFACE_NOT_AVAIL:String =					"Error: The External Interface is not available on this application.";
		
		public function ErrorMessages()
		{
		}
		
		public static function getError(msg:String, args:Array):String
		{
			for(var i:int = 0; i < args.length; i++)
			{
				var replacePattern:String = "{" + i + "}";
				msg = msg.replace(replacePattern, args[i]);
			}
			return msg;
		}
	}
}