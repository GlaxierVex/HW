*** Settings ***
Resource        ../API/api_resources.robot
# Library         DataDriver      ../Test_Data/api_get_test_data.csv

Variables       ../API/test_env.yaml

Test Template   Short GET Request Test

Suite Setup     api_resources.Start Test Suite
Suite Teardown  api_resources.End Test Suite

*** Test Cases ***
Jsonplaceholder GET Request Test                   ${test_url_get}

*** Keywords ***
Short GET Request Test
    [Arguments]                                     ${test_url_get}           
    api_resources.GET Request and Validation        ${test_url_get}
