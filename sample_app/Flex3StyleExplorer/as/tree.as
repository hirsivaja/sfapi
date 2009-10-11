include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssbackgroundAlpha:String = "";
public var cssbackgroundColor:String = "";
public var cssalternatingItemColors:String = "";
public var cssuseRollOver:String = "";
public var cssrollOverColor:String = "";
public var csstextRollOverColor:String = "";
public var cssborderThickness:String = "";
public var cssborderColor:String = "";
public var cssselectionColor:String = "";
public var csscolor:String = "";
public var csstextSelectedColor:String = "";
public var csstextIndent:String = "";
public var cssindentation:String = "";
public var cssopenDuration:String = "";
public var cssselectionDuration:String = "";
public var cssdepthColors:String = "";
public var cssdropShadowEnabled:String  = "";
public var cssshadowDistance:String  = "";
public var cssshadowDirection:String  = "";
public var cssdropShadowColor:String  = "";
public var cssborderStyle:String  = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var csscornerRadius:String = "";
public var cssletterSpacing:String = "";


public var treeStyles:Array = [
	"backgroundAlpha", "backgroundColor", "alternatingItemColors", "depthColors", "useRollOver", 
	"rollOverColor", "textRollOverColor", "borderStyle", "borderThickness", "borderColor", "selectionColor", 
	"color", "textSelectedColor", "textIndent", "letterSpacing", "indentation", "openDuration", "selectionDuration", 
	"dropShadowEnabled", "shadowDistance", "shadowDirection", "dropShadowColor", "fontFamily", 
	"fontSize", "fontWeight", "fontStyle", "textDecoration", "cornerRadius"
];


public function openTree():void {
		mytree.expandChildrenOf(mytree.firstVisibleItem, true);
}

[Bindable]
public var swatches:Array;
