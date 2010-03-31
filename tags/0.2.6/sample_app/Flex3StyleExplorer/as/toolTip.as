include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssbackgroundAlpha:String = "";
public var csscornerRadius:String = "";
public var csspaddingLeft:String = "";
public var csspaddingRight:String = "";
public var cssbackgroundColor:String = "";
public var csscolor:String = "";
public var csstextAlign:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";

public var toolTipStyles:Array = [
	"backgroundAlpha", "cornerRadius", "paddingLeft", "paddingRight", "letterSpacing",
	"backgroundColor", "color", "textAlign", "fontFamily", "fontSize",
	"fontWeight", "fontStyle", "textDecoration"
];

[Bindable]
public var swatches:Array;