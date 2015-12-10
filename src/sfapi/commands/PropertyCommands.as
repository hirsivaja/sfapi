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
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.Application;
	import mx.core.UIComponent;
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

		/*
		* Get the global position of the Flex object
		* @param id the id of the element
		* @return x and y coordinates of the object
		*/
		public function getFlexGlobalPosition(id:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			var pt:Point = element.localToGlobal(new Point(0, 0));
			return String(pt.x + "," + pt.y);
		}

		/*
		* Get the global position of the Flex object
		* @param id  the id of the element
		* @param returnPoint  Return a Point object
		* @return x and y coordinates of the object or a Point object
		*/
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

		/**
		 * Get a components info, x,y,w,h
		 * @param id  the id of the element
		 * @return x and y coordinates of the object. Object width and height.
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
		* @param id the id of the element
		* @param args comma-separated list of properties
		* @return List of property values
		*/
		public function rawFlexProperties(id:String, args:String):String
		{
			var ret:Array = [];
			var props:Array = args.split(",");
			for (var x:int = 0; x < props.length; x++) {
				ret.push(rawFlexProperty(id, props[x]));
			}
			return ret.join();
		}

		/**
		 * Retrieves an object Property
		 * @param  id  The ID of the Flex object
		 * @param  value  Property of the element to check
		 * @return  the string value of the property
		 */
		public function getFlexProperty(id:String, value:String):Object
		{
			return rawFlexProperty(id, value);
		}

		/**
		 * Retrieves an object Property
		 * @param  id  The ID of the Flex object
		 * @param  property of the element to check
		 * @return  the string value of the property
		 */
		public function rawFlexProperty(id:String, property:String):Object
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
					return retval;
				}
				return retval.toString();
			}
			return null;
		}

		/**
		 * Set a components property
		 * @param  id  The ID of the Flex object AND the property to set. For example: 'button1.text'
		 * @param  setval  the value to set
		 * @return  true if success otherwise an error message
		 */
		public function doFlexProperty(id:String, setval:String):String
		{
			var locator:Array = id.split(".");
			id = locator[0];
			var property:String = locator[1];
			var child:Object = appTreeParser.getElement(id);

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
		 * Retrieves the value of 'visible' property
		 * @param  id  The ID of the Flex object
		 * @param  args  Not used
		 * @return   true if the component is visible
		 */
		public function getFlexVisible(id:String, args:String):String
		{
			var element:Object = appTreeParser.getElement(id);
			if(element == null || !element is UIComponent)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			if(element.hasOwnProperty("visible"))
			{
				return isVisible(element).toString();
			}
		    return ErrorMessages.getError(ErrorMessages.ERROR_NO_PROPERTY, [id]);
		}

		/**
		 * Check a component is visible or not.
		 * @param component  The ui component
		 * @return  true if the component is visible
		 */
		public static function isVisible(component : Object) : Boolean {
			if (component == null || !component is UIComponent)
			{
				return true;
			}
			if (component is Application)
			{
				return component.visible;
			}
			return component.visible && isVisible(component.parent);
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
		 * Retrieves the 'errorString' property
		 * @param  id  The ID of the Flex object
		 * @param  args  Not used
		 * @return  the error string or an error message if the call fails
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
		 * Retrieves whether a control exists or not
		 * @param  id  The ID of the Flex object to find
		 * @param  args  Not used
		 * @return  'true' if object exists, 'false' if not
		 */
		public function getFlexExists(id:String, args:String):String
		{
			return appTreeParser.getElement(id) ? 'true' : 'false';
		}
		
		/**
		 * Get a list of all the direct child elements
		 * @param	id  The id of the object which children we want
		 * @param	getFullPath  Return full path or only the last identifier
		 * @param	visible  Return only visible children
		 * @return  Paths of the child elements
		 */
		public function getFlexChildren(id:String, getFullPath:String, visible:String):String
		{
			var element:Object;
			if(Application.application.hasOwnProperty(id))
			{
				element = Application.application[id];
			}
			else
			{
				element = appTreeParser.getElement(id);
			}
			if(!element)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			var children:Array = new Array();
			var child:Object;
			for (var childNr:int = 0;  childNr < element.numChildren; childNr++) 
			{
				child = element.getChildAt(childNr);
				if (child.visible || visible == 'false') 
				{
					if (getFullPath == 'false') 
					{
						children.push(child.toString().split(".").pop());
					} 
					else 
					{
						children.push(child);
					}
				}
			}
			return children.toString();
		}
		
		/**
		 * Retrieves child label of tab navigator by it's id
		 * @param id The ID of the Flex object to find
		 * @return child elements as a String separated by ","
		 */
		public function getFlexTabLabels(id:String):String {
			var childs:String = "";
			var child:Object = appTreeParser.getElement(id);

			for(var i:int = 0; i < child.numChildren; i++) {
				var tab:Object = child.getTabAt(i);
				if (i+1 != child.numChildren) {
					childs += tab.label + ",";
				}
				else {
					childs += tab.label;
				}
			}
			return childs;
		}
	}
}
