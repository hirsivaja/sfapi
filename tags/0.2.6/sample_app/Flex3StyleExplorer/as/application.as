include "globalFuncs.as";
include "assets.as";

[Bindable]
public var myCSS:String = "";

public var cssbackgroundColor:String = "";
public var cssbackgroundImage:String = "";
public var cssthemeColor:String = "";
public var csscolor:String = "";
public var cssbackgroundGradientColors:String = "";
public var cssbackgroundGradientAlphas:String = "";
public var cssbackgroundSize:String = "";

public var applicationStyles:Array = [
	"backgroundImage", "backgroundSize", "backgroundColor", "backgroundGradientColors", "backgroundGradientAlphas", "themeColor", "color"
];

[Embed(source="/assets/backgrounds.swf#bluestripe")]
public var bluestripe:Class;

[Embed(source="/assets/brushedMetal.jpg")]
public var brushedmetal:Class;

[Embed(source="/assets/backgrounds.swf#greenstripe")]
public var greenstripe:Class;

[Embed(source="/assets/backgrounds.swf#industrial")]
public var industrial:Class;

[Embed(source="/assets/backgrounds.swf#redstripe")]
public var redstripe:Class;

[Embed(source="/assets/backgrounds.swf#retroFifties")]
public var retroFifties:Class;

[Embed(source="/assets/backgrounds.swf#tartan")]
public var tartan:Class;

public function init():void {
	var bgImage:Array = [{label:"None"},
						{label:"bluestripe", data:bluestripe},
						 {label:"redstripe", data:redstripe},
						 {label:"greenstripe", data:greenstripe},
						{label:"brushedmetal", data:brushedmetal},
						{label:"industrial", data:industrial},
						{label:"retroFifties", data:retroFifties},
						{label:"tartan", data:tartan}];
	
	mybackgroundImageapplication.dataProvider = bgImage;
	mybackgroundImageapplication.addEventListener("change", changeBackgroundImage);
	
}

public function changeBackgroundImage(e:Event):void {
	StyleManager.getStyleDeclaration("Application").setStyle('backgroundImage', mybackgroundImageapplication.selectedItem.data);
	if (mybackgroundImageapplication.selectedIndex == 0) {
		cssbackgroundImage = "";
		cssbackgroundSize = "";
		updateCSS('application');
	} else if (mybackgroundImageapplication.selectedIndex == 4) {
		setCSS('backgroundImage', 0, 'Embed(source="assets/'+mybackgroundImageapplication.selectedItem.label+'.jpg")', 'application');
		setCSS('backgroundSize', 0, '100%', 'application');		
	} else	{
		setCSS('backgroundImage', 0, 'Embed(source="assets/backgrounds.swf#'+mybackgroundImageapplication.selectedItem.label+'")', 'application');
		setCSS('backgroundSize', 0, '100%', 'application');
	}
}

[Bindable]
public var swatches:Array;