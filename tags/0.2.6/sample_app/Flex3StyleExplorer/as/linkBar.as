include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csshorizontalGap:String = "";
public var cssseparatorWidth:String = "";
public var cssborderStyle:String = "";
public var csscornerRadius:String = "";
public var cssborderThickness:String = "";
public var cssdropShadowEnabled:String = "";
public var cssshadowDistance:String = "";
public var cssshadowDirection:String = "";
public var cssbackgroundColor:String = "";
public var cssbackgroundAlpha:String = "";
public var cssborderColor:String = "";
public var cssseparatorColor:String = "";
public var cssrollOverColor:String = "";
public var cssselectionColor:String = "";
public var csscolor:String = "";
public var csstextRollOverColor:String = "";
public var csstextSelectedColor:String = "";
public var cssdropShadowColor:String = "";
public var cssdisabledColor:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String ="";


public var linkBarStyles:Array = [ 
	"borderStyle", "borderColor", "borderThickness", "horizontalGap", "separatorWidth", "letterSpacing", "cornerRadius",
	"backgroundAlpha",
	"backgroundColor", "separatorColor", "rollOverColor", "selectionColor", "color", "textRollOverColor",
	"textSelectedColor", "disabledColor", "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration", "dropShadowEnabled", 
	"shadowDistance", "shadowDirection", "dropShadowColor"
];

[Bindable]
public var swatches:Array;
