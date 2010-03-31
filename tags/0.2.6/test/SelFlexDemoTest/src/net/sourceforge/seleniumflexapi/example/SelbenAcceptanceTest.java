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

import java.util.Calendar;
import java.util.GregorianCalendar;

import net.sourceforge.seleniumflexapi.AcceptanceTestBase;

import org.junit.Before;
import org.junit.Test;


/**
 * Demonstrates use of SeleniumFlexAPI to write acceptance tests for a Flex app.
 * Also acts as a test for SeleniumFlexAPI itself.
 * 
 * @author Julia Dain
 *
 */
public class SelbenAcceptanceTest extends AcceptanceTestBase {

	private SelbenPageDriver driver; 

	@Test
	public void testTextInput() {
		driver.enterNumber("12");		
		driver.enterFactor("4");
		driver.checkResult("48");

		driver.enterNumber("222222");
		driver.enterFactor("2");
		driver.checkResult("444444");
		
		driver.enterNumber("0");
		driver.checkResult("0");
		
		driver.enterNumber("-3");
		driver.checkResult("-6");
	}

	@Test
	public void testButton() {
		for (int i = 1; i < 6; i++) {
			driver.clickButton();
			driver.checkButtonText(String.format("pushed %d time%s",
					i, (i == 1 ? "" : "s")));
		}
	}
	
	@Test
	public void testComboBox() {
		driver.selectFruit("banana");
		driver.checkFruitText("bananas are yellow");

		driver.selectFruit("apple");
		driver.checkFruitText("apples are green");
	}
	
	@Test
	public void testSetFocus() {
		driver.focusOnNumber();
		driver.focusOnFactor();
	}
	
	@Test
	public void testCheckbox() {
		driver.selectCheck();
		driver.checkCheckSelected();
		driver.checkCheckText("checked");
		
		driver.deselectCheck();
		driver.checkCheckDeselected();
		driver.checkCheckText("not checked");
	}
	
	@Test
	public void testDate() {
		Calendar date = new GregorianCalendar();
		date.set(Calendar.MONTH, Calendar.DECEMBER);
		date.add(Calendar.DAY_OF_MONTH, 1);
		driver.enterDate(date);
		driver.checkDate(date);
	}
	
	@Test 
	public void testDataGrid() {
		driver.checkGridContents();
		driver.checkGridLabelText("Choose more fruit");
		
		driver.selectFruitInGrid("grape");
		driver.checkGridLabelText("grapes are purple");
		
		driver.selectFruitInGrid("banana");
		driver.checkGridLabelText("bananas are yellow");
	}
	
	@Test
	public void testTab() {
		driver.selectTab("Fruit");
		driver.checkFruitTab();
		driver.selectTab("Cheese");
		driver.checkCheeseTab();
		driver.selectCheeseOrApple("Cheddar");
		driver.checkCheeseText("Cheddar");
	}
	
	@Test
	public void testRadio() {
		driver.selectTab("Fruit");
		driver.selectCheeseOrApple("Cox");
		driver.checkAlert(true);
		driver.closeAlert();
		driver.checkAlert(false);
	}
	
	@Before
	public void setUpPageDriver() {
		driver = new SelbenPageDriver(getFlashApp());
		driver.navigateToPage();
	}
}
