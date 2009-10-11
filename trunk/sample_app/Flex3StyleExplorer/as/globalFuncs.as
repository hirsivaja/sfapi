



public function rgbToHex(val:Number):String {
	
	var newVal:String = val.toString(16);
	while (newVal.length < 6) {	newVal = "0" + newVal; }			
	if (newVal.charAt(1) == 'x') {	newVal = newVal.slice(2, 8); }
	newVal = "#" + newVal;
	return newVal; 
	
}


public function setValue(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {
	
	if (whichItem == 'toolTip') {
		StyleManager.getStyleDeclaration("ToolTip").setStyle(whichStyle, whatValue);
	}  else if (whichItem == 'application' && whichStyle == 'backgroundColor') {
		StyleManager.getStyleDeclaration("Application").setStyle(whichStyle, whatValue);
	}  else if (whichItem == 'tab') {
		StyleManager.getStyleDeclaration(".StyledTabs").setStyle(whichStyle, whatValue);
	} else if (whichItem == 'selectedTab') {
		StyleManager.getStyleDeclaration(".SelectedStyledTabs").setStyle(whichStyle, whatValue);
	} else if (whichItem == 'dropDown') {
		StyleManager.getStyleDeclaration(".DropDownStyles").setStyle(whichStyle, whatValue);
	} else {
		this['my' + whichItem].setStyle(whichStyle, whatValue);
	}
	
	if (whichItem == 'radioButton' || whichItem == 'checkBox') {
		this['my' + whichItem + "1" ].setStyle(whichStyle, whatValue);
		this['my' + whichItem + "2" ].setStyle(whichStyle, whatValue);
	}
	
	if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar' ) {
		
		if (whichStyle == 'borderColor' || whichStyle == 'themeColor') {
			for (var i:Number = 0; i < 3; i++) {
				this['my' + whichItem].getChildAt(i).setStyle(whichStyle, whatValue);	
			}
		} else if (whichStyle == 'cornerRadiusLeft') {
			this['my' + whichItem].getChildAt(0).setStyle('cornerRadius', whatValue);
		} else if (whichStyle == 'cornerRadiusRight') {
			this['my' + whichItem].getChildAt(2).setStyle('cornerRadius', whatValue);
		}
		
	}
	
	if (whichItem == 'dataGrid' && whichStyle == 'headerColor') {
		StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('color', whatValue);	
	}
	
	if (whichItem == 'dataGrid' && whichStyle == 'headerletterSpacing') {
		StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('letterSpacing', whatValue);	
	}
	
	if (whichItem == 'dateChooser') {
		if (whichStyle == 'headercolor') {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle('color', whatValue);
		} else if (whichStyle == 'todaytextcolor') {
			StyleManager.getStyleDeclaration(".myTodayStyleName").setStyle('color', whatValue);
		} else if (whichStyle == 'weekDaycolor') {
			StyleManager.getStyleDeclaration(".myWeekDayStyleName").setStyle('color', whatValue);
		}
		
	}
	
	if (whichItem == "toggleButtonBar" && whichStyle == "selectedcolor") {
		StyleManager.getStyleDeclaration(".mySelectedButtonStyle").setStyle('color', whatValue);
	}
	
	
	setCSS(whichStyle, whatValue, whatType, whichItem);
	
}

public function setBooleanValue(whichStyle:String, whatValue:Boolean, whichItem:String):void {
	if (whichItem == 'dropDown') {
		StyleManager.getStyleDeclaration(".DropDownStyles").setStyle(whichStyle, whatValue);
	} else {
		this['my' + whichItem].setStyle(whichStyle, whatValue);
	}
	
	if (whichItem == 'radioButton' || whichItem == 'checkBox') {
		this['my' + whichItem + "1" ].setStyle(whichStyle, whatValue);
		this['my' + whichItem + "2" ].setStyle(whichStyle, whatValue);
	}
	setCSS(whichStyle, 0, String(whatValue), whichItem);
	
}

public var myHeaderStyle:CSSStyleDeclaration = new CSSStyleDeclaration();

public function setHeaderTextFormat(whatValue:Array, whichItem:String):void {
	
	var hitems:Array = ['fontWeight', 'fontStyle', 'textDecoration'];
	var hitemTrue:Array = ['bold', 'italic', 'underline'];
	var hitemFalse:Array = ['normal', 'normal', 'none'];
	
	for (var i:Number = 0; i < 3; i++) {
		if (whatValue[i] == true) {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle(hitems[i], hitemTrue[i]);
			setCSS("header" + hitems[i], 0, hitemTrue[i], whichItem);
		
		} else {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle(hitems[i], hitemFalse[i]);
			setCSS("header" + hitems[i], 0, hitemFalse[i], whichItem);	
		}
			
	}
}

public function setSelectedTextFormat(whatValue:Array, whichItem:String):void {
	
	var sitems:Array = ['fontWeight', 'fontStyle', 'textDecoration'];
	var sitemTrue:Array = ['bold', 'italic', 'underline'];
	var sitemFalse:Array = ['normal', 'normal', 'none'];
	
	for (var i:Number = 0; i < 3; i++) {
		if (whatValue[i] == true) {
			StyleManager.getStyleDeclaration(".mySelectedButtonStyle").setStyle(sitems[i], sitemTrue[i]);
			setCSS("selected" + sitems[i], 0, sitemTrue[i], whichItem);
		
		} else {
			StyleManager.getStyleDeclaration(".mySelectedButtonStyle").setStyle(sitems[i], sitemFalse[i]);
			setCSS("selected" + sitems[i], 0, sitemFalse[i], whichItem);	
		}
			
	}
}


public function setDGHeaderTextFormat(whatValue:Array, whichItem:String):void {
	
	var hitems:Array = ['fontWeight', 'fontStyle', 'textDecoration'];
	var hitemTrue:Array = ['bold', 'italic', 'underline'];
	var hitemFalse:Array = ['normal', 'normal', 'none'];
	
	for (var i:Number = 0; i < 3; i++) {
		if (whatValue[i] == true) {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle(hitems[i], hitemTrue[i]);
			setCSS("header" + hitems[i], 0, hitemTrue[i], whichItem);
		
		} else {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle(hitems[i], hitemFalse[i]);
			setCSS("header" + hitems[i], 0, hitemFalse[i], whichItem);	
		}
			
	}
}

public function setTodayTextFormat(whatValue:Array, whichItem:String):void {
	
	var titems:Array = ['fontWeight', 'fontStyle', 'textDecoration'];
	var titemTrue:Array = ['bold', 'italic', 'underline'];
	var titemFalse:Array = ['normal', 'normal', 'none'];
	
	for (var i:Number = 0; i < 3; i++) {
		if (whatValue[i] == true) {
			StyleManager.getStyleDeclaration(".myTodayStyleName").setStyle(titems[i], titemTrue[i]);
			setCSS("today" + titems[i], 0, titemTrue[i], whichItem);
		
		} else {
			StyleManager.getStyleDeclaration(".myTodayStyleName").setStyle(titems[i], titemFalse[i]);
			setCSS("today" + titems[i], 0, titemFalse[i], whichItem);	
		}
			
	}

}

public function setWeekDayTextFormat(whatValue:Array, whichItem:String):void {
	
	var witems:Array = ['fontWeight', 'fontStyle', 'textDecoration'];
	var witemTrue:Array = ['bold', 'italic', 'underline'];
	var witemFalse:Array = ['normal', 'normal', 'none'];
	
	for (var i:Number = 0; i < 3; i++) {
		if (whatValue[i] == true) {
			StyleManager.getStyleDeclaration(".myWeekDayStyleName").setStyle(witems[i], witemTrue[i]);
			setCSS("weekDay" + witems[i], 0, witemTrue[i], whichItem);
		
		} else {
			StyleManager.getStyleDeclaration(".myWeekDayStyleName").setStyle(witems[i], witemFalse[i]);
			setCSS("weekDay" + witems[i], 0, witemFalse[i], whichItem);	
		}
			
	}
}
							
public function setTextFormat(whatValue:Array, whichItem:String):void {
	
	var items:Array = ['fontWeight', 'fontStyle', 'textDecoration'];
	var itemTrue:Array = ['bold', 'italic', 'underline'];
	var itemFalse:Array = ['normal', 'normal', 'none'];
	
	for (var i:Number = 0; i < 3; i++) {
		if (whatValue[i] == true) {
			if (whichItem == 'toolTip') {
				StyleManager.getStyleDeclaration("ToolTip").setStyle(items[i], itemTrue[i]);
			} else if (whichItem == 'dropDown') {
				StyleManager.getStyleDeclaration(".DropDownStyles").setStyle(items[i], itemTrue[i]);
			} else if (whichItem == 'tab') {
				StyleManager.getStyleDeclaration(".StyledTabs").setStyle(items[i], itemTrue[i]);
			}  else if (whichItem == 'selectedTab') {
				StyleManager.getStyleDeclaration(".SelectedStyledTabs").setStyle(items[i], itemTrue[i]);
			}  else if (whichItem == 'panel') {
				StyleManager.getStyleDeclaration(".myTitleStyle").setStyle(items[i], itemTrue[i]);
			} else {
				this['my' + whichItem ].setStyle(items[i], itemTrue[i]);	
			}
			if (whichItem == 'radioButton'  || whichItem == 'checkBox') {
				this['my' + whichItem + "1" ].setStyle(items[i], itemTrue[i]);
				this['my' + whichItem + "2" ].setStyle(items[i], itemTrue[i]);
			}
			if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar') {
				for (var j:Number = 0; j < 3; j++) {
					this['my' + whichItem].getChildAt(j).setStyle(items[i], itemTrue[i]);
				}
			}
			
			setCSS(items[i], 0, itemTrue[i], whichItem);
		
		} else {
			if (whichItem == 'toolTip') {
				StyleManager.getStyleDeclaration("ToolTip").setStyle(items[i], itemFalse[i]);
			} else if (whichItem == 'dropDown') {
				StyleManager.getStyleDeclaration(".DropDownStyles").setStyle(items[i], itemFalse[i]);
			} else if (whichItem == 'tab') {
				StyleManager.getStyleDeclaration(".StyledTabs").setStyle(items[i], itemFalse[i]);
			} else if (whichItem == 'selectedTab') {
				StyleManager.getStyleDeclaration(".SelectedStyledTabs").setStyle(items[i], itemFalse[i]);
			} else if (whichItem == 'panel') {
				StyleManager.getStyleDeclaration(".myTitleStyle").setStyle(items[i], itemFalse[i]);
			} else {
				this['my' + whichItem].setStyle(items[i], itemFalse[i]);
			}
			if (whichItem == 'radioButton'  || whichItem == 'checkBox') {
				this['my' + whichItem + "1"].setStyle(items[i], itemFalse[i]);
				this['my' + whichItem + "2"].setStyle(items[i], itemFalse[i]);
			}
		
			if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar') {
				for (j = 0; j < 3; j++) {
					this['my' + whichItem].getChildAt(j).setStyle(items[i], itemFalse[i]);
				}
			}
			
			if ( items[i] != 'fontWeight' && whichItem != 'tab' && whichItem != 'dropDown' && whichItem != 'selectedTab') {
				this['css' + items[i]] = '';
			} else if (items[i] != 'fontWeight' && whichItem == 'tab') {
				this['css' + items[i] + 'tab'] = '';
			} else if (items[i] != 'fontWeight' && whichItem == 'selectedTab') {
				this['css' + items[i] + 'selectedTab'] = '';
			} else if (items[i] != 'fontWeight' && whichItem == 'droDown') {
				this['css' + items[i] + 'dropDown'] = '';
			} else {
				setCSS(items[i], 0, itemFalse[i], whichItem);	
			}
			if (whichItem == 'dropDown') {
				updateCSS('comboBox');
			} else if (whichItem == 'tab') {
				updateCSS('tabNavigator');	
			} else if (whichItem == 'selectedTab') {
				updateCSS('tabNavigator');	
			} else {
				updateCSS(whichItem);	
			}
			
		}
	}
	
}

public function setStringValue(whichStyle:String, whatValue:String, whichItem:String):void {
	
	if (whatValue == 'default') {
		this['my' + whichItem].clearStyle(whichStyle);
		if (whichItem == 'radioButton' || whichItem == 'checkBox') {
			this['my' + whichItem + "1"].clearStyle(whichStyle);
			this['my' + whichItem + "2"].clearStyle(whichStyle);
		
		}
	} else if (whichItem == 'toolTip') {
		StyleManager.getStyleDeclaration("ToolTip").setStyle(whichStyle, whatValue);
	
	}  else if (whichItem == 'dropDown') {
		StyleManager.getStyleDeclaration(".DropDownStyles").setStyle(whichStyle, whatValue);
	
	} else if (whichItem == 'tab') {
		StyleManager.getStyleDeclaration(".StyledTabs").setStyle(whichStyle, whatValue);
	} else if (whichItem == 'selectedTab') {
		StyleManager.getStyleDeclaration(".SelectedStyledTabs").setStyle(whichStyle, whatValue);
	} else {
		
		if (whichStyle == 'headerfontFamily' && whichItem == 'dataGrid') {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'headerfontSize'  && whichItem == 'dataGrid') {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('fontSize', whatValue);
		}  else if (whichStyle == 'headertextAlign'  && whichItem == 'dataGrid') {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('textAlign', whatValue);
		} else if (whichStyle == 'headerfontFamily'  && whichItem == 'dataGrid') {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'headerfontSize'  && whichItem == 'dataGrid') {
			StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('fontSize', whatValue);
		}  if (whichStyle == 'headerfontFamily' && whichItem == 'dateChooser') {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'headerfontSize' && whichItem == 'dateChooser') {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle('fontSize', whatValue);
		} else if (whichStyle == 'headerfontFamily' && whichItem == 'dateChooser') {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'headerfontSize' && whichItem == 'dateChooser') {
			StyleManager.getStyleDeclaration(".HeaderStyle").setStyle('fontSize', whatValue);
		} else if (whichStyle == 'todayfontFamily') {
			StyleManager.getStyleDeclaration(".myTodayStyleName").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'todayfontSize') {
			StyleManager.getStyleDeclaration(".myTodayStyleName").setStyle('fontSize', whatValue);
		} else if (whichStyle == 'weekDayfontFamily') {
			StyleManager.getStyleDeclaration(".myWeekDayStyleName").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'weekDayfontSize') {
			StyleManager.getStyleDeclaration(".myWeekDayStyleName").setStyle('fontSize', whatValue);
		} else if (whichStyle == 'selectedfontFamily') {
			StyleManager.getStyleDeclaration(".mySelectedButtonStyle").setStyle('fontFamily', whatValue);
		} else if (whichStyle == 'selectedfontSize') {
			StyleManager.getStyleDeclaration(".mySelectedButtonStyle").setStyle('fontSize', whatValue);
		} 
		
		
		
		
		
		else {
			this['my' + whichItem].setStyle(whichStyle, whatValue);	
			if (whichItem == 'radioButton' || whichItem == 'checkBox') {
				this['my' + whichItem + "1"].setStyle(whichStyle, whatValue);	
				this['my' + whichItem + "2"].setStyle(whichStyle, whatValue);	
			
			}	
		}
		
	}	
	setCSS(whichStyle, 0, whatValue, whichItem);
}


public function setArrayValue (whichStyle:String, whatValue:Array, whatType:String, whichItem:String):void {
	if (whichItem == 'tab') {
		StyleManager.getStyleDeclaration(".StyledTabs").setStyle(whichStyle, whatValue);
	} else if (whichItem == 'selectedTab') {
		StyleManager.getStyleDeclaration(".SelectedStyledTabs").setStyle(whichStyle, whatValue);
	} else if (whichItem == 'application') {
		StyleManager.getStyleDeclaration("Application").setStyle(whichStyle, whatValue);
	}  else {
		this['my' + whichItem].setStyle(whichStyle, whatValue);
	}
	if (whichItem == 'radioButton' || whichItem == 'checkBox') {
			this['my' + whichItem + "1"].setStyle(whichStyle, whatValue);	
			this['my' + whichItem + "2"].setStyle(whichStyle, whatValue);	
	}
	if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar') {
		 if ( whichStyle == 'highlightAlphas') {
			for (var i:Number = 0; i < 3; i++) {
				this['my' + whichItem].getChildAt(i).setStyle(whichStyle, whatValue);	
			}
		 }
	}
	
	
	if (whatType == 'color') {
		setArrayCSS(whichStyle, whatValue[0], whatValue[1], true, whichItem);
	} else {
		setArrayCSS(whichStyle, whatValue[0], whatValue[1], false, whichItem);
	}
	
}

public function setQuadArrayValue (whichStyle:String, whatValue:Array, whatType:String, whichItem:String):void {
	this['my' + whichItem].setStyle(whichStyle, whatValue);
	if (whichItem == 'radioButton' || whichItem == 'checkBox') {
			this['my' + whichItem + "1"].setStyle(whichStyle, whatValue);	
			this['my' + whichItem + "2"].setStyle(whichStyle, whatValue);	
	}
	if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar' ) {
		if (whichStyle == 'fillAlphas' || whichStyle == 'fillColors') {
			for (var i:Number = 0; i < 3; i++) {
				this['my' + whichItem].getChildAt(i).setStyle(whichStyle, whatValue);	
			}
		}
		
	}
	
	
	if (whatType == 'color') {
		setArrayFourCSS(whichStyle, whatValue[0], whatValue[1], whatValue[2], whatValue[3], true, whichItem);
	} else {
		setArrayFourCSS(whichStyle, whatValue[0], whatValue[1], whatValue[2], whatValue[3], false, whichItem);
	}
}


public function setArrayCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, isColor:Boolean, whichItem:String):void {
	
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2); } 
	else { newValue =whatValue1 + ", " + whatValue2; }
	setCSS(whichStyle, 0, newValue, whichItem);
	
}

public function setArrayFourCSS(whichStyle:String, whatValue1:Number, whatValue2:Number, whatValue3:Number, whatValue4:Number, isColor:Boolean, whichItem:String):void {
	
	var newValue:String;
	if (isColor == true) { newValue = rgbToHex(whatValue1) + ", " + rgbToHex(whatValue2) + ", " + rgbToHex(whatValue3) + ", " + rgbToHex(whatValue4); } 
	else { newValue =whatValue1 + ", " + whatValue2 + ", " + whatValue3 + ", " + whatValue4; }
	setCSS(whichStyle, 0, newValue, whichItem);
	
}


public function setCSS(whichStyle:String, whatValue:Number, whatType:String, whichItem:String):void {

	if (whatType == 'color') {
		whatType = String(rgbToHex(whatValue));
	} else if (whatType == 'number') {
		whatType = String(whatValue);
	}
	
	if (whichStyle == 'cornerRadiusLeft') {
		this["css" + whichStyle] = "   cornerRadius: " + whatType + ";\n";
	} else if (whichStyle == 'cornerRadiusRight') {
		this["css" + whichStyle] = "   cornerRadius: " + whatType + ";\n";
	} else if (whichStyle == 'headerColor') {
		this["css" + whichStyle] = "   color: " + whatType + ";\n";
	} else if (whichStyle == 'headerletterSpacing') {
		this["css" + whichStyle] = "   letterSpacing: " + whatType + ";\n";
	} else if (whichStyle == 'headercolor') {
		this["css" + whichStyle] = "   color: " + whatType + ";\n";
	} else if (whichStyle == 'todaytextcolor') {
		this["css" + whichStyle] = "   color: " + whatType + ";\n";
	} else if (whichStyle == 'weekDaycolor') {
		this["css" + whichStyle] = "   color: " + whatType + ";\n";
	} else if (whichStyle == 'headerfontSize') {
		this["css" + whichStyle] = "   fontSize: " + whatType + ";\n";
	} else if (whichStyle == 'headerfontFamily') {
		this["css" + whichStyle] = "   fontFamily: " + whatType + ";\n";
	} else if (whichStyle == 'headerfontWeight') {
		this["css" + whichStyle] = "   fontWeight: " + whatType + ";\n";
	} else if (whichStyle == 'headerfontStyle') {
		this["css" + whichStyle] = "   fontStyle: " + whatType + ";\n";
	} else if (whichStyle == 'headertextDecoration') {
		this["css" + whichStyle] = "   textDecoration: " + whatType + ";\n";
	} else if (whichStyle == 'headertextAlign') {
		this["css" + whichStyle] = "   textAlign: " + whatType + ";\n";
	} 	else if (whichStyle == 'todayfontSize') {
		this["css" + whichStyle] = "   fontSize: " + whatType + ";\n";
	} else if (whichStyle == 'todayfontFamily') {
		this["css" + whichStyle] = "   fontFamily: " + whatType + ";\n";
	} else if (whichStyle == 'todayfontWeight') {
		this["css" + whichStyle] = "   fontWeight: " + whatType + ";\n";
	} else if (whichStyle == 'todayfontStyle') {
		this["css" + whichStyle] = "   fontStyle: " + whatType + ";\n";
	} else if (whichStyle == 'todaytextDecoration') {
		this["css" + whichStyle] = "   textDecoration: " + whatType + ";\n";
	} else if (whichStyle == 'weekDayfontSize') {
		this["css" + whichStyle] = "   fontSize: " + whatType + ";\n";
	} else if (whichStyle == 'weekDayfontFamily') {
		this["css" + whichStyle] = "   fontFamily: " + whatType + ";\n";
	} else if (whichStyle == 'weekDayfontWeight') {
		this["css" + whichStyle] = "   fontWeight: " + whatType + ";\n";
	} else if (whichStyle == 'weekDayfontStyle') {
		this["css" + whichStyle] = "   fontStyle: " + whatType + ";\n";
	} else if (whichStyle == 'weekDaytextDecoration') {
		this["css" + whichStyle] = "   textDecoration: " + whatType + ";\n";
	} else if (whichStyle == 'selectedcolor') {
		this["css" + whichStyle] = "   color: " + whatType + ";\n";
	} else if (whichStyle == 'selectedfontFamily') {
		this["css" + whichStyle] = "   fontFamily: " + whatType + ";\n";
	} else if (whichStyle == 'selectedfontSize') {
		this["css" + whichStyle] = "   fontSize: " + whatType + ";\n";
	} else if (whichStyle == 'selectedfontWeight') {
		this["css" + whichStyle] = "   fontWeight: " + whatType + ";\n";
	} else if (whichStyle == 'selectedfontStyle') {
		this["css" + whichStyle] = "   fontStyle: " + whatType + ";\n";
	} else if (whichStyle == 'selectedtextDecoration') {
		this["css" + whichStyle] = "   textDecoration: " + whatType + ";\n";
	} else if (whichItem == 'tab') {
		this["css" + whichStyle + 'tab'] = "   " + whichStyle + ": " + whatType + ";\n";
	} else if (whichItem == 'selectedTab') {
		this["css" + whichStyle + 'selectedTab'] = "   " + whichStyle + ": " + whatType + ";\n";
	} else if (whichItem == 'dropDown') {
		this["css" + whichStyle + 'dropDown'] = "   " + whichStyle + ": " + whatType + ";\n";
	} else {
		this["css" + whichStyle] = "   " + whichStyle + ": " + whatType + ";\n";
	}
	
	if (whatType == 'default') {
		this["cssborderStyle"] = '';
	}

	if (whichItem == 'tab') {
		updateCSS('tabNavigator');	
	} else if (whichItem == 'selectedTab') {
		updateCSS('tabNavigator');	
	} else if (whichItem == 'dropDown') {
		updateCSS('comboBox');
	} else {
		updateCSS(whichItem);
	}
	
}

public function updateCSS(whichItem:String):void {

	var whichItemUpper:String = whichItem.substr(0, 1).toUpperCase() + whichItem.substr(1);
	
	myCSS = whichItemUpper + " {\n";
	
	for (var i:Number = 0; i < this[whichItem + 'Styles'].length; i++) {
		//Loop for Accordions, Panels, Sliders
		if (whichItem == 'accordion' || whichItem == 'panel' || whichItem == 'vSlider' || whichItem == 'hSlider') {
			if (this[whichItem + 'Styles'][i] != 'color' && this[whichItem + 'Styles'][i] != 'textAlign'
				&& this[whichItem + 'Styles'][i] != 'fontFamily' && this[whichItem + 'Styles'][i] != 'fontSize'
				&& this[whichItem + 'Styles'][i] != 'fontWeight' && this[whichItem + 'Styles'][i] != 'fontStyle'
				&& this[whichItem + 'Styles'][i] != 'textDecoration' && this[whichItem + 'Styles'][i] != 'letterSpacing' ) {
				myCSS += this['css'+ this[whichItem + 'Styles'][i]];
			}
		//Loop for DataGrid
		} else if (whichItem == 'dataGrid') {
			if (this[whichItem + 'Styles'][i] != 'headerColor' && this[whichItem + 'Styles'][i] != 'headerfontFamily' 
				&& this[whichItem + 'Styles'][i] != 'headerfontSize' && this[whichItem + 'Styles'][i] != 'headerfontWeight' 
				&& this[whichItem + 'Styles'][i] != 'headerfontStyle' && this[whichItem + 'Styles'][i] != 'headertextDecoration'
				&& this[whichItem + 'Styles'][i] != 'headerletterSpacing' && this[whichItem + 'Styles'][i] != 'headertextAlign') {
					myCSS += this['css'+ this[whichItem + 'Styles'][i]];
			}
		
		//Loop for DateChooser
		} else if (whichItem == 'dateChooser') {
			if (this[whichItem + 'Styles'][i] != 'headercolor' && this[whichItem + 'Styles'][i] != 'headerfontFamily' 
				&& this[whichItem + 'Styles'][i] != 'headerfontSize' && this[whichItem + 'Styles'][i] != 'headerfontWeight' 
				&& this[whichItem + 'Styles'][i] != 'headerfontStyle' && this[whichItem + 'Styles'][i] != 'headertextDecoration'
				&& this[whichItem + 'Styles'][i] != 'weekDaycolor' && this[whichItem + 'Styles'][i] != 'weekDayfontFamily' 
				&& this[whichItem + 'Styles'][i] != 'weekDayfontSize' && this[whichItem + 'Styles'][i] != 'weekDayfontWeight' 
				&& this[whichItem + 'Styles'][i] != 'weekDayfontStyle' && this[whichItem + 'Styles'][i] != 'weekDaytextDecoration' 
				&& this[whichItem + 'Styles'][i] != 'todaytextcolor' && this[whichItem + 'Styles'][i] != 'todayfontFamily' 
				&& this[whichItem + 'Styles'][i] != 'todayfontSize' && this[whichItem + 'Styles'][i] != 'todayfontWeight' 
				&& this[whichItem + 'Styles'][i] != 'todayfontStyle' && this[whichItem + 'Styles'][i] != 'todaytextDecoration' 
				) {
					myCSS += this['css'+ this[whichItem + 'Styles'][i]];
			}
				
		//Loop for ButtonBars
		} else if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar') {
			if (this[whichItem + 'Styles'][i] != 'cornerRadiusLeft' && this[whichItem + 'Styles'][i] != 'highlightAlphas'
				&& this[whichItem + 'Styles'][i] != 'fillAlphas' && this[whichItem + 'Styles'][i] != 'fillColors'
				&& this[whichItem + 'Styles'][i] != 'borderColor' && this[whichItem + 'Styles'][i] != 'themeColor'
				&& this[whichItem + 'Styles'][i] != 'color' && this[whichItem + 'Styles'][i] != 'textRollOverColor'
				 && this[whichItem + 'Styles'][i] != 'textSelectedColor'  && this[whichItem + 'Styles'][i] != 'cornerRadiusRight'
				&& this[whichItem + 'Styles'][i] != 'fontFamily' && this[whichItem + 'Styles'][i] != 'fontSize'
				&& this[whichItem + 'Styles'][i] != 'fontWeight' && this[whichItem + 'Styles'][i] != 'fontStyle'
				&& this[whichItem + 'Styles'][i] != 'textDecoration' && this[whichItem + 'Styles'][i] != 'selectedcolor'
				&& this[whichItem + 'Styles'][i] != 'selectedfontFamily' && this[whichItem + 'Styles'][i] != 'selectedfontSize'
				&& this[whichItem + 'Styles'][i] != 'selectedfontWeight' && this[whichItem + 'Styles'][i] != 'selectedfontStyle'
				&& this[whichItem + 'Styles'][i] != 'selectedtextDecoration') {
				myCSS += this['css'+ this[whichItem + 'Styles'][i]];
			}
		//Loop for everybody else
		} else {
			myCSS += this['css'+ this[whichItem + 'Styles'][i]];
		}
		
	}
	//TabStyleName for TabNavigator
	if (whichItem == 'tabNavigator' ) {
		if (this['csscornerRadiustab'] != '' || this['csshighlightAlphastab'] != ''
			|| this['cssfillAlphastab'] != '' || this['cssfillColorstab'] != ''
			|| this['cssbackgroundAlphatab'] != '' || this['cssbackgroundColortab'] != ''
			|| this['cssborderColortab'] != '' || this['csscolortab'] != '' || this['cssletterSpacingtab'] != ''
			|| this['csstextAligntab'] != '' || this['cssfontFamilytab'] != '' || this['cssfontSizetab'] != ''
			|| this['cssfontWeighttab'] != '' || this['cssfontStyletab'] != '' || this['csstextDecorationtab'] != ''
			|| this['csstextRollOverColortab'] != '' || this['cssthemeColortab'] != ''
			|| this['csscolorselectedTab'] != '' || this['csstextRollOverColorselectedTab'] != ''
			|| this['cssletterSpacingselectedTab'] != '' || this['csstextAlignselectedTab'] != ''
			|| this['cssfontFamilyselectedTab'] != '' || this['cssfontSizeselectedTab'] != ''
			|| this['cssfontWeightselectedTab'] != '' || this['cssfontStyleselectedTab'] != ''
			|| this['csstextDecorationselectedTab'] != '' 
			) {
			myCSS += '   tabStyleName: "myTabs";\n   '
			+ 'firstTabStyleName: "myTabs";\n   '
			+ 'lastTabStyleName: "myTabs";\n   '
			+ 'selectedTabTextStyleName: "mySelectedTabs";\n}\n\n.myTabs {\n' 
			+ this['csscornerRadiustab'] + this['csshighlightAlphastab'] + this['cssletterSpacingtab']
			+ this['cssfillAlphastab'] + this['cssfillColorstab']
			+ this['cssbackgroundAlphatab'] + this['cssbackgroundColortab']
			+ this['cssborderColortab'] + this['csscolortab']
			+ this['csstextRollOverColortab'] + this['cssthemeColortab']
			+ this['csstextAligntab'] + this['cssfontFamilytab']
			+ this['cssfontSizetab'] + this['cssfontWeighttab']
			+ this['cssfontStyletab'] + this['csstextDecorationtab'];
			
			myCSS += '\n}\n\n.mySelectedTabs {\n'
			+ this['cssletterSpacingselectedTab'] + this['csscolorselectedTab']
			+ this['csstextRollOverColorselectedTab']
			+ this['csstextAlignselectedTab'] + this['cssfontFamilyselectedTab']
			+ this['cssfontSizeselectedTab'] + this['cssfontWeightselectedTab']
			+ this['cssfontStyleselectedTab'] + this['csstextDecorationselectedTab'];
			
		}
	}
	//dropdownStyleName for ComboBox
	
	if (whichItem == 'comboBox' ) {
		if (this['csscornerRadiusdropDown'] != '' || this['cssborderThicknessdropDown'] != ''
			|| this['cssborderColordropDown'] != '' || this['csscolordropDown'] != ''
			|| this['csstextAligndropDown'] != '' || this['cssfontFamilydropDown'] != ''
			|| this['cssfontWeightdropDown'] != '' || this['cssfontStyledropDown'] != ''
			|| this['csstextDecorationdropDown'] != '' || this['cssdropShadowEnableddropDown'] != ''
			|| this['cssshadowDirectiondropDown'] != '' || this['cssshadowDistancedropDown'] != ''
			|| this['cssdropShadowColordropDown'] != '' || this['cssfontSizedropDown'] != ''
			|| this['cssletterSpacingdropDown'] != '' ) {
			myCSS += '   dropdownStyleName: "myComboBoxDropDowns";\n}\n\n.myComboBoxDropDowns {\n' 
			+ this['csscornerRadiusdropDown'] + this['cssborderThicknessdropDown'] + this['cssletterSpacingdropDown']
			+ this['cssborderColordropDown'] + this['csscolordropDown']
			+ this['csstextAligndropDown'] + this['cssfontFamilydropDown'] + this['cssfontSizedropDown']
			+ this['cssfontWeightdropDown'] + this['cssfontStyledropDown']
			+ this['csstextDecorationdropDown'] + this['cssdropShadowEnableddropDown']
			+ this['cssshadowDirectiondropDown'] + this['cssshadowDistancedropDown']
			+ this['cssdropShadowColordropDown'] ;
		}
	}
	

	
	//HeaderStyleName for Accordion
	if (whichItem == 'accordion') {
		if (this['csscolor'] != '' || this['csstextAlign'] != ''
			|| this['cssfontFamily'] != '' || this['cssfontSize'] != ''
			|| this['cssfontWeight'] != '' || this['cssfontStyle'] != ''
			|| this['csstextDecoration'] != '' || this['cssletterSpacing'] != '') {
			myCSS += '   headerStyleName: "my'+whichItem+'Header";\n}\n\n.my'+whichItem+'Header {\n' 
			+ this['cssletterSpacing'] + this['csscolor'] + this['csstextAlign']
			+ this['cssfontFamily'] + this['cssfontSize']
			+ this['cssfontWeight'] + this['cssfontStyle']
			+ this['csstextDecoration'];
		}
	}
	
	//HeaderStyleName for  Panels
	if (whichItem == 'panel') {
		if (this['csscolor'] != '' || this['csstextAlign'] != ''
			|| this['cssfontFamily'] != '' || this['cssfontSize'] != ''
			|| this['cssfontWeight'] != '' || this['cssfontStyle'] != ''
			|| this['csstextDecoration'] != '' || this['cssletterSpacing'] != '') {
			myCSS += '   titleStyleName: "my'+whichItem+'Title";\n}\n\n.my'+whichItem+'Title {\n' 
			+ this['cssletterSpacing'] + this['csscolor'] + this['csstextAlign']
			+ this['cssfontFamily'] + this['cssfontSize']
			+ this['cssfontWeight'] + this['cssfontStyle']
			+ this['csstextDecoration'];
		}
	}
	
	//ButtonStyleName for ButtonBar
	if (whichItem == 'buttonBar') {
		
		
		if ( this['csshighlightAlphas'] != '' || this['csscornerRadiusLeft'] != '' || this['csscornerRadiusRight'] != ''
			|| this['cssfillAlphas'] != '' || this['cssfillColors'] != ''
			|| this['cssborderColor'] != '' || this['cssthemeColor'] != ''
			|| this['csscolor'] != '' || this['csstextRollOverColor'] != '' || this['csstextSelectedColor'] != ''
			|| this['cssfontFamily'] != '' || this['cssfontSize'] != ''
			|| this['cssfontWeight'] != '' || this['cssfontStyle'] != ''
			|| this['csstextDecoration'] != '') {
			myCSS += '   buttonStyleName: "my'+whichItem+'ButtonStyle";\n';
			myCSS += '   firstButtonStyleName: "my'+whichItem+'FirstButtonStyle";\n';
			myCSS += '   lastButtonStyleName: "my'+whichItem+'LastButtonStyle";\n';
			myCSS += '}\n\n.my'+whichItem+'ButtonStyle {\n' 
			+ this['csshighlightAlphas']
			+ this['cssfillAlphas'] + this['cssfillColors']
			+ this['csscolor'] + this['csstextRollOverColor'] + this['csstextSelectedColor']
			+ this['cssborderColor'] + this['cssthemeColor']
			+ this['cssfontFamily'] + this['cssfontSize']
			+ this['cssfontWeight'] + this['cssfontStyle']
			+ this['csstextDecoration'];
			myCSS += '}\n\n.my'+whichItem+'FirstButtonStyle {\n' 
			+ this['csscornerRadiusLeft'];
			myCSS += '}\n\n.my'+whichItem+'LastButtonStyle {\n' 
			+ this['csscornerRadiusRight'];
		}
	}
	
	//ButtonStyleName for ButtonBar
	if (whichItem == 'toggleButtonBar') {
		
		
		if ( this['csshighlightAlphas'] != '' || this['csscornerRadiusLeft'] != '' || this['csscornerRadiusRight'] != ''
			|| this['cssfillAlphas'] != '' || this['cssfillColors'] != ''
			|| this['cssborderColor'] != '' || this['cssthemeColor'] != ''
			|| this['csscolor'] != '' || this['csstextRollOverColor'] != '' || this['csstextSelectedColor'] != ''
			|| this['cssfontFamily'] != '' || this['cssfontSize'] != ''
			|| this['cssfontWeight'] != '' || this['cssfontStyle'] != ''
			|| this['csstextDecoration'] != '' || this['cssselectedcolor'] != ''
			|| this['cssselectedfontFamily'] != '' || this['cssselectedfontWeight'] != ''
			|| this['cssselectedfontStyle'] != '' || this['cssselectedtextDecoration'] != ''
			 || this['cssselectedfontSize'] != '') {
			myCSS += '   buttonStyleName: "my'+whichItem+'ButtonStyle";\n';
			myCSS += '   firstButtonStyleName: "my'+whichItem+'FirstButtonStyle";\n';
			myCSS += '   lastButtonStyleName: "my'+whichItem+'LastButtonStyle";\n';
			myCSS += '   selectedButtonTextStyleName: "my'+whichItem+'SelectedButtonStyle";\n';
			myCSS += '}\n\n.my'+whichItem+'ButtonStyle {\n' 
			+ this['csshighlightAlphas']
			+ this['cssfillAlphas'] + this['cssfillColors']
			+ this['csscolor'] + this['csstextRollOverColor'] + this['csstextSelectedColor']
			+ this['cssborderColor'] + this['cssthemeColor']
			+ this['cssfontFamily'] + this['cssfontSize']
			+ this['cssfontWeight'] + this['cssfontStyle']
			+ this['csstextDecoration'];
			myCSS += '}\n\n.my'+whichItem+'FirstButtonStyle {\n' 
			+ this['csscornerRadiusLeft'];
			myCSS += '}\n\n.my'+whichItem+'LastButtonStyle {\n' 
			+ this['csscornerRadiusRight'];
			myCSS += '}\n\n.my'+whichItem+'SelectedButtonStyle {\n' 
			+ this['cssselectedcolor']
			+ this['cssselectedfontFamily']
			+ this['cssselectedfontSize']
			+ this['cssselectedfontWeight']
			+ this['cssselectedfontStyle']
			+ this['cssselectedtextDecoration'];
		}
	}
	
	
	//Label Style name for sliders,
	if (whichItem == 'vSlider' || whichItem == 'hSlider') {
		if (this['csscolor'] != '' 
			|| this['cssfontFamily'] != '' || this['cssfontSize'] != ''
			|| this['cssfontWeight'] != '' || this['cssfontStyle'] != ''
			|| this['csstextDecoration'] != '' || this['cssletterSpacing'] != '') {
			myCSS += '   labelStyleName: "my'+whichItem+'LabelStyle";\n}\n\n.my'+whichItem+'LabelStyle {\n' 
			+ this['cssletterSpacing'] + this['csscolor']
			+ this['cssfontFamily'] + this['cssfontSize']
			+ this['cssfontWeight'] + this['cssfontStyle']
			+ this['csstextDecoration'];
		}
	}
	
	//headerStyleName for DataGrid
	if (whichItem == 'dataGrid') {
		
		if (this['cssheaderColor'] != '' || this['cssheaderfontFamily'] != '' || this['cssheaderletterSpacing'] != ''
		|| this['cssheaderfontWeight'] != '' || this['cssheaderfontSize'] != ''
		|| this['cssheaderfontStyle'] != '' || this['cssheadertextDecoration'] != ''  || this['cssheadertextAlign'] != '' ) {
			myCSS += '   headerStyleName: "my'+whichItem+'HeaderStyle";\n}\n\n.my'+whichItem+'HeaderStyle {\n' 
			+ this['cssheaderColor'] + this['cssheaderfontFamily'] + this['cssheaderfontWeight']
			+ this['cssheaderfontSize'] + this['cssheaderfontStyle'] + this['cssheadertextDecoration']
			+ this['cssheaderletterSpacing'] + this['cssheadertextAlign'];
		}
	}
	//stylenames for datechooser
	if (whichItem == 'dateChooser') {
		
		if (this['cssheadercolor'] != '' || this['cssheaderfontFamily'] != ''
		|| this['cssheaderfontSize'] != '' || this['cssheaderfontSize'] != ''
		|| this['cssheaderfontStyle'] != '' || this['cssheadertextDecoration'] != '' ) {
		
			myCSS += '   headerStyleName: "my'+whichItem+'HeaderStyle";';
		
		}
		
		if (this['cssweekDaycolor'] != '' || this['cssweekDayfontFamily'] != ''
		|| this['cssweekDayfontSize'] != '' || this['cssweekDayfontSize'] != ''
		|| this['cssweekDayfontStyle'] != '' || this['cssweekDaytextDecoration'] != '' ) {
			
			myCSS += '   weekDayStyleName: "my'+whichItem+'WeekDayStyle";';
		
		}
		
		
		if (this['csstodaytextcolor'] != '' || this['csstodayfontFamily'] != ''
		|| this['csstodayfontSize'] != '' || this['csstodayfontSize'] != ''
		|| this['csstodayfontStyle'] != '' || this['csstodaytextDecoration'] != '' ) {
			
			myCSS += '   todayStyleName: "my'+whichItem+'TodayStyle";';
		
		}
		//------
		
		
		if (this['cssheadercolor'] != '' || this['cssheaderfontFamily'] != ''
		|| this['cssheaderfontSize'] != '' || this['cssheaderfontSize'] != ''
		|| this['cssheaderfontStyle'] != '' || this['cssheadertextDecoration'] != '' ) {
		
			myCSS += '\n}\n\n.my'+whichItem+'HeaderStyle {\n' 
			+ this['cssheadercolor'] + this['cssheaderfontFamily'] + this['cssheaderfontWeight']
			+ this['cssheaderfontSize'] + this['cssheaderfontStyle'] + this['cssheadertextDecoration'];
		
		}
		
		if (this['cssweekDaycolor'] != '' || this['cssweekDayfontFamily'] != ''
		|| this['cssweekDayfontSize'] != '' || this['cssweekDayfontSize'] != ''
		|| this['cssweekDayfontStyle'] != '' || this['cssweekDaytextDecoration'] != '' ) {
			
			myCSS += '\n}\n\n.my'+whichItem+'WeekDayStyle {\n' 
			+ this['cssweekDaycolor'] + this['cssweekDayfontFamily'] + this['cssweekDayfontWeight']
			+ this['cssweekDayfontSize'] + this['cssweekDayfontStyle'] + this['cssweekDaytextDecoration'];
		}
		
		
		if (this['csstodaytextcolor'] != '' || this['csstodayfontFamily'] != ''
		|| this['csstodayfontSize'] != '' || this['csstodayfontSize'] != ''
		|| this['csstodayfontStyle'] != '' || this['csstodaytextDecoration'] != '' ) {
			
			myCSS += '\n}\n\n.my'+whichItem+'TodayStyle {\n' 
			+ this['csstodaytextcolor'] + this['csstodayfontFamily'] + this['csstodayfontWeight']
			+ this['csstodayfontSize'] + this['csstodayfontStyle'] + this['csstodaytextDecoration'];
		}
	}
	
	
	myCSS += "}"; 
	
	
}

public function restoreItemDefaults(whichItem:String):void {
	
	//--------- CLEAR STYLES IN SANDBOX
	
	for (var i:Number = 0; i < this[whichItem + 'Styles'].length; i++) {
		if (whichItem == 'tab') {
			if (this['css' + this[whichItem + 'Styles'][i] + 'tab' ] != '') {
				StyleManager.getStyleDeclaration(".StyledTabs").clearStyle(this[whichItem + 'Styles'][i]);
				this['css' + this[whichItem + 'Styles'][i] + 'tab'] = "";
				if (this[whichItem + 'Styles'][i] == 'fontWeight' ||
					this[whichItem + 'Styles'][i] == 'fontStyle' ||
					this[whichItem + 'Styles'][i] == 'textDecoration') {
						this['mytextFormat' + whichItem].restoreDefault();
				
				} else {
					this['my' + this[whichItem + 'Styles'][i] + whichItem].restoreDefault();
				}
				
			}
		} else if (whichItem == 'selectedTab'){
			if (this['css' + this[whichItem + 'Styles'][i] + 'selectedTab' ] != '') {
				StyleManager.getStyleDeclaration(".SelectedStyledTabs").clearStyle(this[whichItem + 'Styles'][i]);
				this['css' + this[whichItem + 'Styles'][i] + 'selectedTab'] = "";
				if (this[whichItem + 'Styles'][i] == 'fontWeight' ||
					this[whichItem + 'Styles'][i] == 'fontStyle' ||
					this[whichItem + 'Styles'][i] == 'textDecoration') {
						this['mytextFormat' + whichItem].restoreDefault();
				
				} else {
					this['my' + this[whichItem + 'Styles'][i] + whichItem].restoreDefault();
				}
			}
		} else if (whichItem == 'dropDown') {
			if (this['css' + this[whichItem + 'Styles'][i] + 'dropDown' ] != '') {
				StyleManager.getStyleDeclaration(".DropDownStyles").clearStyle(this[whichItem + 'Styles'][i]);
				if (this[whichItem + 'Styles'][i] == 'dropShadowEnabled') {
					StyleManager.getStyleDeclaration(".DropDownStyles").setStyle('dropShadowEnabled', true);
				}
				this['css' + this[whichItem + 'Styles'][i] + 'dropDown'] = "";
				if (this[whichItem + 'Styles'][i] == 'fontWeight' ||
					this[whichItem + 'Styles'][i] == 'fontStyle' ||
					this[whichItem + 'Styles'][i] == 'textDecoration') {
						this['mytextFormat' + whichItem].restoreDefault();
				
				} else {
					this['my' + this[whichItem + 'Styles'][i] + whichItem].restoreDefault();	
				}
			}
		}  else {
		
		
		if (this['css' + this[whichItem + 'Styles'][i] ] != '') {
			
			if (whichItem == 'toolTip') {
				StyleManager.getStyleDeclaration("ToolTip").clearStyle(this[whichItem + 'Styles'][i]);	
			} else if (whichItem == 'application') {
				StyleManager.getStyleDeclaration("Application").clearStyle(this[whichItem + 'Styles'][i]);
				this['myapplication'].clearStyle('color');
				this['myapplication'].clearStyle('themeColor');
			} else {
				this['my' + whichItem].clearStyle(this[whichItem + 'Styles'][i]);
			}
			
			if (whichItem == 'radioButton' || whichItem == 'checkBox') {
				this['my' + whichItem + "1"].clearStyle(this[whichItem + 'Styles'][i]);	
				this['my' + whichItem + "2"].clearStyle(this[whichItem + 'Styles'][i]);	
			}
			
			if(this[whichItem + 'Styles'][i] == 'tabHeight') {
				this['my' + whichItem].setStyle('tabHeight', 22);
			}
			
			if (whichItem == 'panel') {
				if (this[whichItem + 'Styles'][i] == 'fontWeight' && this['cssfontWeight'] != "") {
					StyleManager.getStyleDeclaration(".myTitleStyle").clearStyle('fontWeight');
				}
				if (this[whichItem + 'Styles'][i] == 'fontStyle' && this['cssfontStyle'] != "") {
					StyleManager.getStyleDeclaration(".myTitleStyle").clearStyle('fontStyle');
				}
				if (this[whichItem + 'Styles'][i] == 'textDecoration' && this['csstextDecoration'] != "") {
					StyleManager.getStyleDeclaration(".myTitleStyle").clearStyle('textDecoration');
				}
			}
			
			if (whichItem == 'dataGrid') {
				if (this[whichItem + 'Styles'][i] == 'headerColor' && this['cssheaderColor'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('color');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontFamily' && this['cssheaderfontFamily'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('fontFamily');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontSize' && this['cssheaderfontSize'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('fontSize');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontWeight' && this['cssheaderfontWeight'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").setStyle('fontWeight', 'bold');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontStyle' && this['cssheaderfontStyle'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('fontStyle');
				}
				if (this[whichItem + 'Styles'][i] == 'headertextDecoration' && this['cssheadertextDecoration'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('textDecoration');
				}
				if (this[whichItem + 'Styles'][i] == 'headerletterSpacing' && this['cssheaderletterSpacing'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('letterSpacing');
				}
				if (this[whichItem + 'Styles'][i] == 'headertextAlign' && this['cssheadertextAlign'] != "") {
					StyleManager.getStyleDeclaration(".DGHeaderStyle").clearStyle('textAlign');
				}
			}
			//toggleButtonBar
			if (whichItem == 'toggleButtonBar') {
				if (this[whichItem + 'Styles'][i] == 'selectedcolor' && this['cssselectedcolor'] != "") {
					StyleManager.getStyleDeclaration(".mySelectedButtonStyle").clearStyle('color');
				}
				if (this[whichItem + 'Styles'][i] == 'selectedfontFamily' && this['cssselectedfontFamily'] != "") {
					StyleManager.getStyleDeclaration(".mySelectedButtonStyle").clearStyle('fontFamily');
				}
				if (this[whichItem + 'Styles'][i] == 'selectedfontSize' && this['cssselectedfontSize'] != "") {
					StyleManager.getStyleDeclaration(".mySelectedButtonStyle").clearStyle('fontSize');
				}
				if (this[whichItem + 'Styles'][i] == 'selectedfontWeight' && this['cssselectedfontWeight'] != "") {
					StyleManager.getStyleDeclaration(".mySelectedButtonStyle").clearStyle('fontWeight');
				}
				if (this[whichItem + 'Styles'][i] == 'selectedfontStyle' && this['cssselectedfontStyle'] != "") {
					StyleManager.getStyleDeclaration(".mySelectedButtonStyle").clearStyle('fontStyle');
				}
				if (this[whichItem + 'Styles'][i] == 'selectedtextDecoration' && this['cssselectedtextDecoration'] != "") {
					StyleManager.getStyleDeclaration(".mySelectedButtonStyle").clearStyle('textDecoration');
				}
				
			}
			
			// dateChooser
			if (whichItem == 'dateChooser') {
				if (this[whichItem + 'Styles'][i] == 'headercolor' && this['cssheadercolor'] != "") {
					StyleManager.getStyleDeclaration(".HeaderStyle").clearStyle('color');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontFamily' && this['cssheaderfontFamily'] != "") {
					StyleManager.getStyleDeclaration(".HeaderStyle").clearStyle('fontFamily');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontSize' && this['cssheaderfontSize'] != "") {
					StyleManager.getStyleDeclaration(".HeaderStyle").clearStyle('fontSize');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontWeight' && this['cssheaderfontWeight'] != "") {
					StyleManager.getStyleDeclaration(".HeaderStyle").setStyle('fontWeight', 'bold');
				}
				if (this[whichItem + 'Styles'][i] == 'headerfontStyle' && this['cssheaderfontStyle'] != "") {
					StyleManager.getStyleDeclaration(".HeaderStyle").clearStyle('fontStyle');
				}
				if (this[whichItem + 'Styles'][i] == 'headertextDecoration' && this['cssheadertextDecoration'] != "") {
					StyleManager.getStyleDeclaration(".HeaderStyle").clearStyle('textDecoration');
				}
				
				if (this[whichItem + 'Styles'][i] == 'weekDaycolor' && this['cssweekDaycolor'] != "") {
					StyleManager.getStyleDeclaration(".myWeekDayStyleName").clearStyle('color');
				}
				if (this[whichItem + 'Styles'][i] == 'weekDayfontFamily' && this['cssweekDayfontFamily'] != "") {
					StyleManager.getStyleDeclaration(".myWeekDayStyleName").clearStyle('fontFamily');
				}
				if (this[whichItem + 'Styles'][i] == 'weekDayfontSize' && this['cssweekDayfontSize'] != "") {
					StyleManager.getStyleDeclaration(".myWeekDayStyleName").clearStyle('fontSize');
				}
				if (this[whichItem + 'Styles'][i] == 'weekDayfontWeight' && this['cssweekDayfontWeight'] != "") {
					StyleManager.getStyleDeclaration(".myWeekDayStyleName").setStyle('fontWeight', 'bold');
				}
				if (this[whichItem + 'Styles'][i] == 'weekDayfontStyle' && this['cssweekDayfontStyle'] != "") {
					StyleManager.getStyleDeclaration(".myWeekDayStyleName").clearStyle('fontStyle');
				}
				if (this[whichItem + 'Styles'][i] == 'weekDaytextDecoration' && this['cssweekDaytextDecoration'] != "") {
					StyleManager.getStyleDeclaration(".myWeekDayStyleName").clearStyle('textDecoration');
				}
				
				if (this[whichItem + 'Styles'][i] == 'todaytextcolor' && this['csstodaytextcolor'] != "") {
					StyleManager.getStyleDeclaration(".myTodayStyleName").clearStyle('color');
				}
				if (this[whichItem + 'Styles'][i] == 'todayfontFamily' && this['csstodayfontFamily'] != "") {
					StyleManager.getStyleDeclaration(".myTodayStyleName").clearStyle('fontFamily');
				}
				if (this[whichItem + 'Styles'][i] == 'todayfontSize' && this['csstodayfontSize'] != "") {
					StyleManager.getStyleDeclaration(".myTodayStyleName").clearStyle('fontSize');
				}
				if (this[whichItem + 'Styles'][i] == 'todayfontWeight' && this['csstodayfontWeight'] != "") {
					StyleManager.getStyleDeclaration(".myTodayStyleName").setStyle('fontWeight', 'bold');
				}
				if (this[whichItem + 'Styles'][i] == 'todayfontStyle' && this['csstodayfontStyle'] != "") {
					StyleManager.getStyleDeclaration(".myTodayStyleName").clearStyle('fontStyle');
				}
				if (this[whichItem + 'Styles'][i] == 'todaytextDecoration' && this['csstodaytextDecoration'] != "") {
					StyleManager.getStyleDeclaration(".myTodayStyleName").clearStyle('textDecoration');
				}
			}
			
			
			
			if (whichItem == 'buttonBar' || whichItem == 'toggleButtonBar') {
				if (this[whichItem + 'Styles'][i] == 'cornerRadiusRight' || this[whichItem + 'Styles'][i] == 'cornerRadiusLeft') {
					for (var j:Number = 0; j < 3; j ++) { 
						this['my' + whichItem].getChildAt(j).clearStyle('cornerRadius');
					}	
				} else {
					for (j = 0; j < 3; j ++) { 
						this['my' + whichItem].getChildAt(j).clearStyle(this[whichItem + 'Styles'][i]);
					}	
				}
				if (this[whichItem + 'Styles'][i] == 'buttonHeight') {
					this['my' + whichItem].setStyle('buttonHeight', 22);
				}
			}
			
			
			//------------------- RESTORE DEFAULT VALUES ON COMPONENTS
			
			if (this[whichItem + 'Styles'][i] == 'fontWeight' ||
				this[whichItem + 'Styles'][i] == 'fontStyle' ||
				this[whichItem + 'Styles'][i] == 'textDecoration') {
					this['mytextFormat' + whichItem].restoreDefault();
			
			} else if (this[whichItem + 'Styles'][i] == 'headerfontWeight' ||
				this[whichItem + 'Styles'][i] == 'headerfontStyle' ||
				this[whichItem + 'Styles'][i] == 'headertextDecoration') {
					this['myheadertextFormat' + whichItem].restoreDefault();
			
			} else if (this[whichItem + 'Styles'][i] == 'todayfontWeight' ||
				this[whichItem + 'Styles'][i] == 'todayfontStyle' ||
				this[whichItem + 'Styles'][i] == 'todaytextDecoration') {
					this['mytodaytextFormat' + whichItem].restoreDefault();
			
			}  else if (this[whichItem + 'Styles'][i] == 'selectedfontWeight' ||
				this[whichItem + 'Styles'][i] == 'selectedfontStyle' ||
				this[whichItem + 'Styles'][i] == 'selectedtextDecoration') {
					this['myselectedtextFormat' + whichItem].restoreDefault();
			
			} else if (this[whichItem + 'Styles'][i] == 'weekDayfontWeight' ||
				this[whichItem + 'Styles'][i] == 'weekDayfontStyle' ||
				this[whichItem + 'Styles'][i] == 'weekDaytextDecoration') {
					this['myweekDaytextFormat' + whichItem].restoreDefault();
			
			} else if (this[whichItem + 'Styles'][i] == 'borderThicknessRight' ||
						this[whichItem + 'Styles'][i] == 'borderThicknessLeft' ||
						this[whichItem + 'Styles'][i] == 'borderThicknessTop' ||
						this[whichItem + 'Styles'][i] == 'borderThicknessBottom' ) {
							this['myborderThicknesses' + whichItem].restoreDefault();		
			} else if (this[whichItem + 'Styles'][i] == 'backgroundSize' ||
				this[whichItem + 'Styles'][i] == 'backgroundImage') {
			 	this['mybackgroundImageapplication'].selectedIndex = 0;
			 } else {
			this['my' + this[whichItem + 'Styles'][i] + whichItem].restoreDefault();
			}		
			
			//----------------- SET THE CSS VALUE TO EMPTY
			
			this['css' + this[whichItem + 'Styles'][i]] = "";	
			
			}	
		}
	}
	//----------------- CLEAR THE CSS TEXT FIELD
	
	myCSS = ''; 
	
} 
