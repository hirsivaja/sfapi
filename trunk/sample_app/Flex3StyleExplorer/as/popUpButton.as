include "globalFuncs.as";
include "assets.as";
import mx.controls.Menu;

[Bindable]
public var myCSS:String = "";

private var myMenu:Menu;

public var csscornerRadius:String = "";
public var cssarrowButtonWidth:String = "";
public var csspopUpGap:String = "";
public var csstextIndent:String = "";
public var csspaddingLeft:String = "";
public var csspaddingRight:String = "";
public var csspaddingTop:String = "";
public var csspaddingBottom:String = "";
public var csshighlightAlphas:String  = "";
public var cssfillAlphas:String  = "";
public var cssfillColors:String  = "";
public var csscolor:String  = "";
public var cssborderColor:String = "";
public var cssthemeColor:String  = "";
public var csstextRollOverColor:String = "";
public var csstextSelectedColor:String = "";
public var cssletterSpacing:String = "";
public var cssiconColor:String = "";


public var popUpButtonStyles:Array = [
	"cornerRadius", "arrowButtonWidth", "popUpGap", "textIndent", "letterSpacing", "paddingLeft", "paddingRight", "paddingTop", 
	"paddingBottom", "highlightAlphas", "fillAlphas", "fillColors", "iconColor", "color", "textRollOverColor", 
	"textSelectedColor","borderColor", "themeColor"
];

private function initMenu():void {
	myMenu = new Menu();
	var dp:Object = [{label: "Action 1"}, {label: "Action 2"}, {label: "Action 3"}];        
	myMenu.dataProvider = dp;
	mypopUpButton.popUp = myMenu;
}

[Bindable]
public var swatches:Array;