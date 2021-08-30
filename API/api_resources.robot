*** Settings ***
Library               RequestsLibrary
Library               JSONLibrary
Library               Collections
Library               jsonschema
Library               OperatingSystem

*** Keywords ***
POST Request and Validation
    [Arguments]     ${base_url}     ${title}        ${body}     ${user_id}      ${payload_dir}

    # Inject data into Json payload
    ${request_body}=        JSONLibrary.Load Json From File     ${payload_dir}
    ${request_body}=        JSONLibrary.Update Value To Json    ${request_body}     $.title         ${title}
    ${request_body}=        JSONLibrary.Update Value To Json    ${request_body}     $.body          ${body}
    ${request_body}=        JSONLibrary.Update Value To Json    ${request_body}     $.userId        ${user_id}

    # Call Post Request and receive Response
    ${response}=            POST    ${base_url}    json=${request_body}

    # HTTP Status Validation
    Status Should Be            201

    # Get Data from Response Body
    ${res_title}=                           JSONLibrary.Get Value From Json         ${response.json()}         $.title
    ${res_title_str}=                       Get From List                           ${res_title}               0
    ${res_body}=                            JSONLibrary.Get Value From Json         ${response.json()}         $.body
    ${res_body_str}=                        Get From List                           ${res_body}                0
    ${res_userId}=                          JSONLibrary.Get Value From Json         ${response.json()}         $.userId
    ${res_userId_str}=                      Get From List                           ${res_userId}              0
    ${res_header_contentType}=              Get From Dictionary                     ${response.headers}        Content-Type
    ${res_header_etag}=                     Get From Dictionary                     ${response.headers}        etag

    # Validate Response Body content
    Should Be Equal         ${res_title_str}                            ${title}
    Should Be Equal         ${res_body_str}                             ${body}
    Should Be Equal         ${res_userId_str}                           ${user_id}

    # Validate Response Header for Content-Type and etag
    Should Be Equal         ${res_header_contentType}                   application/json; charset=utf-8
    Should Match Regexp     ${res_header_etag}                          W/"47-.{27}"

GET Request and Validation
    [Arguments]                     ${base_url}

    # Call GET Request and receive Response
    ${response}=        GET         ${base_url}

    # HTTP Status Validation
    Status Should Be                200

    # Get Data from Response Body
    ${res_id}=                               JSONLibrary.Get Value From Json         ${response.json()}          $..id
    ${res_id_str}=                           Get From List                           ${res_id}                   0
    ${res_header_contentType}=              Get From Dictionary                     ${response.headers}        Content-Type
    ${res_header_etag}=                     Get From Dictionary                     ${response.headers}        etag

    # Validate Response Body content for the first id
    Should Be Equal As Integers              ${res_id_str}                           1

    # Validate Response Header for Content-Type and etag
    Should Be Equal         ${res_header_contentType}                   application/json; charset=utf-8
    Should Match Regexp     ${res_header_etag}                          W/"160d-.{27}"

    # Validate if Body follow the correct schema
    ${schema}               Get Binary File         ${CURDIR}/../Test_Data/Schemas/get_schema.json
    ${schema}    evaluate    json.loads('''${schema}''')    json
    Validate        instance=${response.json()}        schema=${schema}

Start Test Suite
    log to console      Starting Test Suite

End Test Suite
    log to console      Ending Test Suite