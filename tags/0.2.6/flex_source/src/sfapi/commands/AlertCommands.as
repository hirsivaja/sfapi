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
	import flash.utils.describeType;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.ReferenceData;
	
	public class AlertCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function AlertCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/*
		 * 
		 */
		/**
		 * Responds to an alert (ok, cancel, yes, no, etc...)
		 * @param  id  The ID of the Flex object
		 * @param
		 * @return  'true' if the response was successful, otherwise an error message
		 */
		public function doFlexAlertResponse(response:String, args:String):String
		{
			// get the alert object
			var myAlert:Object = getAlert();
			var retval:String;
			if(myAlert)
			{
				// get a handle on the alert's ok button
				var alertButton:Object = getAlertButton(myAlert.getChildAt(0), response);
				// click the button
				if(alertButton)
				{
					retval = String(alertButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK)));
				}
				else
				{
					retval = ErrorMessages.getError(ErrorMessages.ERROR_ALERT_BUTTON, [args]);
				}
			}
			else
			{
				retval = ErrorMessages.getError(ErrorMessages.ERROR_NO_ALERT, []);
			}
			return retval;
		}
		
		/**
		 * Determines if a string is part of an Alerts text or label property
		 * @param  searchStr  the string to search for in the control
		 * @return  'true' if searchStr is present, 'false' if not
		 */
		public function getFlexAlertTextPresent(searchStr:String, args:String):String
		{
			var retval:String;
			var alertText:String = getFlexAlertText('', '');
			
			if(alertText)
			{
				if(alertText.search(searchStr) > -1)
				{
					retval = 'true';
				}
				else
				{
					retval = ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [searchStr]);
				}
			}
			else
			{
				retval = ErrorMessages.getError(ErrorMessages.ERROR_ALERT_TEXT, []);
			}
			return retval;
		}
		
		// todo remove args here. will need to be refleced in special case in javascript
		/**
		 * Checks if an Alert is being displayed
		 * @return  'true' if an alert is present, 'false' if not.
		 */
		public function getFlexAlertPresent(args:String, args2:String):String
		{
			// get the alert object
			var alertNode:Object = getAlert();
			var retval:String;
			if(alertNode != null)
			{
				retval = ReferenceData.TRUE_STRING;
			}
			else
			{
				retval = ReferenceData.FLASE_STRING;
			}
			return retval;
		}
		
		/**
		 * Returns the text displayed in an alert. The first alert displayed is returned
		 * @return  The text value of the alert
		 */
		public function getFlexAlertText(args1:String = "", args2:String = ""):String
		{
			// get the alert object
			var alertNode:Object = getAlert();
			var retval:String;
			
			if(alertNode)
			{
				// navigate the alert's object tree down to the text control
				var formNode:Object = alertNode.getChildAt(0);
				// the text control
				var textNode:Object = formNode.getChildAt(0);
				
				if(textNode)
				{
					retval = textNode.text;
				}
				else
				{
					retval = ErrorMessages.getError(ErrorMessages.ERROR_ALERT_TEXT, []);
				}
			}
			else
			{
				retval = ErrorMessages.getError(ErrorMessages.ERROR_NO_ALERT, []);
			}
			return retval;
		}
		
		/**
		 * Get a handle on the alert control. The alert will reside as a child in the 
		 * applications parent (SystemManager) 
		 * @return  Handle to the alert control. Return null if alert not found.
		 */
		private function getAlert():Object
		{
			try
			{
				var root:Object = appTreeParser.thisApp.parent;
				for(var i:int = 0; i < root.numChildren; i++)
				{
					// get the child node of the 
					var child:Object = root.getChildAt(i);
					// get the XML type description of the child node
					var classInfo:XML = describeType(child);
					// return the child if its an alert control
					if(classInfo.@name.toString() == ReferenceData.ALERT_DESCRIPTION)
					{
						return child;
					}
				}
			}
			catch(e:Error) {}
			return null;
		}
		
		/**
		 * Returns a handle to a button control on an alert
		 * @param  alertForm  The alert form class which contins the controls on the alert
		 * @param  label  The label of the button to return
		 * @return  Handle to the button control. Return null if button not found.
		 */
		private function getAlertButton(alertForm:Object, label:String):Object
		{
			// loop through the children of the alert form
			// start at child 1 because child 0 will be a text control
			try
			{
				for(var i:int = 1; i < alertForm.numChildren; i++)
				{
					var alertButton:Object = alertForm.getChildAt(i);
					if(alertButton.label.toLowerCase() == label.toLowerCase())
					{
						return alertButton;
					}
				}
			}
			catch(e:Error) {}
			return null;
		}
	}
}