include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssbuttonHeight:String = "";
public var cssbuttonWidth:String = "";
public var csshorizontalGap:String = "";
public var csscornerRadiusLeft:String = "";
public var csscornerRadiusRight:String = "";
public var csstextIndent:String = "";
public var csshighlightAlphas:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var csscolor:String  = "";
public var cssborderColor:String = "";
public var cssthemeColor:String  = "";
public var csstextRollOverColor:String = "";
public var csstextSelectedColor:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";
public var cssselectedcolor:String ="";
public var cssselectedfontWeight:String = "";
public var cssselectedfontSize:String = "";
public var cssselectedfontFamily:String = "";
public var cssselectedfontStyle:String = "";
public var cssselectedtextDecoration:String = "";


public var toggleButtonBarStyles:Array = [
	"cornerRadiusLeft", "cornerRadiusRight", "buttonHeight", "buttonWidth", "horizontalGap", "textIndent", "letterSpacing",
	"highlightAlphas", "fillAlphas", "fillColors", "color", "textRollOverColor", "textSelectedColor",
	"borderColor", "themeColor", "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration",
	"selectedcolor", "selectedfontFamily", "selectedfontStyle", "selectedfontSize", "selectedfontWeight", "selectedtextDecoration"
];

[Bindable]
public var swatches:Array;