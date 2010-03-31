include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var csscloseDuration:String = "";
public var csscolumnCount:String = "";
public var csshorizontalGap:String = "";
public var cssopenDuration:String = "";
public var csspaddingTop:String = "";
public var csspaddingBottom:String = "";
public var csspaddingLeft:String = "";
public var csspaddingRight:String = "";
public var csspreviewHeight:String  = "";
public var csspreviewWidth:String = "";
public var cssswatchBorderColor:String = "";
public var cssswatchBorderSize:String = "";
public var cssswatchGridBackgroundColor:String = "";
public var cssswatchGridBorderSize:String = "";
public var cssswatchHeight:String = "";
public var cssswatchHighlightColor:String = "";
public var cssswatchHighlightSize:String = "";
public var cssswatchWidth:String = "";
public var csstextFieldWidth:String = "";
public var cssverticalGap:String = "";

public var colorPickerStyles:Array = [
	"closeDuration", "columnCount", "horizontalGap", "openDuration", "paddingTop", "paddingBottom", "paddingLeft", 
	"paddingRight", "previewHeight", "previewWidth", "swatchBorderColor", "swatchBorderSize", "swatchGridBackgroundColor", 
	"swatchGridBorderSize", "swatchHeight", "swatchHighlightColor", "swatchHighlightSize", "swatchWidth", "textFieldWidth", "verticalGap", 
];

[Bindable]
public var swatches:Array;