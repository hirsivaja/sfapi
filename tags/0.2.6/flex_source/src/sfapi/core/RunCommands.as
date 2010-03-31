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
 *  The Base for RunCommands is from Flexmonkey
 *  http://flexmonkey.googlecode.com/svn/trunk/FlexMonkey/src/com/gorillalogic/flexmonkey/FlexMonkey.mxml
 *
 */
package sfapi.core
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class RunCommands
	{
		private var TimeOut:Number; 
		private var Drag:Object;
		
		public function RunCommands(drag:Object, timeout:Number=500)
		{
			Drag = drag;	
			TimeOut = timeout;
		}
		
		/**
		 * Runs a series of commands, waiting between commands  
		 * @param  cmds  And array of commands to dispatch
		 */
		public function runDragCommands(cmds:Array, validator:Function=null):void
		{
			var runTimer:Timer = new Timer(TimeOut, 1);
			var nextCmdIndex:int = 0;

			runTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
			{
				runTimer.delay = TimeOut;
				if (nextCmdIndex == cmds.length)
				{
					return;
				}

				var cmd:MouseEvent = cmds[nextCmdIndex];
				try
				{
					if (runCommand(Drag, cmd))
					{
						nextCmdIndex++;
					}
				}
				catch (error:Error)
				{
					trace(error.message);
					nextCmdIndex++
				}
				runTimer.start();
			});
			runTimer.start();
		}
		
		/**
		 * Dispatches a single event  
		 * @param  drag  The drag manager proxy object
		 * @param  evt  The MouseEvent to dipatch
		 */
		protected function runCommand(drag:Object, evt:MouseEvent):Boolean
		{
			drag.dispatchEvent(evt);
			return true;
		}
	}
}
