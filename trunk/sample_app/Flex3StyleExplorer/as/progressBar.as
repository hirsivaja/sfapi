include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssborderColor:String = "";
public var cssbarColor:String = "";
public var csstrackColors:String = "";
public var csscolor:String = "";
public var csspaddingLeft:String = "";
public var csspaddingRight:String = "";
public var csstextIndent:String = "";
public var csstrackHeight:String = "";
public var cssverticalGap:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";

public var progressBarStyles:Array = [
	"borderColor", "barColor", "trackColors", "color", "paddingLeft", "paddingRight", "textIndent", "letterSpacing",
	"trackHeight", "verticalGap", "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration"
];


public function setProgressBar():void {
	myprogressBar.setProgress(30,100);
	myprogressBar.label= "Current Progress: 30%";
}

[Bindable]
public var swatches:Array;
