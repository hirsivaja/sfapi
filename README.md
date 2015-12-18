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
  4. Copy the files from assets folder to the folder as the .swf on the server
  5. Run tests from https://github.com/hirsivaja/FlexSeleniumLibrary/tree/master/test/unit or make your own

The Flex4Tester project found under test/Flex4Tester can be used to test the library.in the same way. Flex4Tester also
supports FlexPilot (https://github.com/mde/flex-pilot). Make sure to copy FlexPilot-4-stable.swf into the web server in
the same folder as Flex4Tester. This can be found from the assets folder and https://github.com/mde/flex-pilot/downloads

The API documentation can be found from: http://hirsivaja.github.io/sfapi/
