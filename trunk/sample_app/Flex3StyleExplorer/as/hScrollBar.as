include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssborderColor:String = "";
public var csshighlightAlphas:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var cssthemeColor:String  = "";
public var csstrackColors:String  = "";
public var cssiconColor:String ="";
public var cssthumbOffset:String = "";

public var hScrollBarStyles:Array = [
	"cornerRadius", "highlightAlphas", "fillAlphas", "fillColors",
	"trackColors", "themeColor", "borderColor", "iconColor", "thumbOffset"
];

[Bindable]
public var swatches:Array;