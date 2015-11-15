# sfapi
Selenium-Flex API originally found from https://code.google.com/p/sfapi/

Selenium-Flex API or sfapi for short is used to automate testing of Adobe Flex applications.
Steps:
  1. Build the .swc with maven using the pom.xml
  2. Build your Flex application and include the library build in step 1
    - With: -include-libraries "..\libs\sfapi.swc" or using right-click "Add to library" on FlashDevelop
  3. Use JavaScript to issue commands to the Flex application. See https://github.com/hirsivaja/FlexSeleniumLibrary
