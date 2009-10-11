include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssrollOverColor:String = "";
public var cssselectionColor:String = "";
public var csscolor:String = "";
public var csstextRollOverColor:String = "";
public var csstextSelectedColor:String = "";
public var csspaddingLeft:String = "";
public var csspaddingRight:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";

public var linkButtonStyles:Array = [
	"cornerRadius", "paddingLeft", "paddingRight", "letterSpacing", "rollOverColor", "selectionColor", "color", 
	"textRollOverColor", "textSelectedColor", "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration"
];

[Bindable]
public var swatches:Array;