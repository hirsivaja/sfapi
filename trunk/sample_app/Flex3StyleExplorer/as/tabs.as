include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csstabWidth:String = "";
public var csstabHeight:String = "";
public var csscornerRadius:String = "";
public var csshorizontalGap:String = "";
public var csshorizontalAlign:String = "";
public var csstabOffset:String = "";
public var csstextIndent:String = "";
public var cssbackgroundAlpha:String = "";
public var cssbackgroundColor:String = "";
public var cssborderStyle:String = "";
public var cssborderColor:String = "";
public var cssborderThickness:String = "";
public var csscolor:String = "";
public var cssdropShadowEnabled:String = "";
public var cssshadowDirection:String = "";
public var cssshadowDistance:String = "";
public var cssdropShadowColor:String = "";

public var csscornerRadiustab:String = "";
public var csshighlightAlphastab:String = "";
public var cssfillAlphastab:String = "";
public var cssfillColorstab:String = "";
public var cssbackgroundAlphatab:String = "";
public var cssbackgroundColortab:String = "";
public var cssborderColortab:String = "";
public var csscolortab:String = "";
public var csstextRollOverColortab:String = "";
public var cssthemeColortab:String = "";
public var cssletterSpacingtab:String = "";
public var csstextAligntab:String = "";
public var cssfontFamilytab:String = "";
public var cssfontSizetab:String = "";
public var cssfontWeighttab:String = "";
public var cssfontStyletab:String = "";
public var csstextDecorationtab:String = "";

public var csscolorselectedTab:String = "";
public var csstextRollOverColorselectedTab:String = "";
public var cssletterSpacingselectedTab:String = "";
public var csstextAlignselectedTab:String = "";
public var cssfontFamilyselectedTab:String = "";
public var cssfontSizeselectedTab:String = "";
public var cssfontWeightselectedTab:String = "";
public var cssfontStyleselectedTab:String = "";
public var csstextDecorationselectedTab:String = "";


public var tabNavigatorStyles:Array = [
	"tabHeight", "tabWidth", "cornerRadius", "horizontalGap", "horizontalAlign", "tabOffset",
	"textIndent", "backgroundAlpha", "backgroundColor", "borderStyle", "borderColor", "borderThickness", 
	"color", "dropShadowEnabled", "shadowDirection", "shadowDistance", "dropShadowColor"
];

public var tabStyles:Array = [
	"cornerRadius", "highlightAlphas", "fillAlphas", "fillColors", "backgroundAlpha", "backgroundColor", "borderColor", 
	"color", "textRollOverColor", "themeColor", "letterSpacing", "textAlign", "fontWeight", "fontSize", "fontFamily", 
	"fontStyle", "textDecoration"
];

public var selectedTabStyles:Array = [
	"color", "textRollOverColor", "letterSpacing", "textAlign", "fontWeight", "fontSize", "fontFamily", 
	"fontStyle", "textDecoration"
];

[Bindable]
public var swatches:Array;