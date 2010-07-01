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
	
	public class UtilCommands extends AbstractCommand
	{
		public function UtilCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}
		
		/**
		 * Refresh setting the tooltips when can be called by selenium.
		 * This is designed to catch the IDs of any popups that are created dynamically
		 * at runtime, plus it refreshes all of the tooltips
		 * @return  'true'
		 */
		public function doFlexRefreshIDToolTips(id:String, args:String):String
		{
			appTreeParser.setTooltipsToID();
			return 'true';
		}
	}
}