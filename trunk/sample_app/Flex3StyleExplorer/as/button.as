include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var csstextIndent:String = "";
public var csspaddingLeft:String = "";
public var csspaddingRight:String = "";
public var csspaddingTop:String = "";
public var csspaddingBottom:String = "";
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


public var buttonStyles:Array = [
	"cornerRadius", "textIndent", "paddingLeft", "paddingRight", "paddingTop", "paddingBottom", "letterSpacing",
	"highlightAlphas", "fillAlphas", "fillColors", "color", "textRollOverColor", "textSelectedColor",
	"borderColor", "themeColor", "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration"
];

[Bindable]
public var swatches:Array;