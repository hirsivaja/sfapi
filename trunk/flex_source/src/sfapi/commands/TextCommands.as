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
	import flash.events.Event;
	
	public class TextCommands extends AbstractCommand
	{
		public function TextCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}
		
		/**
		 * Type some text in a TextInput control
		 * @param  id  The ID of the Flex object
		 * @param  args  text value to type
		 * @return  'true' if the text is inputed. An error message if the call fails.
		 */
		public function doFlexType(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("text"))
			{
				child.text = args;
				child.setFocus();
				return String(child.dispatchEvent(new Event(Event.CHANGE)));
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_TYPE, [id]);
			}
			return null;
		}
		
		/**
		 * Type some text in a TextInput control appending it to the test in the control
		 * @param  id  The ID of the Flex object
		 * @param  args  text value to type
		 * @return  'true' if the text is inputed. An error message if the call fails.
		 */
		public function doFlexTypeAppend(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("text"))
			{
				child.text += args;
				child.setFocus();
				return String(child.dispatchEvent(new Event(Event.CHANGE)));
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_TYPE, [id]);
			}
			return null;
		}
		
		/**
		 * Retrieves the text or label text value of a control, list control or grid based control
		 * @param  id  The ID of the Flex object
		 * @return  the test of the control. An error message if the call fails.
		 */
		public function getFlexText(id:String, args:String):String
		{
			var locator:Array = id.split('.');
			var child:Object = appTreeParser.getElement(locator[0]);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}

			switch(locator.length)
			{
				case 1 : 
					return getTextTextElem(child, id); 
					break;
				case 2 : 
					return getTextListElem(child, parseInt(locator[1])); 
					break;
				case 3 : 
					return getTextGridElem(child, parseInt(locator[1]), locator[2]); 
					break;
				default : 
					return ErrorMessages.getError(ErrorMessages.ERROR_BAD_LOCATOR, [id]); 
			}
			return null;
		}
		
		/**
		 * Returns the text from a text based object such as a Label or TextInput
		 */
		private function getTextTextElem(child:Object, id:String):String
		{
			if(child.hasOwnProperty("text"))
			{
				return child["text"];
			}
			else if(child.hasOwnProperty("label"))
			{
				return child["label"];
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_RETURN_TEXT, [id]);
		} 
		
		/**
		 * Returns the text from a list based object such as a ComboBox
		 */
		private function getTextListElem(child:Object, itemIndex:int):String
		{
			try
			{
				if(child.dataProvider[itemIndex].hasOwnProperty('label'))
				{
					return child.dataProvider[itemIndex].label;
				}
				else
				{
					return child.dataProvider[itemIndex].toString();
				}
			}
			
			catch(e:Error)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_MESSAGE, [e.toString()]);
			}
			return null;
		}
			
		/**
		 * Returns the text from a grid based object such as a ComboBox
		 */
		private function getTextGridElem(child:Object, itemIndex:int, columnName:String):String
		{
			try
			{
				return child.dataProvider[itemIndex][columnName].toString();
			}
			catch(e:Error)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_MESSAGE, [e.toString()]);
			}
			return null;
		}
		
		/**
		 * Determines if a string is part of a controls text or label property
		 * @param  id  The ID of the Flex object
		 * @param  searchStr  the string to search for in the control
		 * @return  'true' if searchStr is present, 'false' if not
		 */
		public function getFlexTextPresent(id:String, searchStr:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			try
			{
				if(child.hasOwnProperty("text"))
				{
					return searchElementText(child["text"].toString(), searchStr);
				}
				else if(child.hasOwnProperty("label"))
				{
					return searchElementText(child["label"].toString(), searchStr);
				}
				else
				{
					return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_RETURN_TEXT, [id]);
				}
			}
			catch(e:Error)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_MESSAGE, [e.toString()]);
			}
			return null;
		}
		
		/**
		 * Searches an element to see if the text is present
		 */
		private function searchElementText(target:String, searchStr:String):String
		{
			if(target.search(searchStr) > -1)
			{
				return "true";
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [searchStr]);
			}
			return null;
		}
		
		/**
		 * Retrieves text from a control based on a regular expression pattern
		 * @param  id  The ID of the Flex object
		 * @param  pattern  the regular expression to match the value in the text
		 * @return  the first matching substring for of the regex
		 */
		public function getFlexNumeric(id:String, args:String):String
		{
			var retval:String = getFlexText(id, args);
			var pattern:RegExp = /\d+/i;
			try
			{
				if(retval.search(pattern) != -1)
				{		
					var matchArray:Array = retval.match(pattern);
					return matchArray[0];
				}
				else
				{
					return ErrorMessages.getError(ErrorMessages.ERROR_NO_MATCH, []);
				}
			}
			catch(e:Error)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_MESSAGE, [e.toString()]);
			}
			return null;
		}
				
		/**
		 * Retrieves an integer from the text or label text value of a control, list control or grid based control
		 * @param  id  The ID of the Flex object
		 * @return  an integer parsed from the test of the control. An error message if the call fails.
		 */
		public function getFlexParseInt(id:String, args:String):String
		{
			var retval:String = getFlexText(id, args);
			if(retval.search('Error') == -1)
			{
				var extractInt:int = parseInt(retval);
				return extractInt.toString();
			}
			return null;
		}
		
		/**
		 * Returns the label of a UIComponent within a Datagrid at a given row and column index.
		 * 
		 * Command:	flexDataGridUIComponentLabel
		 * Target:	myGridControl
		 * Value:	1,2
		 * 
		 * Breakdown:
		 * 
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<row>,<col>
		 * 
		 * All fields are compulsory
		 * 
		 * @param  id  id of the control
		 * @param  value  takes the form "<row>,<col>"
		 * @return  String of the component label. An error message if the call fails.
		 */
		public function getFlexDataGridUIComponentLabel(target:String):String
		{
			var args:Array = target.split(",");
			
			var id:String = args[1];
			var rowIndex:String = args[2];
			var colIndex:String = args[3];
			
			return rawFlexDataGridUIComponentLabel(id, rowIndex, colIndex);
		}
		
		/**
		 * Returns the label of a UIComponent within a Datagrid at a given row and column index.
		 * 
		 * @param  datagridId  The ID of the Datagrid object
		 * @param  rowIndex  The row index of the Component in the Datagrid
		 * @param  colIndex  The colum index of the Component in the Datagrid
		 * @param  componentIndexInCell The index of the column within the rowIndex and columnIndex
		 * @return	String of the component label. An error message if the call fails.
		 */
		public function rawFlexDataGridUIComponentLabel(datagridId:String, rowIndex:String, colIndex:String, 
				componentIndexInCell:String = "0"):String
		{
			var child:Object = appTreeParser.getElement(datagridId);

			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [datagridId]);
			}
			
			// Assumes the DataGrid has only one ListBaseContentHolder
			var dgContentList:Object = Tools.getChildrenOfTypeFromContainer(child, ReferenceData.LISTBASECONTENTHOLDER_DESCRIPTION)[0];
			
			// Make certain the rowIndex and colIndex do not exceed the length of the 
			// Datagrid ListBaseContentHolders rows and columns.
			if(dgContentList.listItems.length > int(rowIndex) && dgContentList.listItems[int(rowIndex)].length > int(colIndex))
			{
				var cell:Object = dgContentList.listItems[int(rowIndex)][int(colIndex)];
				var cellChildren:Array = cell.getChildren();
				
				if((cellChildren[componentIndexInCell]).hasOwnProperty("label"));
				{
					return String(cellChildren[componentIndexInCell].label);
				}
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_DATAGRID_UICOMPONENT_LABEL_NOT_FOUND, [datagridId,rowIndex,colIndex]);
		}

		// todo move to grid commands
		/**
		 * Returns the text of a Datagrid cell at a given row and column index.
		 * 
		 * Command:	getFlexDataGridCellText
		 * Target:	myGridControl
		 * Value:	1,2
		 * 
		 * Breakdown:
		 * 
		 * Command:	<command>
		 * Target:	<grid id>
		 * Value:	<row>,<col>
		 * 
		 * All fields are compulsory
		 * 
		 * @param  id  id of the control
		 * @param  value  takes the form "<row>,<col>"
		 * @return  String of the cell text. An error message if the call fails.
		 */
		public function getFlexDataGridCellText(value:String):String
		{
			var args:Array = value.split(",");
			var id:String = args[0];
			var rowIndex:String = args[1];
			var colIndex:String = args[2];
			
			return rawFlexDataGridCellText(id, rowIndex, colIndex);
		}
		
		/**
		 * Returns the text of a Datagrid cell at a given row and column index.
		 * 
		 * @param  datagridId  The ID of the Datagrid object
		 * @param  rowIndex  The row index of the Component in the Datagrid
		 * @param  colIndex  The colum index of the Component in the Datagrid
		 * @return	String of the cell text. An error message if the call fails.
		 */
		public function rawFlexDataGridCellText(datagridId:String, rowIndex:String, colIndex:String):String
		{
			var child:Object = appTreeParser.getElement(datagridId);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [datagridId]);
			}
			
			// Assumes the DataGrid has only one ListBaseContentHolder
			var dgContentList:Object = Tools.getChildrenOfTypeFromContainer(child, 
					ReferenceData.LISTBASECONTENTHOLDER_DESCRIPTION)[0];
			
			// Make certain the rowIndex and colIndex do not exceed the length of the 
			// Datagrid ListBaseContentHolders rows and columns.
			if(dgContentList.listItems.length > int(rowIndex) && 
					dgContentList.listItems[int(rowIndex)].length > int(colIndex))
			{
				var cell:Object = dgContentList.listItems[int(rowIndex)][int(colIndex)];
				return cell.text;
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_DATAGRID_UICOMPONENT_LABEL_NOT_FOUND, 
					[datagridId,rowIndex,colIndex]);
		}
	}
}