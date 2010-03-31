In this directory you'll find files that will allow you set up a 
Java/JUnit/Spring test framework for the SeleniumFlex API. These 
files are:

- the driver extension class “DefaultSeleniumFlex.java”. This will 
	enable your tests to call SelniumFlex API calls through Selenium 
	to your application,
- SeleniumFlexTestCase.java is an example of a base class to 
	extend your test cases with. It also has code to load a properties 
	file usig Spring from your applicationContext.xml file. 
	This is extremely useful for setting up your framework to work 
	with different environment configurations and also environment 
	specific test data.
- LoginRegTest.java is an example of JUnit test case that you can write.

