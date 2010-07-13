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
    import flash.events.MouseEvent;

    import sfapi.core.AppTreeParser;
    import sfapi.core.ErrorMessages;
    import sfapi.core.ReferenceData;
    import sfapi.core.Tools;
	
	public class ClickCommands extends AbstractCommand
	{
		public function ClickCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}

		/**
		 * Clicks a button on a Flex application based on the ID in the parameter
		 * Can also click a button on a ButtonBar based on it's label 
		 * @param  id  The ID of the Flex object
		 * @param  args  The label of the buttonBar button to click
		 * @return	'true' if the button was clicked. An error message if the call fails.
		 */
		public function doFlexClick(id:String, args:String):String 
		{
			var child:Object = appTreeParser.getElement(id);
					
			if(child == null) 
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}

			// if stand alone control, just click it
			if(! args) 
			{

				return String(child.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));	
			}

			// for an Accordion control
			if(Tools.isA(child, ReferenceData.ACCORDION_DESCRIPTION))
			{
				return clickAccordion(child, args);
			}
			
			// for a button bar control
			if(Tools.isA(child, ReferenceData.BUTTONBAR_DESCRIPTION))
			{
				return clickButtonBar(child, args);
			}

			// for a link bar control
			if (Tools.isA(child, ReferenceData.LINKBAR_DESCRIPTION))
			{
				return clickLinkBar(child, args);
			}

			// for a Tab navigator
			if (Tools.isA(child, ReferenceData.TABNAVIGATOR_DESCRIPTION))
			{
				return clickTabNav(child, args);
			}

			return ErrorMessages.getError(ErrorMessages.ERROR_INCOMPATABLE_CONTROL, [Tools.getOjectType(child), 'flexClick']);
		}
		// TODO : comms
		private function clickTabNav(tabNav:Object, tabLabel:String):String
		{
			for(var i:int = 0; i < tabNav.numChildren; i++) 
			{
				var button:Object = tabNav.getTabAt(i);
				if(button.label == tabLabel) 
				{
					return String(button.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
				}
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_FIND_BUTTON, [tabLabel]);
		}
		// TODO : comms
		private function clickAccordion(accordion:Object, tabLabel:String):String 
		{
			for(var i:int = 0; i < accordion.numChildren; i++) 
			{
				var accordionTabButton:Object = accordion.getHeaderAt(i) as Object;
				if(accordionTabButton.label == tabLabel) 
				{
					return String(accordionTabButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
				}
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_FIND_BUTTON, [tabLabel]);
		}
		// TODO : comms
		private function clickButtonBar(buttonBar:Object, buttonBarLabel:String):String 
		{
			for(var i:int = 0; i < buttonBar.numChildren; i++) 
			{
				var buttonBarButton:Object = buttonBar.getChildAt(i);
				if(buttonBarButton.label == buttonBarLabel) 
				{
					return String(buttonBarButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
				}
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_FIND_BUTTON, [buttonBarLabel]);
		}
		// TODO : comms
		private function clickLinkBar(linkBar:Object, linkBarLabel:String):String 
		{
			for(var i:int = 0; i < linkBar.numChildren; i++) 
			{
				var linkBarButton:Object = linkBar.getChildAt(i);
				if(linkBarButton.label == linkBarLabel) 
				{
					return String(linkBarButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
				}
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_CANNOT_FIND_BUTTON, [linkBarLabel]);
		}
		// TODO : comms
		public function doFlexDoubleClick(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
					
			if(child == null) {
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			if(child.hasOwnProperty("doubleClickEnabled") && child.doubleClickEnabled)
			{
				return String(child.dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK)));
			} 
			return ErrorMessages.getError(ErrorMessages.ERROR_NOT_DOUBlE_CLICKABLE, [child.toString()]);
		}
		
		/**
		 * Dispatches a Click MouseEvent on the UIComponent of a Datagrid at a given
		 * row and column index.  If the cell at the given row and column has multiple 
		 * UIComponents provid the componentIndexInCell in the function signature.
		 * 
		 * @param  datagridId  The ID of the Datagrid object
		 * @param  value takes the form <rowIndex>,<colIndex>,<componentIndexInCell>
		 *         rowIndex  The row index of the Component in the Datagrid
		 *         colIndex  The colum index of the Component in the Datagrid
		 *         componentIndexInCell The index of the column within the rowIndex and columnIndex
		 * 			-1 return the cell itself
		 * 			0  return the first component on the cell
		 * @return	'true' if the button was clicked. An error message if the call fails.
		 */
		public function doFlexClickDataGridUIComponent(datagridId:String, value:String):String
		{
			var args:Array = value.split(",");
			var rowIndex:String = args[0];
			var colIndex:String = args[1];
			var componentIndexInCell:String = args[2];
			var component:Object = context.dataGridCommands.getDataGridCellComponent(datagridId, rowIndex, colIndex, componentIndexInCell);

			if (component is String)
			{
				// Got error message
				return String(component);
			}
			else
			{
				return String(component.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_NO_CHILD_UICOMPONENT, [datagridId,rowIndex,colIndex]);
		}
		
		/**
		 * Dispatches a MOUSE_OVER Event on the UIComponent
		 * 
		 * Example of the value parameter as passed from Selenium IDE
		 * 
		 * Command:	flexClickMenuBarUIComponent
		 * Target:	myMenuBar
		 * Value:	1,2,2,0
		 * 
		 * Breakdown:
		 * 
		 * Command:	<command>
		 * Target:	<menubar id>
		 * Value:	<menuBarItemIndex>,<menuItemRowIndex>,<menuItemColIndex>,<componentIndexInCell>
		 * 
		 * All fields are compulsory
		 * 
		 * @param  id
		 * @param  value  takes the form "<menuBarItemIndex>,<menuItemRowIndex>,<menuItemColIndex>,<componentIndexInCell>"
		 * @return  'true' if the component was clicked. An error message if the call fails.
		 */
		public function doFlexClickMenuBarUIComponent(id:String, value:String):String
		{
			var args:Array = value.split(",");
			var menuBarItemIndex:String = args[0];
			var menuItemRowIndex:String = args[1];
			var menuItemColIndex:String = args[2];
			var componentIndexInCell:String = args[3];
			
			return rawFlexClickMenuBarUIComponent(id, menuBarItemIndex, menuItemRowIndex, menuItemColIndex, componentIndexInCell);
		}
		
		/**
		 * Dispatches a MOUSE_OVER Event on the UIComponent of a menu item at a given
		 * row and column index.  This registers the MOUSE_UP listener on the UIComponent
		 * which is needed in order for the menu bar to simulate the selection of a menu
		 * item.  Next the function dispatches the MOUSE_UP Event on the same UIComponent
		 * silmulating what would happen if a user clicks the MenuBar menu item at a given
		 * row and column index. If the cell at the given row and column has multiple 
		 * UIComponents provided use the componentIndexInCell in the function signature.
		 *
		 * @param  menuBarId  The ID of the Flex MenuBar object
		 * @param  menuBarItemIndex  The index of the MenuBarItem of the MenuBar
		 * @param  menuItemRowIndex  The row index within the Menu containing the Component to be clicked
		 * @param  menuItemColIndex  The column index within the Menu containing the Component to be clicked
		 * @param  componentIndexInCell The index of the component within the menuItemRowIndex and menuItemColIndex
		 * @return	'true' if the component was clicked. An error message if the call fails.
		 */
		public function rawFlexClickMenuBarUIComponent(menuBarId:String, menuBarItemIndex:String, menuItemRowIndex:String, 
			menuItemColIndex:String, componentIndexInCell:String = "0"):String
		{
			var child:Object = appTreeParser.getElement(menuBarId);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [menuBarId]);
			}
			
			if(menuBarItemIndex > child.numChildren)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_NO_CHILD_INDEX, [menuBarItemIndex,menuBarId]);
			}
			
			// Add 1 to the index because the first is the MenuBar skin
			var menuBarItem:Object = child.getChildAt(int(menuBarItemIndex) + 1);
			menuBarItem.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
			menuBarItem.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			var menu:Object = child.menus[int(menuBarItemIndex)];

			// Assumes the MenuBar has only one ListBaseContentHolder
			var mbContentList:Object = Tools.getChildrenOfTypeFromContainer(menu,
					ReferenceData.LISTBASECONTENTHOLDER_DESCRIPTION)[0];

			// Make certain the rowIndex and colIndex do not exceed the length of the 
			// MenuBar ListBaseContentHolder's rows and columns.
			if(mbContentList.listItems.length > int(menuItemRowIndex) && 
					mbContentList.listItems[int(menuItemRowIndex)].length > int(menuItemColIndex))
			{
				var uiComponent:Object = mbContentList.listItems[int(menuItemRowIndex)][int(menuItemColIndex)].getChildAt(componentIndexInCell);
				uiComponent.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
				return String(uiComponent.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP)));
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_NO_CHILD_UICOMPONENT, [menuBarId,menuItemRowIndex,menuItemColIndex]);
		}
		
		/**
		 * Clicks a Component based on its label at a given column index.
		 * Example of the value parameter as passed from Selenium IDE
		 * 
		 * Command:	flexClickDataGridItem
		 * Target:	myDataGridItem
		 * Value:	1,2
		 * 
		 * Breakdown:
		 * 
		 * Command:	<command>
		 * Target:	<menubar id>
		 * Value:	<colIndex>,<itemText>
		 * 
		 * All fields are compulsory
		 * 
		 * @param  id  The ID of the Datagrid object
		 * @param  value  The colum index of the item in the Datagrid
		 * @return  'true' if the click succeeds, error if not.
		 */
		public function doFlexClickDataGridItem(id:String, value:String):String
		{
			var args:Array = value.split(",");
			var colIndex:String = args[0];
			var itemText:String = args[1];
			
			return rawFlexClickDataGridItem(id, colIndex, itemText);
		}
		
		/**
		 * Clicks a Component based on its label at a given column index.
		 *
		 * @param  datagridId  The ID of the Datagrid object
		 * @param  colIndex  The colum index of the item in the Datagrid
		 * @param  itemText The Text of the item label or text
		 */
		public function rawFlexClickDataGridItem(datagridId:String, colIndex:String, itemText:String):String
		{
			var child:Object = appTreeParser.getElement(datagridId);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [datagridId]);
			}
				
			// Assumes the DataGrid has only one ListBaseContentHolder
			var dgContentList:Object = Tools.getChildrenOfTypeFromContainer(child, 
					ReferenceData.LISTBASECONTENTHOLDER_DESCRIPTION)[0];

			for each (var array:Array in dgContentList.listItems)
			{
				var item:Object = array[int(colIndex)];	
				if(item.hasOwnProperty("numChildren"))
				{
					for(var i:int = 0;i < item.numChildren;i++)
					{ 
						if((item.getChildAt(i).hasOwnProperty("text") && (item.getChildAt(i).text == itemText)) || 
								(item.getChildAt(i).hasOwnProperty("label") && (item.getChildAt(i).label == itemText)))
						{
							return String(item.getChildAt(i).dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
						}
					}
				}
				if((item.hasOwnProperty("text") && (item.text == itemText)) || 
						(item.hasOwnProperty("label") && (item.label == itemText)))
				{
					return String(item.getChildAt(i).dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
				}
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_TEXT_NOT_FOUND, [itemText,colIndex]);
		}


	        /**
	         * Dispatches a ListEvent.ITEM_DOUBLE_CLICK (MouseEvent.DOUBLE_CLICK) Event on the UIComponent of a Datagrid at a given
	         * row and column index.  If the cell at the given row and column has multiple
	         * UIComponents provid the componentIndexInCell in the function signature.
	         *
	         * @param  id  The ID of the Datagrid object
	         * @param  value       Takes the form "<DataGridRowIndex>,<DataGridColIndex>"
	         * @return    'true' if the button was clicked. An error message if the call fails.
	         */
	        public function doFlexDoubleClickDataGridUIComponent(id:String, value:String):String 
		{
	            var args:Array = value.split(",");
	            var dataGridRowIndex:String = args[0];
	            var dataGridColIndex:String = args[1];

        	    return context.dataGridCommands.rawFlexDoubleClickDataGridUIComponent(id, dataGridRowIndex, dataGridColIndex);
	        }
	}
}
