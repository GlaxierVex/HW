*** Settings ***
Resource     ../Resources/UI_Resources.robot

Variables    ../UI_Test_Settings.yaml

*** Variables ***
${common_timeout}       10

*** Keywords ***
Open browser to page
    [Arguments]    ${url}    ${speed}=0.1 
    ${options}=     Evaluate     sys.modules['selenium.webdriver'].ChromeOptions()     sys
    ${exclude}=     Create Dictionary    "fasp"=True
    ${prefs}=       Create Dictionary    protocol_handler.excluded_schemes=${exclude}
    Call Method     ${options}    add_argument     --disable-infobars
    Call Method     ${options}    add_argument    --disable-notifications
    Call Method     ${options}    add_experimental_option    prefs    ${prefs}
    SeleniumLibrary.Create WebDriver         Chrome      chrome_options=${options}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Speed              ${speed}
    SeleniumLibrary.Go To                           ${url}

End Test Case
    Close Browser
    log to console          Ending

Common Click Element
    [Arguments]     ${element}      ${timeout}=${common_timeout}
    Wait Until Element Is Visible            ${element}    ${timeout}    Element ${element} is not visible
    Scroll Element Into View                 ${element}
    Click Element                            ${element}

Common Get Element Text
    [Arguments]     ${element}      ${timeout}=${common_timeout}
    Wait Until Element Is Visible            ${element}       ${timeout}    Element ${element} is not visible
    Scroll Element Into View                 ${element}
    Get Text Element                         ${element}       ${timeout}

Start Test Suite
    Log     Starting Test Suite

End Test Suite
    Log     Ending Test Suite