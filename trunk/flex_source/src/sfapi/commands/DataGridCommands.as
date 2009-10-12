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
	import flash.events.Event;
	
	public class DataGridCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function DataGridCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/**
		 * Returns a value in a grid given the row and column
		 * <br/>
		 * Command:	flexDataGridCell
		 * Target:	myGridControl
		 * Value:	1,2
		 * <br/>
		 * Breakdown:
		 * <br/>
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<row>,<col>
		 * <br/>
		 * All fields are compulsory
		 * <br/>
		 * @param  id  id of the control
		 * @param  value  takes the form <row>,<col>
		 * @return  a string of the value set in the grid cell   
		 */
		public function getFlexDataGridCell(value:String):String
		{
			var args:Array = value.split(",");
			var id:String = args[0];
			var rowIndex:String = args[1];
			var colIndex:String = args[2];
			return rawFlexDataGridCell(id, rowIndex, colIndex);
		}
		
		// todo comm
		public function rawFlexDataGridCell(id:String, rowIndex:String, colIndex:String):String {
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var row:Object = widget.dataProvider[parseInt(rowIndex)];
				var col:Object = widget.columns[parseInt(colIndex)];
				result = col.itemToLabel(row);
			}
			catch (e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
		
		/**
		 * Sets a text value in a datagrid cell
		 * <br/>
		 * Command:	flexSetDataGridCell
		 * Target:	myDataGridItem
		 * Value:	1,2,this data
		 * <br/>
		 * Breakdown:
		 * <br/>
		 * Command:	<command>
		 * Target:	<menubar id>
		 * Value:	<rowIndex>,<colIndex>,<data value>
		 * <br/>
		 * All fields are compulsory
		 * <br/>
		 * @param  value  takes the form <rowIndex>,<colIndex>,<data>
		 * @return  'true' if successfully set, error if not  
		 */
		public function doFlexSetDataGridCell(target:String, value:String):String
		{
			var args:Array = target.split(",");
			var id:String = args[0];
			var rowIndex:String = args[1];
			var colIndex:String = args[2];
			return rawFlexSetDataGridCell(id, rowIndex, colIndex, value);
		}
		
		// todo comm
		public function rawFlexSetDataGridCell(id:String, rowIndex:String, colIndex:String, data:String):String
		{
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var row:Object = widget.dataProvider[parseInt(rowIndex)];
				var col:Object = widget.columns[parseInt(colIndex)];
				row[col.dataField] = data;
				result = String(widget.dataProvider.dispatchEvent(new Event(Event.CHANGE)));
			}
			catch(e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}	

		/**
		 * Returns the row index of a given value in a certain field on a grid
		 * <br/>
		 * Command:	flexDataGridRowIndexForFieldValue
		 * Target:	myGridControl
		 * Value:	theField,hello
		 * <br/>
		 * Breakdown:
		 * <br/>
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<fieldName>,<data>
		 * <br/>
		 * All fields are compulsory
		 * <br/>
		 * @param  id  id of the control
		 * @param  value  takes the form "<fieldName>,<data>"
		 * @return  a string of row index for cell containing the data
		 */
		public function getFlexDataGridRowIndexForFieldValue(value:String):String
		{
			var args:Array = value.split(",");
			var id:String = args[0];
			var fieldName:String = args[2];
			var data:String = args[3];
			
			return rawFlexDataGridRowIndexForFieldValue(id, fieldName, data);
		}
		
		// todo comm
		public function rawFlexDataGridRowIndexForFieldValue(id:String, fieldName:String, data:String):String
		{
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				var index:int = -1;
				var i:int = 0;
				for each (var row:Object in provider)
				{
					if(row.hasOwnProperty(fieldName))
					{
						if(row[fieldName].toString() == data)
						{
							index = i;
							break;
						}
					} 
					i++;			
				}		
				result = String(index);
			}
			catch (e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
		
		/**
		 * Returns the row index of a given label in a certain field on a grid
		 * <br/>
		 * Command:	flexDataGridRowIndexForFieldLabel
		 * Target:	myGridControl
		 * Value:	theField,myLabelValue
		 * <br/>
		 * Breakdown:
		 * <br/>
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<fieldName>,<data>
		 * <br/>
		 * All fields are compulsory
		 * <br/>
		 * @param  id  id of the control
		 * @param  value  takes the form "<fieldName>,<data>"
		 * @return  a string of row index for cell containing the label
		 */
		public function getFlexDataGridRowIndexForFieldLabel(id:String, value:String):String
		{
			var args:Array = value.split(",");
			
			var fieldName:String = args[0];
			var data:String = args[1];
			
			return rawFlexDataGridRowIndexForFieldLabel(id, fieldName, data);
		}
		// todo comm
		public function rawFlexDataGridRowIndexForFieldLabel(id:String, fieldName:String, data:String):String
		{
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var column:Object;
				for each (var candidate:Object in widget.columns)
				{
					if (candidate.dataField == fieldName)
					{
						column = candidate;
						break;
					}
				}
				if(! column)
				{
					// todo use atandard err
					throw new Error("No column for field '" + fieldName + "'");
				}
				
				var index:int = -1;
				var i:int = 0;		
				var provider:Object = widget.dataProvider;
				for each(var row:Object in provider)
				{
					var value:String = column.itemToLabel(row);
					
					if (value == data)
					{
						index = i;
						break;
					}
					i++;
				}
				result = String(index);
			}
			catch (e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
		
		/**
		 * Returns the data value of a field of the object that populates a row of a data grid.
		 * <br/>
		 * Command:	flexDataGridCell
		 * Target:	myGridControl
		 * Value:	fieldName,2
		 * <br/>
		 * Breakdown:
		 * <br/>
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<field>,<row>
		 * <br/>
		 * All fields are compulsory
		 * <br/>
		 * @param  id  id of the control
		 * @param  value  takes the form "<field>,<row>"
		 * @return  a string of the value set in the grid cell   
		 */
		public function getFlexDataGridFieldValueForGridRow(value:String):String
		{
			var args:Array = value.split(",");
			var id:String = args[0];
			var field:String = args[1];
			var rowNum:String = args[2];
			
			return rawFlexDataGridFieldValueForGridRow(id, field, rowNum);
		}
		
		/**
		 * Returns the data value of a field of the object that populates a row of a data grid.
		 * @param id the id of the Data Grid
		 * @param field the name of the field in the object whose data is required
		 * @param rowNum the required row number (numbering starts at 0)
		 */
		public function rawFlexDataGridFieldValueForGridRow(id:String, field:String, rowNum:String) : String {
			var result:String = "";
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				var index:int = parseInt(rowNum);
				if((index < 0) || (index >= provider.length))
				{
					// todo use atandard err
					throw new Error("Row index '" + index + "' out of bounds for dataProvider");
				}
				
				var row:Object = provider[index];
				var val:Object = row[field];
				if (val is Date)
				{
					val = (val as Date).getTime();
				} 
				result = val.toString();
			}
			catch (e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
		
		/**
		 * Returns the label value of a field of the object that populates a row of a data grid.
		 * <br/>
		 * Command:	flexDataGridCell
		 * Target:	myGridControl
		 * Value:	myFiels,2
		 * <br/>
		 * Breakdown:
		 * <br/>
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<field>,<row>
		 * <br/>
		 * All fields are compulsory
		 * <br/>
		 * @param  id  id of the control
		 * @param  value  takes the form "<field>,<row>"
		 * @return  a string of the label set in the grid cell   
		 */
		public function getFlexDataGridFieldLabelForGridRow(value:String):String
		{
			var args:Array = value.split(",");
			var id:String = args[0];
			var field:String = args[1];
			var rowNum:String = args[2];
			
			return rawFlexDataGridFieldLabelForGridRow(id, field, rowNum);
		}
		
		// todo comm
		public function rawFlexDataGridFieldLabelForGridRow(id:String, field:String, rowNum:String):String
		{
			var result:String = "";
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				var index:int = parseInt(rowNum);
				if ((index < 0) || (index >= provider.length))
				{
					// todo use atandard err
					throw new Error("Row index '" + index + "' out of bounds for dataProvider");
				}
				var column:Object;
				for each (var candidate:Object in widget.columns)
				{
					if (candidate.dataField == field)
					{
						column = candidate;
						break;
					}
				}
				if(! column)
				{
					// todo use atandard err
					throw new Error("No column for field '" + field + "'");
				}
				
				var row:Object = provider[index];
				
				result = column.itemToLabel(row);
			}
			catch (e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
		
		// todo comm
		public function getFlexDataGridRowCount(id:String):String
		{
			var result:String;
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
				var provider:Object = widget.dataProvider;
				result = String(provider.length);
			}
			catch (e:Error)
			{
				// todo use atandard err
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			return result;
		}
	}
}