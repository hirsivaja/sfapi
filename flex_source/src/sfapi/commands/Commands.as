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
	import flash.external.ExternalInterface;
	import mx.controls.Alert;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	
	public class Commands
	{
		public var alertCommands:AlertCommands;
		public var checkBoxCommands:CheckBoxCommands;
		public var clickCommands:ClickCommands;
		public var dateCommands:DateCommands;
		public var propertyCommands:PropertyCommands;
		public var radioButtonCommands:RadioButtonCommands;
		public var selectCommands:SelectCommands;
		public var stepperCommands:StepperCommands;
		public var textCommands:TextCommands;
		public var utilCommands:UtilCommands;
		public var waitCommands:WaitForCommands;
		public var mouseCommands:MouseCommands;
		public var comboCommands:ComboCommands;
		public var dataGridCommands:DataGridCommands;
		public var notifyCommands:NotifyCommands;
		public var keyCommads:KeyCommands;
		
		public function Commands(aptObj:AppTreeParser)
		{
			alertCommands = new AlertCommands(aptObj, this);
			checkBoxCommands = new CheckBoxCommands(aptObj, this);
			clickCommands = new ClickCommands(aptObj, this);
			dateCommands = new DateCommands(aptObj, this);
			propertyCommands = new PropertyCommands(aptObj, this);
			radioButtonCommands = new RadioButtonCommands(aptObj, this);
			selectCommands = new SelectCommands(aptObj, this);
			stepperCommands = new StepperCommands(aptObj, this);
			textCommands = new TextCommands(aptObj, this);
			utilCommands = new UtilCommands(aptObj, this);
			waitCommands = new WaitForCommands(aptObj, this);
			mouseCommands = new MouseCommands(aptObj, this);
			comboCommands = new ComboCommands(aptObj, this);
			dataGridCommands = new DataGridCommands(aptObj, this);
			notifyCommands = new NotifyCommands(aptObj, this);
			keyCommads = new KeyCommands(aptObj, this);
			
			/**
			 * NOTE: When adding a command make sure it conforms to the standard of beginning 
			 * with the word 'do' for action commands and 'get' for data retrieval commands.
			 * This is because the file user-extensions.js file is generated automatically by a perl
			 * script which reads this file to get a list of the available commands, and the script
			 * relies on the convention to determine what script elements to generate.
			 * If you want to make an exceptional case javascript calling function then please reflect 
			 * this in the generator script and use the script to generate your new user-exensions.js file.
			 * The generator script is called gernerate-user-extensions.pl and is in the same directory
			 * as the file user-extensions.js
			 * 
			 * Any commands here that are prefixed with "raw" can be directly called with the number of
			 * arguments which is intended to allow interfacing more easily with code-based frameworks.
			 * 
			 * All the other commands must conform to the 2 parameter argument format of id and value
			 * to allow easy interfacing with the Selenium IDE. 
			 * 
			 **/
			if(ExternalInterface.available)
			{
				/*REF
				 * TODO: complete api reference documentation 
				 */
			    ExternalInterface.addCallback("getFlexSelectedItemAtIndex", 
			    				selectCommands.getFlexSelectedItemAtIndex);
			    				
			    ExternalInterface.addCallback("getFlexNumSelectedItems", 
			    				selectCommands.getFlexNumSelectedItems);
			    				
				ExternalInterface.addCallback("getFlexVisible",
							  propertyCommands.getFlexVisible);
							  
				ExternalInterface.addCallback("getFlexTextPresent",
								  textCommands.getFlexTextPresent);
								  
				ExternalInterface.addCallback("getFlexText",
								  textCommands.getFlexText);
								  
				ExternalInterface.addCallback("getFlexStepper", 
							   stepperCommands.getFlexStepper);
							   
				ExternalInterface.addCallback("getFlexSelectionIndex",
								selectCommands.getFlexSelectionIndex);
								
				ExternalInterface.addCallback("getFlexSelection",
								selectCommands.getFlexSelection);
								
				ExternalInterface.addCallback("getFlexRadioButton",
						   radioButtonCommands.getFlexRadioButton);
						   
				ExternalInterface.addCallback("getFlexProperty",
							  propertyCommands.getFlexProperty);
							  
				ExternalInterface.addCallback("getFlexParseInt", 
							 	  textCommands.getFlexParseInt);
							  
				ExternalInterface.addCallback("getFlexNumeric", 
							 	  textCommands.getFlexNumeric);
							  
				ExternalInterface.addCallback("getFlexGlobalPosition", 
							  propertyCommands.getFlexGlobalPosition);
							  
				ExternalInterface.addCallback("getFlexExists", 
							  propertyCommands.getFlexExists);
							  
				ExternalInterface.addCallback("getFlexErrorString", 
							  propertyCommands.getFlexErrorString);
							  
				ExternalInterface.addCallback("getFlexEnabled", 
							  propertyCommands.getFlexEnabled);
							  
				ExternalInterface.addCallback("getFlexDate", 
							 	  dateCommands.getFlexDate);
							  
				ExternalInterface.addCallback("getFlexDataGridUIComponentLabel", 
							 	  textCommands.getFlexDataGridUIComponentLabel);
							  
				ExternalInterface.addCallback("getFlexDataGridRowIndexForFieldValue", 
							  dataGridCommands.getFlexDataGridRowIndexForFieldValue);
							  
				ExternalInterface.addCallback("getFlexDataGridRowCount", 
							  dataGridCommands.getFlexDataGridRowCount);
							  
				ExternalInterface.addCallback("getFlexDataGridFieldValueForGridRow", 
							  dataGridCommands.getFlexDataGridFieldValueForGridRow);
							  
				ExternalInterface.addCallback("getFlexDataGridCellText", 
							 	  textCommands.getFlexDataGridCellText);
							  
				ExternalInterface.addCallback("getFlexDataGridCell", 
							  dataGridCommands.getFlexDataGridCell);
							  
				ExternalInterface.addCallback("getFlexComponentInfo", 
							  propertyCommands.getFlexComponentInfo);
							  
				ExternalInterface.addCallback("getFlexComboContainsLabel", 
							 	 comboCommands.getFlexComboContainsLabel);
							  
				ExternalInterface.addCallback("getFlexCheckBoxChecked", 
							 	 checkBoxCommands.getFlexCheckBoxChecked);
							  
				ExternalInterface.addCallback("getFlexAlertTextPresent", 
							 	 alertCommands.getFlexAlertTextPresent);
							  
				ExternalInterface.addCallback("getFlexAlertText", 
							 	 alertCommands.getFlexAlertText);
							  
				ExternalInterface.addCallback("getFlexAlertPresent", 
							 	 alertCommands.getFlexAlertPresent);

				ExternalInterface.addCallback("getFlexDataGridCheckBoxChecked",
							 	 dataGridCommands.getFlexDataGridCheckBoxChecked);

				ExternalInterface.addCallback("getFlexDataGridRowIndexForFieldLabel",
							 	 dataGridCommands.getFlexDataGridRowIndexForFieldLabel);
				// Action commands
				
				ExternalInterface.addCallback("doFlexWaitForElementVisible", 
							 	  waitCommands.doFlexWaitForElementVisible);
							  
				ExternalInterface.addCallback("doFlexWaitForElement", 
							 	  waitCommands.doFlexWaitForElement);
							  
				ExternalInterface.addCallback("doFlexTypeAppend", 
							 	  textCommands.doFlexTypeAppend);
							  
				ExternalInterface.addCallback("doFlexType", 
							 	  textCommands.doFlexType);
							  
				ExternalInterface.addCallback("doFlexStepper", 
							   stepperCommands.doFlexStepper);
							  
				ExternalInterface.addCallback("doFlexSetFocus", 
								 mouseCommands.doFlexSetFocus);
				
				ExternalInterface.addCallback("doFlexSetDataGridCell", 
							  dataGridCommands.doFlexSetDataGridCell);
							  
				ExternalInterface.addCallback("doFlexSelectMatchingOnField", 
							    selectCommands.doFlexSelectMatchingOnField);
							  
				ExternalInterface.addCallback("doFlexSelectIndex", 
							    selectCommands.doFlexSelectIndex);
							  
				ExternalInterface.addCallback("doFlexSelectComboByLabel", 
								 comboCommands.doFlexSelectComboByLabel);
							  
				ExternalInterface.addCallback("doFlexSelect", 
							    selectCommands.doFlexSelect);
							  
				ExternalInterface.addCallback("doFlexRefreshIDToolTips", 
							 	  utilCommands.doFlexRefreshIDToolTips);
							  
				ExternalInterface.addCallback("doFlexRadioButton", 
						   radioButtonCommands.doFlexRadioButton);
							  
				ExternalInterface.addCallback("doFlexProperty", 
							  propertyCommands.doFlexProperty);
							  
				ExternalInterface.addCallback("doFlexMouseUp", 
							 	 mouseCommands.doFlexMouseUp);
							  
				ExternalInterface.addCallback("doFlexMouseEvent", 
							 	 mouseCommands.doFlexMouseEvent);
							  
				ExternalInterface.addCallback("doFlexMouseRollOver",
							 	 mouseCommands.doFlexMouseRollOver);
							  
				ExternalInterface.addCallback("doFlexMouseRollOut",
							  	 mouseCommands.doFlexMouseRollOut);
							  
				ExternalInterface.addCallback("doFlexMouseOver", 
							 	 mouseCommands.doFlexMouseOver);
							  
				ExternalInterface.addCallback("doFlexMouseMove", 
							 	 mouseCommands.doFlexMouseMove);
							  
				ExternalInterface.addCallback("doFlexMouseDown", 
							 	 mouseCommands.doFlexMouseDown);
							  
				ExternalInterface.addCallback("doFlexRightMouseDown", 
							 	 mouseCommands.doFlexRightMouseDown);
							  
				ExternalInterface.addCallback("doFlexDragTo",
							 	 mouseCommands.doFlexDragTo);
							  
				ExternalInterface.addCallback("doFlexDoubleClick", 
							 	 clickCommands.doFlexDoubleClick);
							  
				ExternalInterface.addCallback("doFlexDate", 
							 	  dateCommands.doFlexDate);
							  
				ExternalInterface.addCallback("doFlexClickMenuBarUIComponent", 
							 	 clickCommands.doFlexClickMenuBarUIComponent);
							  
				ExternalInterface.addCallback("doFlexClickDataGridUIComponent", 
							 	 clickCommands.doFlexClickDataGridUIComponent);
							  
				ExternalInterface.addCallback("doFlexClickDataGridItem", 
							 	 clickCommands.doFlexClickDataGridItem);
							  
				ExternalInterface.addCallback("doFlexClick", 
							 	 clickCommands.doFlexClick);
							  
				ExternalInterface.addCallback("doFlexCheckBox", 
							  checkBoxCommands.doFlexCheckBox);
							  
				ExternalInterface.addCallback("doFlexAlertResponse", 
							 	 alertCommands.doFlexAlertResponse);
							  
				ExternalInterface.addCallback("doFlexAddSelectMatchingOnField", 
							 	selectCommands.doFlexAddSelectMatchingOnField);
							  
				ExternalInterface.addCallback("doFlexAddSelectIndex", 
							 	selectCommands.doFlexAddSelectIndex);
							  
				ExternalInterface.addCallback("doFlexNotify", 
							 	notifyCommands.doFlexNotify);
				
				ExternalInterface.addCallback("doFlexEnterKey", 
							 	keyCommads.doFlexEnterKey);

                ExternalInterface.addCallback("doFlexDoubleClickDataGridUIComponent",
                        clickCommands.doFlexDoubleClickDataGridUIComponent);
                ExternalInterface.addCallback("doFlexDataGridDate",
                        dataGridCommands.doFlexDataGridDate);
                ExternalInterface.addCallback("doFlexDataGridCheckBox",
                        dataGridCommands.doFlexDataGridCheckBox);
                ExternalInterface.addCallback("doFlexDataGridClickColumnHeader",
                        dataGridCommands.doFlexDataGridClickColumnHeader);
                ExternalInterface.addCallback("doFlexDataGridSelectComboByLabel",
                        dataGridCommands.doFlexDataGridSelectComboByLabel);

				// Raw commands
				
				ExternalInterface.addCallback("rawFlexClickMenuBarUIComponent",
							 	 clickCommands.rawFlexClickMenuBarUIComponent);

				ExternalInterface.addCallback("rawFlexClickDataGridItem",
							 	 clickCommands.rawFlexClickDataGridItem);

				ExternalInterface.addCallback("rawFlexSetDataGridCell",
							  dataGridCommands.rawFlexSetDataGridCell);

				ExternalInterface.addCallback("rawFlexSelectMatchingOnField",
							 	selectCommands.rawFlexSelectMatchingOnField);

				ExternalInterface.addCallback("rawFlexDataGridCell",
							  dataGridCommands.rawFlexDataGridCell);

				ExternalInterface.addCallback("rawFlexDataGridRowIndexForFieldValue",
							  dataGridCommands.rawFlexDataGridRowIndexForFieldValue);

				ExternalInterface.addCallback("rawFlexDataGridRowIndexForFieldLabel",
							  dataGridCommands.rawFlexDataGridRowIndexForFieldLabel);

				ExternalInterface.addCallback("rawFlexDataGridFieldValueForGridRow",
							  dataGridCommands.rawFlexDataGridFieldValueForGridRow);

				ExternalInterface.addCallback("rawFlexDataGridFieldLabelForGridRow",
							  dataGridCommands.rawFlexDataGridFieldLabelForGridRow);

				ExternalInterface.addCallback("rawFlexProperty",
							  propertyCommands.rawFlexProperty);

				ExternalInterface.addCallback("rawFlexDataGridUIComponentLabel",
							 	  textCommands.rawFlexDataGridUIComponentLabel);

				ExternalInterface.addCallback("rawFlexDataGridCellText",
							 	  textCommands.rawFlexDataGridCellText);
				
				ExternalInterface.addCallback("rawFlexProperties", 
			  					  propertyCommands.rawFlexProperties);
			  	
			  	ExternalInterface.addCallback("rawFlexGlobalPosition", 
			  					  propertyCommands.rawFlexGlobalPosition);
			  	
			  	ExternalInterface.addCallback("rawFlexComboContainsLabel", 
			  					 comboCommands.rawFlexComboContainsLabel);

			}
			else
			{
				Alert.show(ErrorMessages.ERROR_EXT_INTERFACE_NOT_AVAIL);
			}
		}
	}
}
