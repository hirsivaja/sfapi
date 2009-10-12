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
	public class ReferenceData
	{
		public static const TRUE_STRING:String = "true";
		public static const FLASE_STRING:String = "false";
		
		public static const TODAY:Array = ["", "", "today"];
		
		public static const CHECKSTATE_UNCHECKED:int = 0;
		public static const CHECKSTATE_CHECKED:int = 1;
		public static const CHECKSTATE_UNKNOWN:int = 2;
		
		public static const ALERT_DESCRIPTION:String = "mx.controls::Alert";
		public static const CHECKBOX_DESCRIPTION:String = "mx.controls::CheckBox";
		public static const RADIOBUTTON_DESCRIPTION:String = "mx.controls::RadioButton";
		public static const ACCORDION_DESCRIPTION:String = "mx.containers::Accordion";		
		public static const BUTTONBAR_DESCRIPTION:String = "mx.controls::ButtonBar";
		public static const LINKBAR_DESCRIPTION:String = "mx.controls::LinkBar";
		public static const TOGGLEBUTTONBAR_DESCRIPTION:String = "mx.controls::ToggleButtonBar";
		public static const DATEFIELD_DESCRIPTION:String = "mx.controls::DateField";
		public static const DATECHOOSER_DESCRIPTION:String = "mx.controls::DateChooser";
		public static const TABNAVIGATOR_DESCRIPTION:String = "mx.containers::TabNavigator";
		public static const LISTBASECONTENTHOLDER_DESCRIPTION:String = "mx.controls.listClasses::ListBaseContentHolder"
		
		public static const MILLISECONDS_IN_DAY:int = 86400000;
		
		public function ReferenceData()
		{
		}		
	}
}