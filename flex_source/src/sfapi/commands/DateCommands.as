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
	
	import mx.controls.DateField;
	import mx.events.CalendarLayoutChangeEvent;
	
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.ReferenceData;
	import sfapi.core.Tools;
	
	public class DateCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function DateCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/**
		 * Sets the date in a date control
		 * @param  id  The ID of the Flex object
		 * @param  args	the date string
		 * @return  'true' if the DateField is set. An error message if the call fails.
		 */
		public function doFlexDate(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			var objectType:String = Tools.getOjectType(child);
			
			if(objectType == ReferenceData.DATECHOOSER_DESCRIPTION || objectType == ReferenceData.DATEFIELD_DESCRIPTION)
			{

				if(objectType == ReferenceData.DATECHOOSER_DESCRIPTION)
				{
					return setDateChooser(child, args);
				}
				else
				{
					return setDateField(child, args);
				}
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, 
						[id, ReferenceData.DATEFIELD_DESCRIPTION + " or " +	ReferenceData.DATECHOOSER_DESCRIPTION]);
			}
			return null;
		}
		
		private function setDateChooser(child:Object, dateString:String):String
		{
			child.selectedDate = compileDateValue(dateString, "None");
			var changeEvent:CalendarLayoutChangeEvent = new CalendarLayoutChangeEvent("change", false, false, null, new Event("change"));
			var retval:String;
			try
			{
				retval = String(child.dispatchEvent(changeEvent));
			}
			catch(error:Error)
			{
				retval = error.name + " --- " + error.message + " --- " + error.errorID + " --- " + error.getStackTrace();
			}
			return retval;
		}
		
		private function setDateField(child:Object, dateString:String):String
		{
			child.selectedDate = compileDateValue(dateString, child.formatString);
			var changeEvent:CalendarLayoutChangeEvent = new CalendarLayoutChangeEvent("change", false, false, null, new Event("change"));
			var retval:String;
			try
			{
				retval = String(child.dispatchEvent(changeEvent));
			}
			catch(error:Error)
			{
				retval = error.name + " --- " + error.message + " --- " + error.errorID + " --- " + error.getStackTrace();
			}
			return retval;
		}
				
		/**
		 * Retrieves the date in a Date related control control
		 * @param  id  The ID of the Flex object
		 * @param
		 * @return  the date in the control or an error message if the call fails
		 */
		public function getFlexDate(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}

			var objectType:String = Tools.getOjectType(child);
			
			if(objectType == ReferenceData.DATECHOOSER_DESCRIPTION || objectType == ReferenceData.DATEFIELD_DESCRIPTION)
			{
				if(objectType == ReferenceData.DATECHOOSER_DESCRIPTION)
				{
					return child.selectedDate;
				}
				else
				{			        
				    return DateField.dateToString(child.selectedDate, child.formatString);
				}
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH, 
						[id, ReferenceData.DATEFIELD_DESCRIPTION + " or " +	ReferenceData.DATECHOOSER_DESCRIPTION]);
			}
			return null;
		}
		
		/**
		 * Compiles a date value from the argument passed
		 * @param  args  The date specifier. 
		 * @return  a date represented by a string value
		 */
		private function compileDateValue(args:String, dateFormat:String):Date
		{
			var retval:Date = new Date();
			if(ReferenceData.TODAY.indexOf(args.toLowerCase()) >= 0)
			{
				retval.setTime(retval.getTime());
			}
			else if(args.match(/^[-+]?\d+$/))
			{
				var msOffset:Number = ReferenceData.MILLISECONDS_IN_DAY * parseInt(args);
				retval.setTime(retval.getTime() + msOffset);
			}
			else if(args.toLowerCase() == 'tomorrow')
			{
				retval.setTime(retval.getTime() + ReferenceData.MILLISECONDS_IN_DAY);
			}
			else if(args.toLowerCase() == 'yesterday')
			{
				retval.setTime(retval.getTime() - ReferenceData.MILLISECONDS_IN_DAY);
			}
			else if(dateFormat == "None")
			{
				retval = DateField.stringToDate(args, "MM/DD/YYYY");
			}
			else
			{
				retval = DateField.stringToDate(args, dateFormat);
			}
			return retval;
		}
	}
}