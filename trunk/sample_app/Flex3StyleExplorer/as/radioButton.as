include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssborderColor:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String = "";
public var csscolor:String = "";
public var csstextRollOverColor:String = "";
public var csstextSelectedColor:String = "";
public var cssthemeColor:String = "";
public var csstextIndent:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";
public var cssiconColor:String = "";
public var cssdisabledIconColor:String ="";
public var cssdisabledColor:String ="";

public var radioButtonStyles:Array = [
	"textIndent", "letterSpacing", "highlightAlphas", "fillAlphas", "fillColors" , "borderColor", "iconColor", "disabledIconColor", "color",  
	"textSelectedColor", "textRollOverColor", "themeColor", "fontFamily", "disabledColor",
	"fontSize", "fontWeight", "fontStyle", "textDecoration"
];

[Bindable]
public var swatches:Array;