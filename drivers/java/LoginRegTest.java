package au.com.transurban.retailweb.regression.tests;

import static org.junit.Assert.assertTrue;
import junit.framework.AssertionFailedError;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import au.com.transurban.retailweb.regression.DefaultSeleniumFlex;
import au.com.transurban.retailweb.regression.SeleniumFlexTestCase;

public class LoginRegTest extends SeleniumFlexTestCase {
	private DefaultSeleniumFlex selenium;
	
	@Before
	public void setUp() throws Exception 
	{
		selenium = getDefaultSeleniumFlex();
        selenium.start();
    }
	
	@After
	public void tearDown() throws Exception 
	{
		selenium.stop();
    }
    
	@Test
    public void testLogin() 
	{
    	try	{
    		
			selenium.flexType("loginIDInput", "hello");
			selenium.flexType("pinInput", "world");
			selenium.flexClick("loginBtn");
			waitForFlexVisible("consumerMenuBar", 20, selenium);
				
			// check the labels on the landing page
			assertTrue(selenium.getFlexText("_AccountDetailsView_Label2") == getData("LoginRegTest.accountNumber"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_Text2") == getData("LoginRegTest.customer"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_Text4") == getData("LoginRegTest.accountOpeningDate"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_Text5") == getData("LoginRegTest.ongoingPaymentMethod"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_deliveryMethod") == getData("LoginRegTest.statementDeliveryMethod"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_Text9") == getData("LoginRegTest.statementType"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_deliveryCycleId") == getData("LoginRegTest.billingFrequency"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_Text19") == getData("LoginRegTest.product"));
			assertTrue(selenium.getFlexText("_AccountDetailsView_Text21") == getData("LoginRegTest.paymentMethod"));
			
		} catch (Exception e) {
			System.err.println("\nTest BuyPassTest FAILED (" + e.getMessage() + ")");
			throw new AssertionFailedError();
		}
    }
}
