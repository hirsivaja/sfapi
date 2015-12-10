/*  
 *  License
 *  
 *  This file is part of The SeleniumFlex-API.
 *  
 *  The SeleniumFlex-API is free software: you can redistribute it and/or
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
 *  If not, see http://www.gnu.org/licenses/
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
	
	public class DateCommands extends AbstractCommand
	{
		public function DateCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
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
			
			return rawSetFlexDate(child, args);
		}

		/**
		 * Sets the date in a date control
		 * @param  child  The Flex date object
		 * @param  args	the date string
		 * @return  'true' if the DateField is set. An error message if the call fails.
		 */
		public function rawSetFlexDate(child:Object, args:String):String
		{
			var isDateChooser:Boolean = Tools.isA(child, ReferenceData.DATECHOOSER_DESCRIPTION);
			var isDateField:Boolean = Tools.isA(child, ReferenceData.DATEFIELD_DESCRIPTION);
			var isBigButtonsDateChooser:Boolean = Tools.isA(child, "BigButtonsDateChooser", true);
			var isDateTimeField:Boolean = Tools.isA(child, "DateTimeField", true);
			if (isDateChooser || isBigButtonsDateChooser || isDateTimeField)
			{
				return setDateChooser(child, args);
			}
			else if (isDateField)
			{
				return setDateField(child, args);
			}
			return ErrorMessages.getError(ErrorMessages.ERROR_TYPE_MISMATCH,
					[child, ReferenceData.DATEFIELD_DESCRIPTION + " or " + ReferenceData.DATECHOOSER_DESCRIPTION]);
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
		 * @param  args  Not used
		 * @return  the date in the control or an error message if the call fails
		 */
		public function getFlexDate(id:String, args:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}

			var objectType:String = Tools.getObjectType(child);
			
			if(objectType == ReferenceData.DATECHOOSER_DESCRIPTION || 
				objectType == ReferenceData.DATEFIELD_DESCRIPTION || 
				objectType.indexOf("BigButtonsDateChooser") >= 0 || 
				objectType.indexOf("DateTimeField") >= 0)
			{
				if(objectType == ReferenceData.DATEFIELD_DESCRIPTION)
				{
					return DateField.dateToString(child.selectedDate, child.formatString);
				}
				else
				{
					return child.selectedDate;
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
		public function compileDateValue(args:String, dateFormat:String):Date
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