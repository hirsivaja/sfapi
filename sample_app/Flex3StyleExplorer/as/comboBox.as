include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var csscolor:String = "";
public var cssborderColor:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String = "";
public var cssbackgroundAlpha:String = "";
public var cssselectionColor:String = "";
public var csstextSelectedColor:String = "";
public var cssuseRollOver:String = "";
public var cssrollOverColor:String = "";
public var csstextRollOverColor:String = "";
public var cssthemeColor:String = "";
public var cssalternatingItemColors:String = "";
public var cssopenDuration:String = "";
public var csscloseDuration:String = "";
public var csstextAlign:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var csstextDecoration:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var cssletterSpacing:String = "";
public var cssiconColor:String = "";
public var cssarrowButtonWidth:String = "";

public var csscornerRadiusdropDown:String = "";
public var cssborderThicknessdropDown:String = "";
public var cssborderColordropDown:String = "";
public var csscolordropDown:String = "";
public var csstextAligndropDown:String = "";
public var cssfontSizedropDown:String = "";
public var cssfontFamilydropDown:String = "";
public var cssfontWeightdropDown:String = "";
public var cssfontStyledropDown:String = "";
public var csstextDecorationdropDown:String = "";
public var cssdropShadowEnableddropDown:String = "";
public var cssshadowDirectiondropDown:String = "";
public var cssshadowDistancedropDown:String = "";
public var cssdropShadowColordropDown:String = "";
public var cssletterSpacingdropDown:String = "";


public var comboBoxStyles:Array = [
	"cornerRadius", "color", "borderColor", "iconColor", "highlightAlphas", "fillAlphas", "fillColors", "arrowButtonWidth",
	"backgroundAlpha", "selectionColor", "textSelectedColor", "useRollOver", "rollOverColor", "textRollOverColor",
	"themeColor", "alternatingItemColors", "openDuration", "closeDuration", "textAlign", "fontFamily", "fontSize",
	"textDecoration", "fontWeight", "fontStyle", "letterSpacing"
];

public var dropDownStyles:Array = [
	"cornerRadius", "borderThickness", "borderColor", "color", "textAlign", "fontFamily", "fontSize",
	"fontWeight", "fontStyle", "textDecoration", "dropShadowEnabled", "shadowDirection", "shadowDistance",
	"dropShadowColor", "letterSpacing"
];

[Bindable]
public var swatches:Array;
