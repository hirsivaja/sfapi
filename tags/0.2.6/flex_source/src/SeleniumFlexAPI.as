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
	import flash.system.Security;
	import mx.events.FlexEvent;
	import sfapi.commands.Commands;
	import sfapi.core.AppTreeParser;
	
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
	}
}