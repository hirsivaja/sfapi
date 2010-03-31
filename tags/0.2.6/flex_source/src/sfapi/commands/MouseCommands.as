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
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import mx.core.DragSource;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import sfapi.core.AppTreeParser;
	import sfapi.core.ErrorMessages;
	import sfapi.core.RunCommands;
	
	public class MouseCommands
	{
		private var appTreeParser:AppTreeParser;
		
		public function MouseCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		/**
		 * Dispatches a Mouse event on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseEvent(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent(args, true, false, 0, 0, null, false, false, false, true )));
		} 
		
		/**
		 * Dispatches a Mouse Down event on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseDown(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, 0, 0, null, false, false, false, true )));
		} 
		
		/**
		 * Dispatches a Right Mouse Down event on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexRightMouseDown(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent("rightMouseDown") ));
		}

		/**
		 * Dispatches a Mouse Up event on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseUp(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP)));
		} 	

		/**
		 * Dispatches a Mouse Over event on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseOver(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER)));
		}
		
		/**
		 * Dispatches a Mouse move event on an Element, moving the mouse to aposition as specified by pos
		 * @param  id  The ID of the Flex object
		 * @param  pos	the x, y coordinates to move the mouse to
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseMove(id:String, pos:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			var loc:Array = pos.split(",");			
			var x:Number = Number(loc[0]);
			var y:Number = Number(loc[1]);
			
			return String(child.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x, y, null, false, false, false, true)));
		}
		
		/**
		 * Dispatches a Mouse Roll Over event on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseRollOver(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER)));
		} 
		
		/**
		 * Dispatches a Mouse Roll Out on an Element
		 * @param  id  The ID of the Flex object
		 * @return	'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexMouseRollOut(id:String, args:String):String
		{
			var child:Object =  appTreeParser.getElement(id);
			
			if(child == null)
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			return String(child.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT)));
		} 
		
		/**
		 * Drags an Element
		 * The element needs to to have the mouseMoveDragHandler function
		 * @param  id  The ID of the Flex object
		 * @param  pos the X,Y destination
		 * @return 'true' if the event disptached. An error message if the call fails.
		 */
		public function doFlexDragTo(id:String, pos:String):String
		{
			var child:Object = appTreeParser.getElement(id);
			while (child && (!child.hasEventListener(MouseEvent.MOUSE_DOWN) || !child.parent))
			{
				child = child.parent;				
			}
			if(!child || !child.hasEventListener(MouseEvent.MOUSE_DOWN))
			{
				return ErrorMessages.getError(ErrorMessages.ERROR_ELEMENT_NOT_FOUND, [id]);
			}
			
			var loc:Array = pos.split(",");			
			var x:Number = Number(loc[0]);
			var y:Number = Number(loc[1]);
			
			var cmds:RunCommands = new RunCommands(child);
			
			// run drag commands (with 3 mouse_moves, to ensure all dragging is caught)
			cmds.runDragCommands([
				new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, 0,0),
				new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x/6, y/6,null,false,false,false,true),
				new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x/4, y/4,null,false,false,false,true),
				new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x/3, y/3,null,false,false,false,true),
				new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x/2, y/2,null,false,false,false,true),
				new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x/1.2, y/1.2,null,false,false,false,true),
				new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, x, y,null,false,false,false,true),
				new MouseEvent(MouseEvent.MOUSE_UP, true, false, x, y)					
			]);
			
			// dispatch a DragComplete event 
			var dragComplete:DragEvent = new DragEvent(DragEvent.DRAG_COMPLETE, false, true, child as IUIComponent, child as DragSource, null, false, false, false);
		    return String(child.dispatchEvent(dragComplete));
		}
	
		public function doFlexSetFocus(id:String) : String {
			var result:String;
		
			try
			{
				var widget:Object = appTreeParser.getWidgetById(id);
		
				widget.setFocus();
				
				result = String(widget.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN)));		
			}
			catch (e:Error) {
				result = "ERROR: Widget '" + id + "': " + e.message;
			}
			
			return result;
		}
	}
}