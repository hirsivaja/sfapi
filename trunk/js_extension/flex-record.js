/**                                                                                                    
 * This file holds events that can be sent from the Flex library. It then passes                       
 * them through to the Selenium record function which puts them into the test                          
 * suite.                                                                                              
 *                                                                                                     
 * In addition to Flex events that are being recorded, it also defines the                             
 * handler for waitForElementPresent so that the Flex applet can send a wait                           
 * command to avoid the race condition crash defined in ticket #21.                                    
 */

Recorder.addEventHandler('flexFocusHandler', 'flexFocus', function(event) {
	if ('flexFocus' == event.type) {
		// event.prevValue would contain the id of target and                                              
		// event.newValue would contain the value                                                          
		this.record("flexFocus", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

Recorder.addEventHandler('flexKeyboardHandler', 'flexKeyboard',
		function(event) {
			if ('flexKeyboard' == event.type) {
				// event.prevValue would contain the id of target and                                          
		// event.newValue would contain the value                                                          
		this.record("flexKeyboard", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/* Handles a flex type event* */
Recorder.addEventHandler('flexTextEventHandler', 'flexType', function(event) {
	if ('flexType' == event.type) {
		// event.prevValue would contain the id of target and                                              
		// event.newValue would contain the value                                                          
		this.record("flexType", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/* Handles a flex type append event* */
Recorder.addEventHandler('flexTextAppendEventHandler', 'flexTypeAppend',
		function(event) {
			if ('flexTypeAppend' == event.type) {
				// event.prevValue would contain the id of target and                                          
		// event.newValue would contain the value                                                          
		this.record("flexTypeAppend", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/*                                                                                                     
 * Handler for a drag and drop event within a Flex application - Mohammad                              
 */
Recorder.addEventHandler('dragAndDropHandler', 'flexDragTo', function(event) {

	if ('flexDragTo' == event.type) {

		// event.prevValue contains the id of target                                                       
		// event.newValue would contain the drag source                                                    
		this.record("flexDragTo", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/*
 * Handler for combo box selection events within a Flex application - Ben
 */
Recorder.addEventHandler('flexSelectComboByLabelHandler', 'flexSelectComboByLabel', function(event) {
	if ('flexSelectComboByLabel' == event.type) {
		this.record("flexSelectComboByLabel", event.prevValue, event.newValue);
	}
}, {
	capture: true
});

/*                                                                                                     
 * Handler for selecting a row in a grid box element.                                                  
 */
Recorder.addEventHandler('flexSelectIndexHandler', 'flexSelectIndex', function(event) {

	if ('flexSelectIndex' == event.type) {

		// event.prevValue contains the id of target                                                       
		// event.newValue would contain the drag source                                                    
		this.record("flexSelectIndex", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/*                                                                                                     
 * Handler for click events within a Flex application                                                  
 */
Recorder.addEventHandler('flexClickHandler', 'flexClick', function(event) {

	if ('flexClick' == event.type) {

		// event.prevValue would contain the id of target and                                              
		// event.newValue would contain the value                                                          
		this.record("flexClick", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/*                                                                                                     
 * Handler for date events within a Flex application - Alfred                                          
 */
Recorder.addEventHandler('flexDateHandler', 'flexDate', function(event) {

	if ('flexDate' == event.type) {

		// event.prevValue contains the id of target and                                                   
		// TODO: figure out why prevValue contains the id of the target. Also                              
		// see if there is better                                                                          
		// variable to store the id of the targer.                                                         
		// event.newValue would contain the value                                                          
		this.record("flexDate", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/*                                                                                                     
 * Handler for alert response                                                                          
 */
Recorder.addEventHandler('flexAlertResponseHandler', 'flexAlertResponse', function(event) {
	if ('flexAlertResponse' == event.type) {

		// event.prevValue would contain the id of target and                                          
		// event.newValue would contain the value                                                          
		this.record("flexAlertResponse", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/**
 * Handler that allows us to inject the waitForElementPresent to wait for flex
 */
Recorder.addEventHandler('waitForElementPresentHandler', 'waitForElementPresent', function(event) {
	if ('waitForElementPresent' == event.type) {

		// event.prevValue would contain the id of target and
		// event.newValue would contain the value
		this.record("waitForElementPresent", event.prevValue, event.newValue);
	}
}, {
	capture : true
});

/*                                                                                                     
 * These handlers aid in showing the context menu                                                      
 */

/*                                                                                                     
 * Called when an item on the menu is clicked                                                          
 */
Recorder.addEventHandler('flexSendCommandToSeIDEHandler', 'flexSendCommandToSeIDE', function(event) {
	if (event.type == "flexSendCommandToSeIDE") {
		// newValue is command                                                                         
		// prevValue is object id                                                                          
		this.record(event.newValue, event.prevValue, "");
	}

}, {
	capture : true
});

/* Flex calls this function to send data to SeIDE when user right clicks on app */
Recorder.addEventHandler('flexRightClickInvokedHandler', 'flexRightClickInvoked',
				function(event) {

					var menuItems = "";

					var data = event.newValue.split(';');
					var objId = event.prevValue;
					var type = data[0];

					var style = "font-family:Arial;padding:1px;background-color:#FCFCFC;border:1px solid black;";
					var mouseoverout = " onmouseout=\"event.target.style.backgroundColor=\'#FCFCFC\'\"" +
							" onmouseover=\"event.target.style.backgroundColor=\'#FFFFCC\'\"";

					if (type == "checkbox") {
						menuItems += "<div style=\"" +
								style +
								"\" onmousedown=\"event.preventBubble;sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'assertFlexCheckBoxChecked\')\"" +
								mouseoverout +
								">assertFlexCheckBoxChecked</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"event.preventBubble;sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'verifyFlexCheckBoxChecked\')\"" +
								mouseoverout +
								">verifyFlexCheckBoxChecked</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"event.preventBubble;sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'waitforFlexCheckBoxChecked\')\" " +
								mouseoverout +
								">waitforFlexCheckBoxChecked</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"event.preventBubble;sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexCheckBoxChecked\')\" " +
								mouseoverout +
								">storeFlexCheckBoxChecked</div>";
					} else if (type == "combobox") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexNumSelectedItems\')\" " +
								mouseoverout +
								">assertFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexComboContainsLabel\')\" " +
								mouseoverout +
								">assertFlexComboContainsLabel</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexNumSelectedItems\')\" " +
								mouseoverout +
								">verifyFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexComboContainsLabel\')\" " +
								mouseoverout +
								">verifyFlexComboContainsLabel</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexNumSelectedItems\')\" " +
								mouseoverout +
								">waitforFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexComboContainsLabel\')\" " +
								mouseoverout +
								">waitforFlexComboContainsLabel</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexNumSelectedItems\')\" " +
								mouseoverout +
								">storeFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexComboContainsLabel\')\" " +
								mouseoverout +
								">storeFlexComboContainsLabel</div>";
					} else if (type == "datagrid") {
						menuItems += "<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'assertFlexDataGridCell\')\" " +
								mouseoverout +
								">assertFlexDataGridCell</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'assertFlexDataGridFieldValueForGridRow\')\" " +
								mouseoverout +
								">assertFlexDataGridFieldValueForGridRow</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'assertFlexDataGridRowCount\')\" " +
								mouseoverout +
								">assertFlexDataGridRowCount</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'assertFlexDataGridRowIndexForFieldValue\')\" " +
								mouseoverout +
								">assertFlexDataGridRowIndexForFieldValue</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'assertFlexDataGridUIComponentLabel\')\" " +
								mouseoverout +
								">assertFlexDataGridUIComponentLabel</div>" +

								// Spliter Code                                                                        

								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'verifyFlexDataGridCell\')\" " +
								mouseoverout +
								">verifyFlexDataGridCell</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'verifyFlexDataGridFieldValueForGridRow\')\" " +
								mouseoverout +
								">verifyFlexDataGridFieldValueForGridRow</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'verifyFlexDataGridRowCount\')\" " +
								mouseoverout +
								">verifyFlexDataGridRowCount</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'verifyFlexDataGridRowIndexForFieldValue\')\" " +
								mouseoverout +
								">verifyFlexDataGridRowIndexForFieldValue</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'verifyFlexDataGridUIComponentLabel\')\" " +
								mouseoverout +
								">verifyFlexDataGridUIComponentLabel</div>" +

								// Spliter Code                                                                        

								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'waitforFlexDataGridCell\')\" " +
								mouseoverout +
								">waitforFlexDataGridCell</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'waitforFlexDataGridFieldValueForGridRow\')\" " +
								mouseoverout +
								">waitforFlexDataGridFieldValueForGridRow</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'waitforFlexDataGridRowCount\')\" " +
								mouseoverout +
								">waitforFlexDataGridRowCount</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'waitforFlexDataGridRowIndexForFieldValue\')\" " +
								mouseoverout +
								">waitforFlexDataGridRowIndexForFieldValue</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'waitforFlexDataGridUIComponentLabel\')\" " +
								mouseoverout +
								">waitforFlexDataGridUIComponentLabel</div>" +

								// Spliter Code                                                                        

								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'storeFlexDataGridCell\')\" " +
								mouseoverout +
								">storeFlexDataGridCell</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'storeFlexDataGridFieldValueForGridRow\')\" " +
								mouseoverout +
								">storeFlexDataGridFieldValueForGridRow</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'storeFlexDataGridRowCount\')\" " +
								mouseoverout +
								">storeFlexDataGridRowCount</div>" +
								"<div style=\"" +
								style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId +
								"\'," +
								"\'storeFlexDataGridRowIndexForFieldValue\')\" " +
								mouseoverout +
								">storeFlexDataGridRowIndexForFieldValue</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexDataGridUIComponentLabel\')\" " +
								mouseoverout +
								">storeFlexDataGridUIComponentLabel</div>";

					} else if (type == "date") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexDate\')\" " +
								mouseoverout + ">assertFlexDate</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexDate\')\" " +
								mouseoverout + ">verifyFlexDate</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexDate\')\" " +
								mouseoverout + ">waitforFlexDate</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexDate\')\" " +
								mouseoverout + ">storeFlexDate</div>";
					} else if (type == "number") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexNumeric\')\" " +
								mouseoverout + ">assertFlexNumeric</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexNumeric\')\" " +
								mouseoverout + ">verifyFlexNumeric</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexNumeric\')\" " +
								mouseoverout + ">waitforFlexNumeric</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexNumeric\')\" " +
								mouseoverout + ">storeFlexNumeric</div>";
					} else if (type == "radiobutton") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexRadioButton\')\" " +
								mouseoverout + ">assertFlexRadioButton</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexRadioButton\')\" " +
								mouseoverout + ">verifyFlexRadioButton</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexRadioButton\')\" " +
								mouseoverout +
								">waitforFlexRadioButton</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexRadioButton\')\" " + mouseoverout +
								">storeFlexRadioButton</div>";
					} // do this for each type defined in ticket #30...                                          

					else if (type == "select") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexNumSelectedItems\')\" " +
								mouseoverout +
								">assertFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexSelectedItemAtIndex\')\" " +
								mouseoverout +
								">assertFlexSelectedItemAtIndex</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexSelection\')\" " +
								mouseoverout + ">assertFlexSelection</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexSelectionIndex\')\" " +
								mouseoverout +
								">assertFlexSelectionIndex</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexNumSelectedItems\')\" " +
								mouseoverout +
								">verifyFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexSelectedItemAtIndex\')\" " +
								mouseoverout +
								">verifyFlexSelectedItemAtIndex</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexSelection\')\" " +
								mouseoverout + ">verifyFlexSelection</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexSelectionIndex\')\" " +
								mouseoverout +
								">verifyFlexSelectionIndex</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexNumSelectedItems\')\" " +
								mouseoverout +
								">waitforFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexSelectedItemAtIndex\')\" " +
								mouseoverout +
								">waitforFlexSelectedItemAtIndex</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexSelection\')\" " + mouseoverout +
								">waitforFlexSelection</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexSelectionIndex\')\" " +
								mouseoverout +
								">waitforFlexSelectionIndex</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexNumSelectedItems\')\" " +
								mouseoverout +
								">storeFlexNumSelectedItems</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexSelectedItemAtIndex\')\" " +
								mouseoverout +
								">storeFlexSelectedItemAtIndex</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexSelection\')\" " +
								mouseoverout + ">storeFlexSelection</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexSelectionIndex\')\" " +
								mouseoverout +
								">storeFlexSelectionIndex</div>";

					}

					else if (type == "stepper") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexFlexStepper\')\" " +
								mouseoverout + ">assertFlexFlexStepper</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexFlexStepper\')\" " +
								mouseoverout + ">verifyFlexFlexStepper</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexFlexStepper\')\" " +
								mouseoverout +
								">waitforFlexFlexStepper</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexFlexStepper\')\" " + mouseoverout +
								">storeFlexFlexStepper</div>";
					}

					else if (type == "textbox") {
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexText\')\" " +
								mouseoverout + ">assertFlexText</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexTextPresent\')\" " +
								mouseoverout + ">assertFlexTextPresent</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexText\')\" " +
								mouseoverout + ">verifyFlexText</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexTextPresent\')\" " +
								mouseoverout + ">verifyFlexTextPresent</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexText\')\" " +
								mouseoverout + ">waitforFlexText</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexTextPresent\')\" " +
								mouseoverout +
								">waitforFlexTextPresent</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexText\')\" " +
								mouseoverout + ">storeFlexText</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexTextPresent\')\" " + mouseoverout +
								">storeFlexTextPresent</div>";
					}

					else { // for all other objects                                                              
						menuItems += "<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexExists\')\" " +
								mouseoverout + ">assertFlexExists</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'assertFlexGlobalPosition\')\" " +
								mouseoverout +
								">assertFlexGlobalPosition</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexVisible\')\" " +
								mouseoverout + ">assertFlexVisible</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexObject\')\" " +
								mouseoverout + ">assertFlexObject</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'assertFlexProperty\')\" " +
								mouseoverout + ">assertFlexProperty</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexExists\')\" " +
								mouseoverout + ">verifyFlexExists</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'verifyFlexGlobalPosition\')\" " +
								mouseoverout +
								">verifyFlexGlobalPosition</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexVisible\')\" " +
								mouseoverout + ">verifyFlexVisible</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexObject\')\" " +
								mouseoverout + ">verifyFlexObject</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'verifyFlexProperty\')\" " +
								mouseoverout + ">verifyFlexProperty</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexExists\')\" " +
								mouseoverout + ">waitforFlexExists</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'waitforFlexGlobalPosition\')\" " +
								mouseoverout +
								">waitforFlexGlobalPosition</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexVisible\')\" " +
								mouseoverout + ">waitforFlexVisible</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexObject\')\" " +
								mouseoverout + ">waitforFlexObject</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'waitforFlexProperty\')\" " +
								mouseoverout + ">waitforFlexProperty</div>" +

								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexExists\')\" " +
								mouseoverout + ">storeFlexExists</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," +
								"\'storeFlexGlobalPosition\')\" " +
								mouseoverout +
								">storeFlexGlobalPosition</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexVisible\')\" " +
								mouseoverout + ">storeFlexVisible</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexObject\')\" " +
								mouseoverout + ">storeFlexObject</div>" +
								"<div style=\"" + style +
								"\" onmousedown=\"sendToSeIDE(event, \'" +
								objId + "\'," + "\'storeFlexProperty\')\" " +
								mouseoverout + ">storeFlexProperty</div>";
					}

					var win = this.getWrappedWindow();
					var menu = win.document.getElementById("sel-flex-context-menu");
					menu.style.visibility = "visible";
					menu.style.border = "1px solid black";
					menu.style.left = win.curMouseX;
					menu.style.top = win.curMouseY;
					menu.innerHTML = menuItems;

					sendToSeIDE(event, objId, "storeFlexProperty");
				}, {
					capture : true
				});