package {
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.*; 
	
	import flash.external.ExternalInterface;

	import sfapi.core.Tools;
	

	public class RightClick extends Sprite
	{
		
		static public function handleRightClick(event:MouseEvent):void
		{
		
			event.stopImmediatePropagation();
			var objectType:String = Tools.getOjectType(event.currentTarget);
			
			if (objectType.indexOf("Text") > -1) {
				objectType = "textbox";
			} else if (objectType.indexOf("DataGrid") > -1) {
				objectType = "datagrid";
			} else if (objectType.indexOf("Date") > -1) {
				objectType = "date";
			} else if (objectType.indexOf("CheckBox") > -1) {
				objectType = "checkbox";
			} else if (objectType.indexOf("RadioButton") > -1) {
				objectType = "radiobutton";
			} else if (objectType.indexOf("Button") > -1) {
				objectType = "button";
			} else if (objectType.indexOf("Stepper") > -1) {
				objectType = "stepper";
			} else if (objectType.indexOf("Select") > -1) {
				objectType = "select";
			} else if (objectType.indexOf("Combo") > -1) {
				objectType = "combobox";
			}
			
			sendJSEvent("flexRightClickInvoked", event.currentTarget.name, objectType);	
			
		}
		
		/**
		 * Sends an event to JavaScript that contains information about a Flex event.
		 * eventType - the type of Flex event being propagated
		 * elementId - the id of the Flex element that got the event
		 * value - the value of the event
		 */
		static private function sendJSEvent(eventType:String, elementId:String, value:String):void 
		{
			if (value == null) {
				value = "";
			}
			
			if (ExternalInterface.available) {
				
				//Make a JavaScript call to send the event
				ExternalInterface.call("eval", "var evt = document.createEvent('MutationEvents');" +
					"evt.initMutationEvent('" + eventType + "', true, true, document.createTextNode(''),'" + 
					elementId + "','" + value + "', 'value', MutationEvent.MODIFICATION);" + 
					"document.dispatchEvent(evt);");				
			}
		}
	}
}
