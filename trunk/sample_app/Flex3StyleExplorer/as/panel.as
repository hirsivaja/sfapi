include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssheaderHeight:String = "";
public var cssshadowDistance:String  = "";
public var cssborderThickness:String  = "";
public var cssdropShadowEnabled:String  = "";
public var cssroundedBottomCorners:String  = "";
public var cssshadowDirection:String  = "";
public var cssbackgroundAlpha:String  = "";
public var cssborderAlpha:String  = "";
public var csshighlightAlphas:String  = "";
public var cssborderStyle:String  = "";
public var cssheaderColors:String  = "";
public var cssfooterColors:String  = "";
public var cssbackgroundColor:String  = "";
public var cssborderColor:String  = "";
public var csscolor:String  = "";
public var cssdropShadowColor:String = "";
public var cssborderThicknessRight:String = "";
public var cssborderThicknessLeft:String = "";
public var cssborderThicknessBottom:String = "";
public var cssborderThicknessTop:String = "";
public var csstextAlign:String = "";
public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var cssletterSpacing:String = "";


public var panelStyles:Array = [
	"borderStyle", "borderColor", "borderAlpha", "borderThickness", "borderThicknessLeft", "borderThicknessTop",
	"borderThicknessBottom", "borderThicknessRight", "roundedBottomCorners", "cornerRadius",
	"headerHeight", "backgroundAlpha", "highlightAlphas", "headerColors", "footerColors", "backgroundColor",
	"color", "textAlign", "fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration", 
	"dropShadowEnabled", "shadowDistance", "shadowDirection", "dropShadowColor", "letterSpacing"
];


public function setBorderThicknessesValue (whichStyle:String, whatValue:Array, whatType:String, whichItem:String):void {
		mypanel.setStyle('borderThicknessLeft', whatValue[0]);
		mypanel.setStyle('borderThicknessTop', whatValue[1]);
		mypanel.setStyle('borderThicknessRight', whatValue[2]);
		mypanel.setStyle('borderThicknessBottom', whatValue[3]);
		setCSS('borderThicknessLeft', whatValue[0], whatType, whichItem);
		setCSS('borderThicknessTop', whatValue[1], whatType, whichItem);
		setCSS('borderThicknessRight', whatValue[2], whatType, whichItem);
		setCSS('borderThicknessBottom', whatValue[3], whatType, whichItem);
}

[Bindable]
public var swatches:Array;

