include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssheaderColors:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String  = "";
public var csstodayColor:String  = "";
public var cssrollOverColor:String = "";
public var cssselectionColor:String  = "";
public var cssiconColor:String  = "";
public var csscolor:String  = "";
public var cssborderColor:String  = "";
public var cssthemeColor:String  = "";
public var cssborderThickness:String = "";
public var cssdropShadowEnabled:String = "";
public var cssdropShadowColor:String = "";
public var cssshadowDirection:String  = "";
public var cssshadowDistance:String  = "";
public var cssbackgroundAlpha:String = "";
public var cssbackgroundColor:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var csshorizontalGap:String = "";
public var cssverticalGap:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssheadercolor:String = "";
public var cssheaderfontFamily:String = "";
public var cssheaderfontSize:String = "";
public var cssheaderfontWeight:String = "";
public var cssheaderfontStyle:String = "";
public var cssheadertextDecoration:String = "";
public var cssweekDaycolor:String = "";
public var cssweekDayfontFamily:String = "";
public var cssweekDayfontSize:String = "";
public var cssweekDayfontWeight:String = "";
public var cssweekDayfontStyle:String = "";
public var cssweekDaytextDecoration:String = "";
public var csstodaytextcolor:String = "";
public var csstodayfontFamily:String = "";
public var csstodayfontSize:String = "";
public var csstodayfontWeight:String = "";
public var csstodayfontStyle:String = "";
public var csstodaytextDecoration:String = "";

// weekDaystyleName, todaystyleName and headerstyleName 
		

public var dateChooserStyles:Array = [
	"cornerRadius", "borderThickness", "horizontalGap", "verticalGap", "headerColors", "highlightAlphas", "fillAlphas", 
	"fillColors", "todayColor", "rollOverColor", "selectionColor", "color", "borderColor", "iconColor",
	"backgroundColor", "backgroundAlpha", "themeColor", "dropShadowEnabled", "shadowDistance",
	"shadowDirection", "dropShadowColor", "fontFamily",
	"fontSize", "fontWeight", "fontStyle", "textDecoration", "headercolor",
	"headerfontFamily", "headerfontSize", "headerfontWeight", "headerfontStyle", "headertextDecoration", "weekDaycolor",
	"weekDayfontFamily", "weekDayfontSize", "weekDayfontWeight", "weekDayfontStyle", "weekDaytextDecoration", "todaytextcolor",
	"todayfontFamily", "todayfontSize", "todayfontWeight", "todayfontStyle", "todaytextDecoration"
];

[Bindable]
public var swatches:Array;