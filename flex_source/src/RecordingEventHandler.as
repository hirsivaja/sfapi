package
{
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.controls.DateField;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	
	import mx.events.DateChooserEvent;
	import mx.events.ListEvent;
	import flash.events.FocusEvent;

	/**
	 * This class is responsible for propagating Flex events to JavaScript to be recorded.
	 *
	 * In general, the functions are stubs that take an event and fire it off via sendJSEvent,
	 * which is defined at the bottom of this file.
	 *
	 * sendJSEvent takes as its first parameter a string representing the type of event,
	 * following the naming convention that we have adopted from FlexMonkey.
	 * 
	 * The second parameter is a string representing the ID of the DOM object in
     * the Flex application that was clicked.
	 *
	 * The last parameter is another string representing the object's value.
	 *
	 * Note that they're all strings so that we can represent them in a HTML table
	 * to record the cases.
	 */
	public class RecordingEventHandler
	{
		/**
		 * Returns id of the target of the given event, if id is null
		 * returns its unique label
		 * e - the event to extract element id from
		 */
		static public function getId(e:Event):String {
			var id:String = e.target.id;
			// check if target's id is null
			// if so use target's name instead
			// TODO: check if this works with other browser bots
			// Works with firefox atm
	 		if (id == null){
	 			// TODO: decide which function to use. valueOf() or toString()
	 			// var objectName:String = (e.target.valueOf()).split(".");
	 			var objectName:Array = (e.target.toString()).split(".");
	 			// use the very last element of the target's string representation
	 			// this last token is equivalent to target's name(object name)
	 			id = objectName[objectName.length - 1];
	 		}
	 		return id;
		}
		
		/**
		 * Returns true if the clicked target is a child of alert box
		 * e - the event to extract the targets parent
		 */
		static public function belongsToAlert(e:Event):Boolean {
			var retVal:Boolean = false;
			
			if (e.target.parent != null && e.target.parent.parent != null) {
				retVal = e.target.parent.parent is Alert;
			}
			return retVal;
		}
		
		
		/**
		 * Handles drag and drop object event.
		 * e - the Flex date change event
		 */
		static public function handleDropObject(e:mx.events.DragEvent):void
		{
			// id: id of the dom object being dragged(drag initiator)
			// command: flexDragTo
			// value: the coordinates of where the drag initiator was dropped
			
			//e.dragInitiator is of type IUIComponent but must be casted
			//as an Object in order to get the id. It is the object that was
			//clicked to initiate the drag.
			var dragInitiator:Object = e.dragInitiator as Object;
			var id:String = dragInitiator.id as String;

			// check if target's id is null
			// if so use target's name instead
			if (id == null){
				id = dragInitiator.name;
			}

			var target:Object = e.target as Object;

			//the coordinates must be of the form "x,y"
			var desPosArray:Array = [String(target.stage.mouseX), String(target.stage.mouseY)];
			var destPos:String = String(desPosArray);

			e.stopImmediatePropagation();
			sendJSEvent("flexDragTo", id, destPos);
		}


		/**
		 * Handles date change event.
		 * e - the Flex date change event
		 */
		static public function handleDateChange(e:mx.events.CalendarLayoutChangeEvent):void
		{
			// id: id of the dom object(DateField in this case)
			// command: flexDate
			// value: a string of the new date in the format which user specifies.
			// safe-check just to make sure that given event is indeed datechange event
			if (e.type == mx.events.CalendarLayoutChangeEvent.CHANGE){
				var id:String = e.target.id;
				// check if target's id is null
				// if so use target's name instead
				// TODO: check if this works with other browser bots
				// Works with firefox atm
			 	if (id == null){
			 		// TODO: decide which function to use. valueOf() or toString()
			 		// var objectName:String = (e.target.valueOf()).split(".");
			 		var objectName:Array = (e.target.toString()).split(".");
			 		// use the very last element of the target's string representation
			 		// this last token is equivalent to target's name(object name)
			 		id = objectName[objectName.length - 1];
			 	}
			 	e.stopImmediatePropagation();
				sendJSEvent("flexDate", 
							id, 
							DateField.dateToString(e.target.selectedDate, e.target.formatString));
			}

		}
		
		/**
		 * Handles combo box or grid box selection event.
		 * e - the Flex combo/grid box selection change event
		 */
		static public function handleListSelection(e:mx.events.ListEvent):void
		{
			// id: id of the combo box
			// command: flexCombo
			// value: the string value of the combo selection
			e.stopImmediatePropagation();
			if (e.target is mx.controls.ComboBox) {
				sendJSEvent("flexSelectComboByLabel", getId(e), e.target.selectedLabel);
			}
			if (e.target is mx.controls.DataGrid) {
				sendJSEvent("flexSelectIndex", getId(e), "" + e.target.selectedIndex);
			}			
		}

		
		/**
		 * Handles mouse click on a tab object event.
		 * e - the Flex Item clicked event
		 */
		static public function handleTabClicked(e:mx.events.ItemClickEvent):void
		{
			
			// id:  e.target.id
			// command: flexClick
			// value: none
			
			//selected tabs index
			var index:int = e.index;

			//the selected tab object
			var obj:Object = e.target.getChildAt(index) as Object;
			var id:String = obj.id;

			// check if target's id is null
			// if so use target's name instead
			if (id == null){
				id = obj.name;
			}

			e.stopImmediatePropagation();
			sendJSEvent("flexClick", id, "");
		}

		
		/**
		 * Handles mouse clicked event.
		 * e - the Flex mouse clicked event
		 */
		static public function handleMouseClicked(e:MouseEvent):void
		{
			if (belongsToAlert(e)) {
				// command: flexAlertResponse
				// value: none
				e.stopImmediatePropagation();
				sendJSEvent("flexAlertResponse", getId(e), "");
			} else {
				// command: flexClick
				// value: none
				e.stopImmediatePropagation();
				sendJSEvent("flexClick", getId(e), "");				
			}
		}
		
		/**
		 * Handles mouse right clicked event.
		 * e - the Flex event
		 */
		 static public function handleMouseRightClick(e:MouseEvent):void
		{
			// id:  e.target.id
			// command: flexClick
			// value: none
			e.stopImmediatePropagation();
			sendJSEvent("flexClick", e.target.id, "");
		}
		 
		
		/**Handles a simple keyboard event**/
		static public function handleKeyboardEvent(e:KeyboardEvent):void
		{
			e.stopImmediatePropagation();
			sendJSEvent("flexKeyboard", e.target.id, "");
		}
		
		/**Handles a simple text event**/
		static public function handleTextEvent(e:TextEvent):void
		{   
			
			e.stopImmediatePropagation();
			
			if(e.target.text == "") {
				sendJSEvent("flexType", e.target.id, e.text);
			} else {
				sendJSEvent("flexTypeAppend", e.target.id, e.text);
			}
		}
		
		static private var thisIsFirstRecordedFlexEvent:Boolean = true;
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
			
				if (thisIsFirstRecordedFlexEvent) {
					thisIsFirstRecordedFlexEvent = false;
					callEItoSendJSEvent("waitForElementPresent", "//*[@id=\"isSWFReady\"]", "");
				}
				
				var id:String = elementId;
				if (ExternalInterface.objectID != null) { //add Flex application id if available
					id = ExternalInterface.objectID + "." + id;
				}
				
				callEItoSendJSEvent(eventType, id, value);
			}		
		}

		/**
		 * Makes ExternalInterface call to send a JavaScript event that stores
		 * a given Flex eventType, id and value.
		 * Precondition: ExternalInterface must be available 
		 */
		static private function callEItoSendJSEvent(eventType:String, id:String, value:String):void 
		{
			//Make a JavaScript call to send the event
			ExternalInterface.call("eval", "var evt = document.createEvent('MutationEvents');" +
				"evt.initMutationEvent('" + eventType + "', true, true, document.createTextNode(''),'" + 
				id + "','" + value + "', 'value', MutationEvent.MODIFICATION);" + 
				"document.dispatchEvent(evt);");
		}
	}
}