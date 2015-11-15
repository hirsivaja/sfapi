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
package 
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.InteractiveObject;
	
	import mx.events.FlexEvent;

	import flash.system.Security;
	import flash.external.ExternalInterface;
	
	import sfapi.commands.Commands;
	import sfapi.core.AppTreeParser;
	
	import mx.controls.Alert;
	
	[Mixin]
	public class SeleniumFlexAPI extends Sprite
	{
		private static var seleniumFlexAPI:SeleniumFlexAPI;
		public static var sysRoot:Object;
		public var appTreeParser:AppTreeParser;
		private var commands:Commands;
		
		public function SeleniumFlexAPI(app:Object)
		{
	       	super();
			app.addEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
	    }
		
	    /**
	     * Initialisation function 
	     */
	    public static function init(app:Object):void
	    {
	    	if(!seleniumFlexAPI)
	    	{
		    	sysRoot = app;
		    	seleniumFlexAPI = new SeleniumFlexAPI(app);
	    	}
		}
		
		/**
		 * Executes on creation completion of the application  
		 */
		private function applicationCompleteHandler(event:FlexEvent):void
		{
			sysRoot.removeEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
			appTreeParser = new AppTreeParser();
			appTreeParser.thisApp = sysRoot.getChildAt(0);
			seleniumFlexAPI = this;						
			appTreeParser.setTooltipsToID();
			appTreeParser.thisApp.addEventListener(KeyboardEvent.KEY_UP, refreshToolTips);
			commands = new Commands(appTreeParser);
			
			sysRoot.addEventListener(MouseEvent.CLICK, RecordingEventHandler.handleMouseClicked);
			appTreeParser.thisApp.addEventListener(KeyboardEvent.KEY_UP, refreshToolTips);			
			appTreeParser.thisApp.addEventListener(MouseEvent.MOUSE_MOVE, updateMousePosition);
			commands = new Commands(appTreeParser);
			
			/** This line injects JavaScript into the container that will insert
			 * a <SPAN> element with the id isSWFReady. The
			 * waitForElementPresent Selenium test we insert will pause flex
			 * tests until it crops up, preventing our race condition from
			 * ticket #21 in DrProject.
			 */
			ExternalInterface.call("function () { var bob = " +
				"document.createElement('span'); bob.id = 'isSWFReady';" +
				"document.getElementsByTagName('html')[0].appendChild(bob);" +
				"}");
				
			appTreeParser.curMouseX = 0;
			appTreeParser.curMouseY = 0;	
			initContextMenu();		
		}
		
		private function updateMousePosition(event:MouseEvent):void {
			appTreeParser.curMouseX = event.stageX;
			appTreeParser.curMouseY = event.stageY;
		}
		
		/**
		 * Refresh setting the tooltips when ctrl+l (lowercase L) is clicked
		 * @param  keyEvent  the key event
		 * @return  void
		 */
		private function refreshToolTips(keyEvent:KeyboardEvent):void
		{
			// keycode for r key is 82
			var rKeyCode:int = 82;
			appTreeParser.thisApp = sysRoot.application;
			if(keyEvent.ctrlKey && keyEvent.altKey && keyEvent.keyCode == rKeyCode)
			{
				appTreeParser.setTooltipsToID();
			}
		}
		
		/**
		 * Initialize the context menu for selecting commands 
		 */
		 private function initContextMenu():void {
			 //get the id/name of the flex app so we can keep track of it
			//on javascript side
			//NOTE appTreeParser.thisApp.name always adds a 0 to the end of the app name
			var appId:String = appTreeParser.thisApp.name;
			appId = appId.substring(0, appId.length-1);
			
			var myJavaScript:XML = <script>
        		<![CDATA[
        		    function(id){
            	
                		flexApp = id;
                		curMouseX = 0;
                		curMouseY = 0;
                		
                		contextMenuIsVisible = false;
                		var menu = document.createElement("div");
						menu.setAttribute('id', 'sel-flex-context-menu');
						menu.setAttribute('class', 'right-click-menu');
						menu.style.position = "absolute";
						menu.style.visibility = "hidden";
						document.body.appendChild(menu);
                		
                		doOnClick = function (event) {
                			if (event.button != 0 && event.target.id == flexApp) {
                				killEvents(event);
		    					curMouseX = event.clientX;
		    					curMouseY = event.clientY;
                			
                				contextMenuIsVisible = true;
                				var flashObj = document.getElementById(flexApp);
                				flashObj["doFlexRightClick"]("","");
		    				} else if (event.button == 0 && event.target.id == flexApp && contextMenuIsVisible) {
		    					killEvents(event);
		    					var rightMenu = document.getElementById("sel-flex-context-menu");
								rightMenu.style.visibility = "hidden";
								contextMenuIsVisible = false;
		    				}
                		}
                		
                		sendToSeIDE = function (event, objId, command) {
                			killEvents(event);
                			var rightMenu = document.getElementById("sel-flex-context-menu");
							rightMenu.style.visibility = "hidden";
							var evt = document.createEvent('MutationEvents');
							evt.initMutationEvent('flexSendCommandToSeIDE', true, true, document.createTextNode(''), objId, command , 'value', MutationEvent.MODIFICATION); 
							document.dispatchEvent(evt);
							contextMenuIsVisible = false;
						}
						
						killEvents = function(event) {
							if (event.stopPropagation) { event.stopPropagation(); }
							if (event.preventDefault) { event.preventDefault(); }
							if (event.preventCapture) { event.preventCapture(); }
		    				if (event.preventBubble) { event.preventBubble(); }	
						}
						
						document.getElementById(flexApp).wmode = "transparent";
                		document.addEventListener("mousedown", doOnClick, true);
                		
               	}
        		]]>
    		</script> 
			
			ExternalInterface.call(myJavaScript , appId);
		 
		 }
	}
}