include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssdropShadowEnabled:String = "";
public var cssshadowDistance:String = "";
public var cssshadowDirection:String = "";
public var cssborderStyle:String = "";
public var cssborderThickness:String = "";
public var cssbackgroundColor:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String = "";
public var cssbackgroundAlpha:String = "";
public var cssborderColor:String = "";
public var cssdropShadowColor:String = "";


public var applicationControlBarStyles:Array = [ 
	"borderStyle", "highlightAlphas", "fillAlphas", "fillColors", "borderThickness", "borderColor",
	"backgroundColor", "backgroundAlpha", "cornerRadius", "dropShadowEnabled", "shadowDistance", "shadowDirection", "dropShadowColor"
];


[Bindable]
public var swatches:Array;