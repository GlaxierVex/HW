*** Settings ***
Resource    ../Common/CommonFunctions.robot

*** Keywords ***
Verify Cart Page URL
    ${current_url}          Get Location
    Should Be Equal As Strings                  ${current_url}          ${cart_page_url}
    Log To console                              ${current_url}
    Log To console                              ${cart_page_url}