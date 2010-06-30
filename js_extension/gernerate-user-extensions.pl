# This script is presently depricated due to replacement of user-extensions.js
# with flex-playback.js. It needs a slight rewrite.

# This script generates the SeleniumFlexAPI file user-extensions.js
# The script parses the action script file Commands.js, to collect the commands available for the API
# and generates the javascript interfaces method
$scriptOut = "/*	
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
 
/**
 * The following is the ID for the Flex object on the html page.
 * Should be different depending on the application under test.
 * Use the command flexSetFlexObjID to set the command during runtime
 */

Selenium.prototype.getFlexObject =  function(){
	var obj = (this.browserbot.locateElementByXPath('//embed', this.browserbot.getDocument())) ? this.browserbot.locateElementByXPath('//embed', this.browserbot.getDocument()) : this.browserbot.locateElementByXPath('//object', this.browserbot.getDocument());
	return obj.id;
}

Selenium.prototype.flashObjectLocator = null;

Selenium.prototype.callFlexMethod = function (method, id, args) {
	
	if (this.flashObjectLocator === null){
		this.flashObjectLocator = this.getFlexObject();
	}
	
	// the object that contains the exposed Flex functions
	var funcObj = null;
	// get the flash object
	var flashObj = selenium.browserbot.findElement(this.flashObjectLocator);
	
	if (flashObj.wrappedJSObject) {
		flashObj = flashObj.wrappedJSObject;
	}
	
	// find object holding functions
	if(typeof(flashObj[method]) == 'function')
		// for IE (will be the flash object itself)
		funcObj = flashObj;
	else {
		// Firefox (will be a child of the flash object)
		for(var i = 0; i < flashObj.childNodes.length; i++) {
			var tmpFuncObj = flashObj.childNodes[i];
			if(typeof(tmpFuncObj) == 'function') {
				funcObj = tmpFuncObj;
				break;
			}
		}
	}
	
	// throw a error to Selenium if the exposed function could not be found
	if(funcObj == null)
		throw new SeleniumError('Function ' + method + ' not found on the External Interface for the flash object ' + this.flashObjectLocator);

	return funcObj[method](id, args);
}

Selenium.prototype.doFlexSetFlexObjID = function(flasObjID) {
    if(null == flasObjID) throw new SeleniumError(flasObjID);
    this.flashObjectLocator = flasObjID;
};

Selenium.prototype.doAssertFlexAlertTextPresent = function(searchStr) {
	var retval = this.callFlexMethod('getFlexAlertTextPresent', searchStr);
	if(retval != 'true') throw new SeleniumError(retval);
};

Selenium.prototype.doAssertFlexAlertTextNotPresent = function(searchStr) {
	var retval = this.callFlexMethod('getFlexAlertTextPresent', searchStr);
	if(retval == 'true') throw new SeleniumError('The string ' + searchStr + ' was found');
};

Selenium.prototype.doVerifyFlexAlertTextPresent = function(searchStr) {
	var retval = this.callFlexMethod('getFlexAlertTextPresent', searchStr);
	if(retval != 'true') LOG.error(retval);
};

Selenium.prototype.doVerifyFlexAlertTextNotPresent = function(searchStr) {
	var retval = this.callFlexMethod('getFlexAlertTextPresent', searchStr);
	if(retval == 'true') LOG.error('The string ' + searchStr + ' was found');
};

Selenium.prototype.getFlexASProperty = function(idProperty) {
	var targets = idProperty.split('.');
	return this.callFlexMethod('getFlexASProperty', targets[0], targets[1]);
};

Selenium.prototype.getFlexProperty = function(idProperty) {
	var ID = idProperty.split('.')[0];
	var property = idProperty.substring(idProperty.indexOf('.') + 1);
	return this.callFlexMethod('getFlexProperty', ID, property);
};
";

# get list of commands from Commands.js
$commandsFile = "../flex_source/src/sfapi/commands/Commands.as";

open(FILE, $commandsFile) || die("Could not open file!");
@commands;
while(<FILE>) {
	if($_ =~ /addCallback\("(\w+)/) {
		$command = $1;
		# these are the exceptional commands that require javascript that breaks the norm
		# the javascript methods for these commands are added in the default script above
		if($command !~ /doAssertFlexAlertTextPresent/ and 
			$command !~ /doAssertFlexAlertTextNotPresent/ and 
			$command !~ /doVerifyFlexAlertTextPresent/ and 
			$command !~ /doVerifyFlexAlertTextNotPresent/ and 
			$command !~ /getFlexASProperty/ and	
			$command !~ /getFlexProperty/
		) {
			if($command =~ /^do/) {
				$scriptOut .= "
Selenium.prototype.$command = function(id, args) {
	var retval = this.callFlexMethod('$command', id, args);
	if(retval != 'true') throw new SeleniumError(retval);
};
";
			} elsif ($command =~ /^get/) {
				# add a get command
				$scriptOut .= "
Selenium.prototype.$command = function(id) {
	return this.callFlexMethod('$command', id);
};
";
			}
		}
	}
}
close(FILE);

open FILE, ">user-extensions.js_GENERATED" or die $!;
print FILE $scriptOut;
close FILE;


