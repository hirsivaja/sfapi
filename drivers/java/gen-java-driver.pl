# This script generates the driver java extension class for selenium flex
# The script parses the action script file Commands.js, to collect the commands available for the API
# and generates the java code
$scriptOut = "
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

package au.com.transurban.retailweb.regression;

import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.HttpCommandProcessor;
import com.thoughtworks.selenium.SeleniumException;
 

public class DefaultSeleniumFlex extends DefaultSelenium {
	
	public DefaultSeleniumFlex(HttpCommandProcessor proc) {
		super(proc);
	}
	
	protected void handleException(SeleniumException e, String command, String target, String args) {
		System.out.println(e.getMessage());
		System.out.println(\"Failed command : \" + command + \"(\" + target + \", \" + args +\")\");
	}
	
	protected String executeCommand(String command, String target, String args) throws Exception {
		String retval = \"\";
		try {
			retval = this.commandProcessor.doCommand(command, new String[] { target, args });
		} catch (SeleniumException e) {
			handleException(e, command, target, args);
			throw e;
		}
		return retval;
	}
";

# get list of commands from Commands.js
$commandsFile = "../../SeleniumFlexAPI/src/net/sourceforge/seleniumflexapi/commands/Commands.as";

open(FILE, $commandsFile) || die("Could not open file!");
@commands;
while(<FILE>) {
	if($_ =~ /addCallback\("(\w+)/) {
		$command = $1;
		if($command =~ /^do/) {
			$command =~ s/doFlex/flex/g;
			$scriptOut .= "
	public void $command(String target, String args) throws Exception { executeCommand(\"$command\", target, args); }
	public void $command(String target) throws Exception { executeCommand(\"$command\", target, \"\"); }";
		} else {
			# add a get command
			$scriptOut .= "
	public String $command(String target, String args) throws Exception { return executeCommand(\"$command\", target, args).replace(\"OK,\", \"\"); }
	public String $command(String target) throws Exception { return executeCommand(\"$command\", target, , \"\").replace(\"OK,\", \"\"); }";
		}
	}
}

$scriptOut .= "
}
";

close(FILE);

open FILE, ">DefaultSeleniumFlex.java_GENERATED" or die $!;
print FILE $scriptOut;
close FILE;


