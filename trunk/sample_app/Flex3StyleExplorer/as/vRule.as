include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssstrokeColor:String = "";
public var cssshadowColor:String = "";
public var cssstrokeWidth:String = "";

public var vRuleStyles:Array = [
	"strokeColor", "shadowColor", "strokeWidth"
];

[Bindable]
public var swatches:Array;