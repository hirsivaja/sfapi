/*	
 *	License
 *	
 *	This file is part of The SeleniumFlex-API.
 *	
 *	The SeleniumFlex-API is free software: you can redistribute it and/or
 *  modify it  under  the  terms  of  the  GNU  General Public License as 
 *  published  by  the  Free  Software Foundation,  either  version  3 of 
 *  the License, or any later version.
 *
 *  The SeleniumFlex-API is distributed in the hope that it will be useful,
 *  but  WITHOUT  ANY  WARRANTY;  without  even the  implied  warranty  of
 *  MERCHANTABILITY   or   FITNESS   FOR  A  PARTICULAR  PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with The SeleniumFlex-API.
 *	If not, see http://www.gnu.org/licenses/
 *
 */
 
 /*   Contributed by Black Pepper Software Ltd.  */
 
 
package net.sourceforge.seleniumflexapi.example;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import net.sourceforge.seleniumflexapi.AbstractPageDriver;
import net.sourceforge.seleniumflexapi.FlexSelenium;

import org.junit.Assert;


public class SelbenPageDriver extends AbstractPageDriver {
	
	private static final String VEG_TAB_TEXT_ID = "vegTabText";
	private static final String CHEESE_TAB_TEXT_ID = "cheeseTabText";
	private static final String FRUIT_TAB_TEXT_ID = "fruitTabText";
	private static final String CHEESE_TAB_LABEL = "Cheese";
	private static final String FRUIT_TAB_LABEL = "Fruit";
	private static final String TABS_ID = "tabs";
	private static final String SELBEN_FORM_ID = "selbenForm";
	private static final String NUMBER_FIELD_ID = "num";
	private static final String FACTOR_FIELD_ID = "factor";
	private static final String RESULT_FIELD_ID = "result";
	private static final String CHECKBOX_ID = "checkBox";
	private static final String DATE_FIELD_ID = "date";
	private static final String DATE_LABEL_FIELD_ID = "dateLabel";
	private static final String DATA_GRID_ID = "dataGrid";
	private static final int APP_LOAD_TIMEOUT_MS = 30000;
	
	public SelbenPageDriver(FlexSelenium flashApp) {
		super(flashApp);
	}
	
	public void navigateToPage() {
		final long timeoutPoint = System.currentTimeMillis() + APP_LOAD_TIMEOUT_MS;
		while (timeoutPoint > System.currentTimeMillis()) {
			try {
				if (getFlexSelenium().isVisible(SELBEN_FORM_ID)) {
					return;
				}
				Thread.sleep(250);
			} catch (Exception e) {
				// Ignore this, we are just waiting for the app to load
			}
		}
		Assert.fail("Application did not load");
	}
	
	public void enterNumber(final String number) {
		enterText(NUMBER_FIELD_ID, number);
	}
	
	public void enterFactor(final String number) {
		enterText(FACTOR_FIELD_ID, number);
	}
	
	public void checkResult(final String number) {
		ensureWidgetHasText(RESULT_FIELD_ID, "The result is " + number);
	}

	public void clickButton() {
		clickButton("button");
	}

	public void checkButtonText(final String string) {
		ensureWidgetHasText("buttonClicks", string);
	}

	public void selectFruit(final String fruit) {
		selectComboItem("combo", fruit);
	}

	public void checkFruitText(final String string) {
		ensureWidgetHasText("comboQuote", string);
	}
	
	public void focusOnNumber() {
		setFocus(NUMBER_FIELD_ID);
	}
	
	public void focusOnFactor() {
		setFocus(FACTOR_FIELD_ID);
	}
	
	public void selectCheck() {
		setCheckBoxState(CHECKBOX_ID, true);
	}
	
	public void checkCheckSelected() {
		ensureCheckBoxState(CHECKBOX_ID, true);
	}
	
	public void deselectCheck() {
		setCheckBoxState(CHECKBOX_ID, false);
	}
	
	public void checkCheckDeselected() {
		ensureCheckBoxState(CHECKBOX_ID, false);
	}
	
	public void checkCheckText(final String string) {
		ensureWidgetHasText("checkBoxLabel", string);
	}
	
	public void enterDate(final Calendar date) {
		enterDate(DATE_FIELD_ID, date, "dd/MM/yyyy");
	}
	
	public void checkDate(final Calendar date) {
		ensureWidgetHasDate(DATE_FIELD_ID, date, "dd/MM/yyyy");
		SimpleDateFormat formatter = new SimpleDateFormat("dd/M/yyyy");
		ensureWidgetHasText(DATE_LABEL_FIELD_ID, "you chose " + formatter.format(date.getTime()));
	}
	
	public void checkGridContents() {
		ensureDataGridPopulated(DATA_GRID_ID);
		ensureDataGridRowCount(DATA_GRID_ID, 3);
		ensureDataGridRowValue(DATA_GRID_ID, 0, "name", "apple");
		ensureDataGridRowLabel(DATA_GRID_ID, 0, "name", "apple");
		ensureDataGridRowValue(DATA_GRID_ID, 0, "colour", "green");
		ensureDataGridRowValue(DATA_GRID_ID, 1, "name", "banana");
		ensureDataGridRowValue(DATA_GRID_ID, 1, "colour", "yellow");
	}
	
	public void selectFruitInGrid(final String fruit) {
		selectByFieldValue(DATA_GRID_ID, "name", fruit);	
	}
	
	public void checkGridLabelText(final String text) {
		ensureWidgetHasText("dataGridLabel", text);
	}
	
	public void selectTab(final String tabTitle) {
		selectTab(TABS_ID, tabTitle);
	}
	
	public void checkFruitTab() {
		ensureTabEnabled(TABS_ID, FRUIT_TAB_LABEL, true);	
		ensureTabEnabled(TABS_ID, CHEESE_TAB_LABEL, true);
		ensureWidgetVisibility(FRUIT_TAB_TEXT_ID, true);
		ensureWidgetVisibility(CHEESE_TAB_TEXT_ID, false);
		ensureWidgetVisibility(VEG_TAB_TEXT_ID, false);
	}
	
	public void checkCheeseTab() {
		ensureTabEnabled(TABS_ID, FRUIT_TAB_LABEL, true);	
		ensureTabEnabled(TABS_ID, CHEESE_TAB_LABEL, true);
		ensureWidgetVisibility(CHEESE_TAB_TEXT_ID, true);
		ensureWidgetHasText(CHEESE_TAB_TEXT_ID, "Choose cheese");
	}
	
	public void selectCheeseOrApple(final String name) {
		clickButton(name);
	}
	
	public void checkCheeseText(final String cheese) {
		ensureWidgetHasText(CHEESE_TAB_TEXT_ID, "you chose " + cheese);
	}
	
	public void checkAlert(final boolean visible) {
		ensureAlertVisibility(visible);	
	}
	
	public void closeAlert() {
		closeAlert("OK");
	}
}
