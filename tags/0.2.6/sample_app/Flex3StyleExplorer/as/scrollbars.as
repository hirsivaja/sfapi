import mx.managers.PopUpManager;
include "globalFunctions.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssborderColor:String = "";
public var csshighlightAlphas:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var cssthemeColor:String  = "";
public var csstrackColors:String  = "";

public var scrollBarStyles:Array = [
	"cornerRadius", "borderColor", "highlightAlphas", "fillAlphas", "fillColors",
	"themeColor", "trackColors"
];


public function setValue(whichStyle:String, whatValue:Number, whatType:String):void {
	myscrollBar.setStyle(whichStyle, whatValue);
	myhScrollBar.setStyle(whichStyle, whatValue);
	setCSS(whichStyle, whatValue, whatType);
}


public function setArrayValue (whichStyle:String, whatValue:Array, whatType:String, whichItem:String):void {
	
	this['my' + whichItem].setStyle(whichStyle, whatValue);	
	myhScrollBar.setStyle(whichStyle, whatValue);
	
	if (whatType == 'color') {
		setArrayCSS(whichStyle, whatValue[0], whatValue[1], true, whichItem);
	} else {
		setArrayCSS(whichStyle, whatValue[0], whatValue[1], false, whichItem);
	}
}


public function setQuadArrayValue (whichStyle:String, whatValue:Array, whatType:String, whichItem:String):void {
	this['my' + whichItem].setStyle(whichStyle, whatValue);
	myhScrollBar.setStyle(whichStyle, whatValue);
	if (whatType == 'color') {
		setArrayFourCSS(whichStyle, whatValue[0], whatValue[1], whatValue[2], whatValue[3], true, whichItem);
	} else {
		setArrayFourCSS(whichStyle, whatValue[0], whatValue[1], whatValue[2], whatValue[3], false, whichItem);
	}
}

public function setArrayCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, isColor:Boolean, whichItem:String):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2); } 
	else { newValue =whatValue1 + ", " + whatValue2; }
	setCSS(whichStyle, 0, newValue);
}

public function setArrayFourCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, whatValue3:Number, whatValue4:Number, isColor:Boolean, whichItem:String):void {
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2) + ", " + rgbToHex(whatValue3) + ", " + rgbToHex(whatValue4); } 
	else { newValue =whatValue1 + ", " + whatValue2 + ", " + whatValue3 + ", " + whatValue4; }
	setCSS(whichStyle, 0, newValue);
}


public function setCSS(whichStyle:String, whatValue:Number, whatType:String):void {
	if (whatType == 'color') { 	this["css" + whichStyle] = "   " + whichStyle + ": " + rgbToHex(whatValue) + ";\n";	} 
	else if (whatType == 'number' ){ this["css" + whichStyle] = "   " + whichStyle + ": " + whatValue + ";\n"; } 
	else {	this["css" + whichStyle] = "   " + whichStyle + ": " + whatType + ";\n";}

	
	myCSS.text = 'VScrollBar { \n';
	for (var i:Number = 0; i < scrollBarStyles.length; i++) {
		myCSS.text += this['css' + scrollBarStyles[i]];
	}
	myCSS.text +=  '}\nHScrollBar { \n';
	for (i = 0; i < scrollBarStyles.length; i++) {
		myCSS.text += this['css' + scrollBarStyles[i]];
	}
	myCSS.text += '}';
}

public function restoreDefaults():void {
	
	
	for (var i:Number = 0; i < scrollBarStyles.length; i++) {
		if (this['css' + scrollBarStyles[i]] != '') {
			myscrollBar.clearStyle(scrollBarStyles[i]);
			myhScrollBar.clearStyle(scrollBarStyles[i]);
			this['my' + scrollBarStyles[i] ].restoreDefault();
			this['css' + scrollBarStyles[i] ] = "";	
		}
	}
	myCSS.text = ""; 
}

[Bindable]
public var swatches:Array;

