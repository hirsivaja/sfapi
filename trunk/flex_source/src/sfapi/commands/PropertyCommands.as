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
	import com.adobe.serialization.json.JSON;
	
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.Application;
	import mx.utils.ArrayUtil;
	
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.Tools;
	
	public class PropertyCommands extends AbstractCommand
	{
		public function PropertyCommands(aptObj:AppTreeParser, contextObj:Commands)
		{
			super(aptObj, contextObj);
		}
		
		// todo tell vince about changes
		// todo comm
		public function getFlexGlobalPosition(id:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			var pt:Point = element.localToGlobal(new Point(0, 0));
			return String(pt.x + "," + pt.y);
		}
		
		// todo tell vince about changes
		// todo comm
		public function rawFlexGlobalPosition(id:String, returnPoint:String):Object
		{
			var element:Object = appTreeParser.getElement(id);
			var pt:Point = element.localToGlobal(new Point(0, 0));
			if (returnPoint == 'true')
			{
				return pt;
			}
			return String(pt.x + "," + pt.y);
		}
		
		// todo comm
		/**
		 * Get a components info, x,y,w,h
		 */
		public function getFlexComponentInfo(id:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			var pt:Object = rawFlexGlobalPosition(id, 'true');
			var data:Array = [pt.x, pt.y, element.width, element.height];			
			return data.join(",");
		}
		
		/*
		* Process a list of requests for component properties
		* @param props the list is properties to process
		*/
		public function rawFlexProperties(props:String, args:String=null):String
		{
			props = unescape(props);
			var ret:Array = [];
			var list:Array = ArrayUtil.toArray(JSON.decode(props));
			var id:String;
			var property:String;
			for (var x:int=0; x < list.length;x++){
				id = 	list[x].substring(0, list[x].indexOf("."))
				property = list[x].substring(list[x].indexOf(".")+1, list[x].length)
				ret.push(rawFlexProperty(id, property,false));
				
			}
			
			var data:String = JSON.encode(ret);
			return escape(data);
		}
		
		public function getFlexProperty(id:String, value:String):Object
		{
			return rawFlexProperty(id, value, false);
		}
		
		/**
		 * Retrieves an object Property
		 * @param  id  The ID of the Flex object
		 * @param  property of the element to check
		 * @return  the string value of the property
		 */
		public function rawFlexProperty(id:String, property:String, json:Boolean = true):Object
		{
			var element:Object
			if(Application.application.hasOwnProperty(id))
			{
					element = Application.application[id];
			}
			else
			{
				element = appTreeParser.getElement(id);
			}
			if(! element)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			var props:Array = property.split(".");
			var retval:Object = element;
			
			for (var x:Number = 0; x < props.length; x++)
			{
				if(retval.hasOwnProperty(props[x]))
				{
					retval = retval[props[x]];
				}
				else
				{
					return ErrorMessages.getError(ErrorMessages.ERROR_NO_PROPERTY, [property, id]);
				}
			}
			if(retval != null)
			{
				var className:Object = getQualifiedClassName(retval);
				try
				{
					retval = retval();
				}
				catch(err:Error)
				{
					trace(err.message);
				}
				if(className == 'Object')
				{
					if(json)
					{
						return JSON.encode(retval);
					}
					return retval;
				}
				return retval.toString();
			}
			return null;
		}
		
		/**
		 * Set a components property
		 * @param  id  The ID of the Flex object
		 * @param  property of the element to set
		 * @return  true if success otherwise an error message
		 */
		public function doFlexProperty(id:String, setval:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			var locator:Array = id.split(".");
			id = locator[0];
			var property:String = locator[1];
			
			if(child.hasOwnProperty(property))
			{
				try
				{
					return Tools.setValueFromString(child, property, setval);
				}
				catch(e:Error)
				{
					return ErrorMessages.getError(ErrorMessages.ERROR_MESSAGE, [e.message]);
				}
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_PROPERTY_NOT_FOUND, [property, id]);
			}
			return null;
		}
		
		/**
		 * Retrieves the date in a DateField control
		 * @param  id  The ID of the Flex object
		 * @param  args
		 * @return  the date in the datefield or an error message if the call fails
		 */
		public function getFlexVisible(id:String, args:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			if(element == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			if(element.hasOwnProperty("visible"))
			{
				return element.visible.toString(); 
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_NO_PROPERTY, [id]);
			}
			return retval;
		}
		
		/**
		 * Determines if a element is enabled or not
		 * @param  id  The ID of the Flex object
		 * @param  args  nothing
		 * @return	the enabled state of the element ('true', 'false'). An error message if the call fails.
		 */
		public function getFlexEnabled(id:String, args:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			if(element == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			if(element.hasOwnProperty("enabled"))
			{
				return element.enabled.toString();
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ENABLED_NOT_APPLY, [id]);
			}
			return null;
		}
		
		/**
		 * Retrieves the date in a DateField control
		 * @param  id  The ID of the Flex object
		 * @param  args
		 * @return  the date in the datefield or an error message if the call fails
		 */
		public function getFlexErrorString(id:String, args:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			if(element == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			if(element.hasOwnProperty("errorString"))
			{
				return element.errorString.toString(); 
			}
			else
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_NO_PROPERTY, [id]);
			}
			return null;
		}
		
		/**
		 * Retrieves whether a cotrol exists or not
		 * @param  id  The ID of the Flex object to find
		 * @return  'true' if object exists, 'false' if not
		 */
		public function getFlexExists(id:String, args:String):String
		{
			return appTreeParser.getElement(id) ? 'true' : 'false';
		}
	}
}