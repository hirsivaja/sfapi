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
	import mx.events.ListEvent;
	import sfapi.core.AppTreeParser;
	
	public class ComboCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function ComboCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}

		// todo comm
		public function doFlexSelectComboByLabel(id:String, value:String) : String {
			var result:String;
		
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				var index:int = -1;
				var i:int = 0;
				for each (var row:Object in provider)
				{
					var rowLabel:String = widget.itemToLabel(row);
					if (value == rowLabel)
					{
						index = i;
						break;
					}			
					i++;
				}
				if (index > -1)
				{
					widget.selectedIndex = index;	
					result = String(widget.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK)) && widget.dispatchEvent(new ListEvent(ListEvent.CHANGE)));
				}
				else
				{
					// todo standard err
					throw new Error("Could not select label '" + value + "'");
				}
			}
			catch (e:Error)
			{
				// todo standard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
		
		// todo comms
		public function getFlexComboContainsLabel(value:String):String
		{
			var args:Array = value.split(",");
			var id:String = args[0];
			var label:String = args[1];
			return rawFlexComboContainsLabel(id, label);
		}
		
		/**
		 * Determines if the list of items in the combo box contains a label with a specified value.
		 * 
		 * @param  id  The ID of the Flex object
		 * @param  args the expected value in the combo
		 * @return  true if the combo contains the label, false otherwise 
		 */
		public function rawFlexComboContainsLabel(id:String, label:String):String
		{
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				var found:Boolean = false;
				for each (var row:Object in provider)
				{
					var rowLabel:String = widget.itemToLabel(row);
					if(label == rowLabel)
					{
						return 'true';
					}			
				}
			}
			catch (e:Error)
			{
				// todo standard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return 'false';
		}

	}

}