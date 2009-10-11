include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssbackgroundAlpha:String = "";
public var cssbackgroundColor:String = "";
public var csscolor:String = "";
public var cssborderStyle:String = "";
public var cssborderColor:String = "";
public var cssborderThickness:String = "";
public var csscornerRadius:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String = "";
public var cssthemeColor:String = "";
public var csstextIndent:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";
public var cssiconColor:String = "";

public var numericStepperStyles:Array = [
	"borderStyle", "borderColor", "borderThickness", "backgroundAlpha" , "cornerRadius",  
	"textIndent", "letterSpacing", "highlightAlphas", "fillAlphas", "fillColors", "iconColor",
	"backgroundColor", "color",  "themeColor", "fontFamily", 
	"fontSize", "fontWeight", "fontStyle", "textDecoration"
];

[Bindable]
public var swatches:Array;