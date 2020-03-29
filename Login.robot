*** Settings ***
Library   

*** Variables ***
${browser}           chrome
${url}               http://the-internet.herokuapp.com/login
@{username}          tomsmith   tomholland
@{password}          SuperSecretPassword!     Password!
@{expected Result}   You logged into a secure area!   You logged out of the secure area!   Your password is invalid!   Your username is invalid!

*** Keywords ***
Open herokuapp
   Open Browser   ${url}   ${browser}
Click on Login Button
   Click Element   xpath=//*[@id="login"]/button
Click on Logout Button
   Click Element   xpath=//*[@id="content"]/div/a/i
Input valid Username
   Input Text   id=username   @{username}[0]
Input invalid Username
   Input Text   id=username   @{username}[1]	 
Input valid Password
   Input Password   id=password   @{password}[0]		
Input invalid Password
   Input Password   id=password   @{password}[1]	
Verify Login Success Message
   Wait Until Page Contains    @{expected_result}[0]
Verify Logout Message
   Wait Until Page Contains    @{expected_result}[1]
Verify Invalid Password Message
   Wait Until Page Contains    @{expected_result}[2]
Verify Invalid Username Message
   Wait Until Page Contains    @{expected_result}[3]
   
*** Test Cases ***
Case 1 Login Success
   Open herokuapp
   Input valid Username
   Input valid Password
   Click on Login Button
   Verify Login Success Message
   Click on Logout Button
   Verify Logout Message
   Close Browser
   
Case 2 Login Failed with Invalid Password
   Open herokuapp
   Input valid Username
   Input invalid Password
   Click on Login Button
   Verify Invalid Password Message
   Close Browser
   
Case 3 Login Failed with Invalid Username
   Open herokuapp
   Input invalid Username
   Input valid Password
   Click on Login Button
   Verify Invalid Username Message
   Close Browser
 

