*** Settings ***
Resource    ../Common/CommonFunctions.robot

*** Keywords ***
Verify Cart Page URL
    ${current_url}          Get Location
    Should Be Equal As Strings                  ${current_url}          ${cart_page_url}
    Log To console                              ${current_url}
    Log To console                              ${cart_page_url}

Verify Added Product using API
    [Arguments]                     ${productName}
    ${trace_id}=                    Get Cookie          trace_id
    ${lang}=                        Get Cookie          lang
    ${originalUrl}                  Get Cookie          originalUrl
    ${_gid}=                        Get Cookie          _gid
    ${_gcl_au}=                     Get Cookie          _gcl_au
    ${guest}=                       Get Cookie          guest
    ${fbp}=                         Get Cookie          _fbp
    ${_ga}=                         Get Cookie          _ga
    ${RT}=                          Get Cookie          RT
    ${_ga_PKP7NN6TCW}=              Get Cookie          _ga_PKP7NN6TCW

    &{header}=          Create Dictionary
    ...    accept=application/json, text/plain, */*
    ...    accept-encoding=gzip, deflate, br
    ...    accept-language=en
    ...    cookie=trace_id=${trace_id.value}; lang=${lang.value}; originalUrl=${originalUrl.value}; _gid=${_gid.value}; _gat=1; _gcl_au=${_gcl_au.value}; _gat_UA-12345-1=1; _gat_UA-19232858-7=1; guest=${guest.value}; _fbp=${_fbp.value}; _ga=${_ga.value}; RT=${RT.value}; _ga_PKP7NN6TCW=${_ga_PKP7NN6TCW.value}
    ...    referer=https://www.robinson.co.th/en/cart

    ${current_time}=                Get Current Date      increment=0     result_format=epoch       exclude_millis=true

    ${end_point}=       Set Variable    https://www.robinson.co.th/api/cart?date=${current_time}

    ${response}=             GET            url=${end_point}           headers=${header}

    ${item_name_in_cart_json}=               JSONLibrary.Get Value From Json             ${response.json()}           $.cart.items[0].name
    ${item_name_in_cart}=                    Get From List                               ${item_name_in_cart_json}              0

    Should Be Equal As Strings               ${item_name_in_cart}                        ${productName}