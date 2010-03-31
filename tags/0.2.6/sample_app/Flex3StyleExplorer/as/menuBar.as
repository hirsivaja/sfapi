include "globalFuncs.as";
include "assets.as";
import mx.collections.*;

[Bindable]
public var myCSS:String = "";

public var csscornerRadius:String = "";
public var cssbackgroundAlpha:String = "";
public var cssbackgroundColor:String = "";
public var cssborderColor:String = "";
public var csshighlightAlphas:String = "";
public var cssfillAlphas:String = "";
public var cssfillColors:String = "";
public var cssrollOverColor:String = "";
public var cssselectionColor:String = "";
public var csscolor:String = "";
public var csstextRollOverColor:String = "";
public var csstextSelectedColor:String = "";
public var cssdisabledColor:String = "";
public var cssthemeColor:String = "";

public var cssfontFamily:String = "";
public var cssfontSize:String = "";
public var cssfontWeight:String = "";
public var cssfontStyle:String = "";
public var csstextDecoration:String = "";
public var csstextAlign:String = "";
public var csstextIndent:String = "";
public var cssletterSpacing:String = "";


public var menuBarStyles:Array = [
	"cornerRadius", "letterSpacing", "backgroundAlpha", "backgroundColor", "borderColor", "highlightAlphas", "fillAlphas", "fillColors",
	"rollOverColor", "selectionColor", "color", "textRollOverColor", "textSelectedColor", "disabledColor", "themeColor",
	"fontFamily", "fontSize", "fontWeight", "fontStyle", "textDecoration", "textAlign", "textIndent"
];


[Bindable]
public var menuBarCollection:XMLListCollection;

private var menubarXML:XMLList =
    <>
    	<menuitem label="File">
            <menuitem label="New" data="1A"/>
            <menuitem label="Open" data="1B"/>
            <menuitem type="separator" />
            <menuitem label="Close" data="1C" enabled="false"/>
        </menuitem>
        <menuitem label="Edit">
            <menuitem label="Cut" data="2A"/>
            <menuitem label="Copy" data="2B"/>
            <menuitem label="Paste"   data="2C"/>
        </menuitem>
        <menuitem label="Format">
            <menuitem label="Font" data="3A">
            	<menuitem label="Arial" data="3ai" />
            	<menuitem label="Verdana" data="3aii" />
            	<menuitem label="Font not available" data="3aiii" enabled="false" />
            </menuitem>
         </menuitem>
         <menuitem label="Help">
         	<menuitem label="Help" />
         </menuitem>
    </>;
      
private function initCollections():void {
	menuBarCollection = new XMLListCollection(menubarXML);
}

[Bindable]
public var swatches:Array;