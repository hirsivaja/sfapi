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
	import mx.containers.HBox;
	import mx.controls.Label;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import sfapi.core.AppTreeParser;
	
	public class NotifyCommands
	{
		
		private var appTreeParser:AppTreeParser;
		
		private var timer:Timer = null;
		private var label:Label = null;
		private var box:HBox = null;
		
		public function NotifyCommands(aptObj:AppTreeParser)
		{
			appTreeParser = aptObj;
		}
		
		public function doFlexNotify(msg:String, args:String=""):String
		{
			
			var w:int = appTreeParser.thisApp.width;
			var h:int = appTreeParser.thisApp.height;
			
			if (label == null){
				box = new HBox();
				
				label = new Label();
				
				box.setStyle("backgroundColor",0x0000ff);
				
				label.setStyle("fontSize", 24);
				label.setStyle("color", "0xFFFFFF");
				
				//box.x = w/2 - label.width/2;
				box.y = h - box.height-30;
				
				//box.setStyle("verticalAlign", "middle");
				box.setStyle("horizontalAlign", "center");

				box.setStyle("width", "100%");
				
				box.addChild(label);
				
				appTreeParser.thisApp.addChild(box);
						
			}
			
			label.text = msg;
			
			if (timer == null){
				timer = new Timer(6000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, clear);
				timer.start();
			}else{
				timer.delay = 3000;
			}
			
			return "true";
			
		}
		
		private function clear(evt:TimerEvent):void{
			if (label){
				appTreeParser.thisApp.removeChild(box);
				label = null;
				timer = null;
				box = null;
			}
		}
		
		
	}
}