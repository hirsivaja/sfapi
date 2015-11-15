# sfapi
Selenium-Flex API originally found from https://code.google.com/p/sfapi/

Selenium-Flex API or sfapi for short is used to automate testing of Adobe Flex applications.
Steps:
  1. Build the .swc with maven using the pom.xml
  2. Build your Flex application and include the library build in step 1
    - With: -include-libraries "..\libs\sfapi.swc" or using right-click "Add to library" on FlashDevelop
  3. Use JavaScript to issue commands to the Flex application. See https://github.com/hirsivaja/FlexSeleniumLibrary
  
The Flex3Tester project found under test/Flex3Tester can be used to test the library.
  1. Build the project with FlashDevelop or FlashBuilder
  2. Remember to add the modified library to libs folder and take it into use
  3. Deploy the .swf to a web server. You can use for example Jetty http://download.eclipse.org/jetty/
  4. Run tests from https://github.com/hirsivaja/FlexSeleniumLibrary/tree/master/test/unit or make your own
