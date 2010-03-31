include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csslabelOffset:String = "";
public var cssthumbOffset:String = "";
public var csstickOffset:String = "";
public var csstickLength:String = "";
public var csstickThickness:String = "";
public var csstickColor:String = "";
public var cssshowTrackHighlight:String = "";
public var cssborderColor:String = "";
public var csstrackColors:String = "";
public var cssthemeColor:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String = "";
public var csscolor:String = "";
public var cssdataTipOffset:String = "";

public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssinvertThumbDirection:String = "";
public var cssletterSpacing:String = "";

public var vSliderStyles:Array = [
	"labelOffset", "thumbOffset", "dataTipOffset", "tickOffset" , "tickLength", "tickThickness", "tickColor",
	"showTrackHighlight", "invertThumbDirection" ,"borderColor", "trackColors", "color", "themeColor", "fillAlphas", "fillColors",
	 "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration", "letterSpacing"
];

[Bindable]
public var swatches:Array;