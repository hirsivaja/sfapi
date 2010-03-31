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
	import mx.events.ListEvent;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.ReferenceData;
	import sfapi.core.Tools;
	
	public class SelectCommands
	{
		// TODO use reference standard for these
		private static const PROPERTY_DATA_PROVIDER:String = "dataProvider";
		private static const PROPERTY_SELECTED_INDEX:String = "selectedIndex";

		private var appTreeParser:AppTreeParser;
		
		public function SelectCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/**
		 * Selects an option on a list related control
		 * @param  id  The ID of the Flex object
		 * @param  arg  the text value of the list item to select 
		 * @return  'true' if the selection was made. An error message if the call fails.
		 */
		public function doFlexSelect(id:String, args:String):String
		{
			var comboNotSet:Boolean = true;
			var child:Object = appTreeParser.getElement(id);
			
			if(child === null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			var selection:int = getIndexOf(args, child);
			if(selection >= 0)
			{
				child.selectedIndex = selection;
				return dispatchIndexChangeEvent(child);
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_NO_SELECTION, [args, id]);
		}
		
		/**
		 * Gets the index of a literal value of a list item in a list related control
		 * @param  id  The ID of the Flex object
		 * @param
		 * @return  'true' if the selection was made. An error message if the call fails.
		 */
		private function getIndexOf(args:String, child:Object):int
		{
			if(child.dataProvider == null)
			{
				return -1;
			}

      var labelField:String = child.labelField;
			var i:int = 0;
			for each(var item:Object in child.dataProvider)
			{
				if((item.hasOwnProperty(labelField) && item[labelField] == args) || item.toString() == args)
				{
					return i;
				}
				i++;
			}
			return -1;
		}
		
		/**
		 * Selects an option on a list related control based on index
		 * @param  id  The ID of the Flex object
		 * @param
		 * @return  'true' if the selection was made. An error message if the call fails.
		 */
		public function doFlexSelectIndex(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			try
			{
				child.selectedIndex = parseInt(args);
				return dispatchIndexChangeEvent(child);
			}
			catch(e:Error)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_NO_SELECTION, [args, id]);
			}
			
			return null;
		}
		
		/**
		 * Retrieves a selection list related object
		 * @param  id  The ID of the Flex object
		 * @param  args  <empty string>
		 * @return  The text value of the selected item. An error message if the call fails.
		 */
		public function getFlexSelection(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("selectedLabel"))
			{
				return child.selectedLabel;
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_NO_PROPERTY, [id]);
			}
			return null;
		}
		
		/**
		 * Retrieves a selection list related object based on index
		 * @param  id  The ID of the Flex object
		 * @param  args  <empty string>
		 * @return  The text value of the selected item's index. An error message if the call fails.
		 */
		public function getFlexSelectionIndex(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("selectedIndex"))
			{
				return child.selectedIndex;
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_NO_PROPERTY, [id]);
			}		
			return null;
		}
		
		/**
		 * Add a selected index to the list of selections, maintaining the previous selections.
		 * 
		 * @param  id  The ID of the Flex object
		 * @param args the index to be selected
		 * 
		 * @return  'true' if the selection was made. An error message if the call fails.
		 */
		public function doFlexAddSelectIndex(id:String, args:String) : String {
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var selected:Array = widget.selectedIndices;
				selected.push(parseInt(args));
				widget.selectedIndices = selected;
				result = String(widget.dispatchEvent(new ListEvent(ListEvent.CHANGE)));		
			}
			catch (e:Error)
			{
				// TODO use error standard
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			
			return result;
		}
		
		public function doFlexAddSelectMatchingOnField(id:String, field:String, value:String) : String {
			var result:String;
		
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				var index:int = -1;
				var i:int = 0;
				for each (var row:Object in provider)
				{
					if (row.hasOwnProperty(field))
					{
						if (row[field].toString() == value)
						{
							index = i;
							break;
						}
					} 
					i++;			
				}
				
				if (index > -1)
				{
					// The selected indices is managed like this in order to
					// enable the Flash player to pick up the change
					var selected:Array = widget.selectedIndices;
					selected.push(index);
					widget.selectedIndices = selected;
					result = String(widget.dispatchEvent(new ListEvent(ListEvent.CHANGE)));			
				}	
				else
				{
					// TODO use error standard
					throw new Error("No row with a value of '" + value + "' for field '" + field + "'");
				}	
			}
			catch(e:Error)
			{
				// TODO use error standard
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			
			return result;
		}
		
		// todo fix
		/**
		 * Sets an item on a list based on a matching value on one of its fields in its dataProvider
		 * 
		 * Command:	flexSelectMatchingOnField
		 * Target:	myListControl
		 * Value:	fieldName,this is the data value
		 * 
		 * Breakdown:
		 * 
		 * Command:	<command>
		 * Target:	<list id>,<field>
		 * Value:	<data value>
		 * 
		 * All fields are compulsory
		 * 
		 * @param  id  id of the control
		 * @param  value  takes the form <field>,<data value>
		 * @return  'true' if successfully set, error if not  
		 */
		public function doFlexSelectMatchingOnField(target:String, data:String):String
		{
			var args:Array = target.split(",");
			var id:String = args[0];
			var field:String = args[1];
			return rawFlexSelectMatchingOnField(id, field, data);
		}
		
		// TODO com
		public function rawFlexSelectMatchingOnField(id:String, field:String, value:String):String
		{
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				if(! widget.hasOwnProperty(PROPERTY_DATA_PROVIDER))
				{
					// TODO use error standard
					throw new Error("Has no dataProvider property");
				}
				if (!widget.hasOwnProperty(PROPERTY_SELECTED_INDEX))
				{
					// TODO use error standard
					throw new Error("Has no selectedIndex property");
				}
				var dataProvider:Object = widget[PROPERTY_DATA_PROVIDER];
				var index:int = -1;
				var i:int = 0;
				for each (var row:Object in dataProvider)
				{
					if (row.hasOwnProperty(field))
					{
						if (row[field].toString() == value)
						{
							index = i;
							break;
						}
					} 
					i++;			
				}		
				if(index > -1)
				{
					widget[PROPERTY_SELECTED_INDEX] = i;
					result = String(widget.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK)) && widget.dispatchEvent(new ListEvent(ListEvent.CHANGE)));			
				}
				else
				{
					// TODO use error standard
					throw new Error("Could not select value '" + value + "' in field '" + field + "'");
				}
			}
			catch(e:Error)
			{
				// TODO use error standard
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			
			return result;
		}
		
		// TODO comm
		public function getFlexNumSelectedItems(id:String) : String {
			var result:String;
		
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				result = String(widget.selectedItems.length);
			}
			catch (e:Error)
			{
				// TODO use error standard
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			
			return result;
		}
		
		// TODO comm	
		public function getFlexSelectedItemAtIndex(id:String, index:String) : String {
			var result:String;
		
			try {
				var widget:Object = appTreeParser.getWidgetById(id);
				
				result = widget.selectedItems[parseInt(index)].toString();
			}
			catch (e:Error) {
				// TODO use error standard
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			
			return result;
		}
		
		// TODO comm
		private function dispatchIndexChangeEvent(child:Object):String
		{
			var comtype:String = Tools.getOjectType(child);
			switch(comtype)
			{
				case ReferenceData.TABNAVIGATOR_DESCRIPTION :
					return String(child.dispatchEvent(new Event(Event.TAB_INDEX_CHANGE)));
					break;
				default :
					return String(child.dispatchEvent(new ListEvent(ListEvent.CHANGE)));
					break;	
			}
			return null;
		}
	}
}
