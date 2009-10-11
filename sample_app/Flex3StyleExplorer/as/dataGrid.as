include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssbackgroundAlpha:String  = "";
public var cssbackgroundColor:String  = "";
public  var cssalternatingItemColors:String  = "";
public var cssheaderColors:String  = "";
public var csshorizontalGridLines:String  = "";
public var csshorizontalGridLineColor:String  = "";
public var cssverticalGridLines:String  = "";
public var cssverticalGridLineColor:String  = "";
public var cssuseRollOver:String  = "";
public var cssrollOverColor:String  = "";
public var csstextRollOverColor:String  = "";
public var cssborderThickness:String  = "";
public var cssborderColor:String  = "";
public var cssselectionColor:String  = "";
public var csscolor:String  = "";
public var cssiconColor:String  = "";
public var csstextSelectedColor:String  = "";
public var csstextIndent:String  = "";
public var cssdropShadowEnabled:String  = "";
public var cssshadowDistance:String  = "";
public var cssshadowDirection:String  = "";
public var cssdropShadowColor:String  = "";
public var csscolorHeader:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssheaderColor:String = "";
public var cssheaderfontFamily:String = "";
public var cssheaderfontSize:String = "";
public var cssheaderfontWeight:String = "";
public var cssheaderfontStyle:String = "";
public var cssheadertextDecoration:String = "";
public var cssletterSpacing:String = "";
public var cssheaderletterSpacing:String = "";
public var cssheadertextAlign:String = "";

public var dataGridStyles:Array = [
	"backgroundAlpha", "backgroundColor", "alternatingItemColors", "headerColors", "horizontalGridLines", "letterSpacing",
	"horizontalGridLineColor", "verticalGridLines", "verticalGridLineColor", "useRollOver", "rollOverColor",
	"textRollOverColor", "borderThickness", "borderColor", "iconColor" , "selectionColor", "color", "textSelectedColor", 
	"textIndent", "dropShadowEnabled", "shadowDistance", "shadowDirection", "dropShadowColor",
	"fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration", "headerColor", "headerletterSpacing",
	"headerfontFamily", "headerfontSize", "headerfontWeight", "headerfontStyle", "headertextDecoration", "headertextAlign"
];

[Bindable]
public var swatches:Array;
