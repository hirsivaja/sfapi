include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssheaderHeight:String = "";
public var cssdropShadowEnabled:String = "";
public var cssshadowDistance:String  = "";
public var cssshadowDirection:String  = "";
public var cssborderStyle:String  = "";
public var cssborderThickness:String  = "";
public var cssbackgroundAlpha:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var cssselectedFillColors:String  = "";
public var cssbackgroundColor:String  = "";
public var cssborderColor:String  = "";
public var csscolor:String  = "";
public var csstextRollOverColor:String  = "";
public var csstextSelectedColor:String  = "";
public var csstextIndent:String  = "";
public var cssopenDuration:String  = "";
public var csshighlightAlphas:String  = "";
public var cssdropShadowColor:String = "";
public var cssthemeColor:String = "";
public var csstextAlign:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";


public var accordionStyles:Array = [
	"borderStyle", "borderThickness", "headerHeight", "backgroundAlpha", "textIndent", "openDuration",
	"highlightAlphas", "fillAlphas", "fillColors", "selectedFillColors", "themeColor", "backgroundColor",
	"borderColor", "color", "textRollOverColor", "textSelectedColor", "textAlign", "fontFamily",
	"fontSize", "fontWeight", "fontStyle", "textDecoration", "dropShadowEnabled", "shadowDistance",
	"shadowDirection", "dropShadowColor", "letterSpacing"
];

[Bindable]
public var swatches:Array;
