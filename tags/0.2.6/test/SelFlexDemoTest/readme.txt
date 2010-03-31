
What is this
------------
This project demonstrates how to automate acceptance or functional testing of a 
web application with a Flex front end.

Acceptance tests are written in Java and utilize the Selenium framework. 
For more on why you would want to do this and how, see my blog entry
http://www.blackpepper.co.uk/black-pepper-blog/Flex-acceptance-testing-and-continuous-integration.html

This project contains an example of JUnit acceptance tests for a Flex app.
The Flex app under test is contained in a separate project, selben.
Selben is not a webapp as such (no backend), just a really tiny dumb piece of Flex.

Pre-requisites
--------------
Java		
Tomcat
Selenium Remote Control
Flex SDK
Web browser + Flash plugin

Tested with JDK 1.6, Tomcat 5.5.26, Selenium RC 1.0 beta 1, Flex 3 SDK, Firefox 3.0.5,
Selenium Flex API v0.2.4

Run the tests
-------------
Tests can be run with ant or from inside Eclipse. 

First deploy the Flex app. See the selben project for how to do this.

Check that the test.properties file contains values that are valid for your environment.

Start the Selenium server:
	ant selenium-start
	
Run the test:
	ant
Or run the test as a JUnit test from within Eclipse.

----------------------------------------------

Julia Dain        Black Pepper Software Ltd         julia.dain@blackpepper.co.uk

