
What is this
------------
This project contains a small example Flex app.
The app is used by the project selbentest which demonstrates how
to automate acceptance or functional testing of a 
web application with a Flex front end (this is the front end,
but in this example there is no back end).

Acceptance tests in selbentest are written in Java and utilize the Selenium framework. 
For more on why you would want to do this and how, see my blog entry
http://www.blackpepper.co.uk/black-pepper-blog/Flex-acceptance-testing-and-continuous-integration.html

Pre-requisites
--------------
Java		
Tomcat
Selenium Remote Control
Flex SDK
Web browser + Flash plugin

Tested with JDK 1.6, Tomcat 5.5.26, Selenium RC 1.0 beta 1, Flex 3 SDK, Firefox 3.0.9

Build and deploy the selben app
-------------------------------
First create a properties file selben.properties in your home directory, with entries for tomcat.home and FLEX_HOME.
...example:
tomcat.home=/opt/apache-tomcat-5.5.26
FLEX_HOME=/opt/flex3/sdk3

Build and deploy with ant:
	ant deploy
	ant tomcat-start

----------------------------------------------

Julia Dain        Black Pepper Software Ltd         julia.dain@blackpepper.co.uk
April 2009

