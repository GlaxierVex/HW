*** Settings ***
Resource        ../API/api_resources.robot
Library         DataDriver      ../Test_Data/api_post_test_data.csv

Variables       ../API/test_env.yaml

Test Template   Short POST Request Test

Suite Setup     api_resources.Start Test Suite
Suite Teardown  api_resources.End Test Suite

*** Variables ***
${payload_dir}      ${CURDIR}/../Test_Data/payload.json

*** Test Cases ***
Jsonplaceholder POST Request Test   ${test_url}    ${title}      ${body}       ${user_id}      ${payload_dir}

*** Keywords *** 
Short POST Request Test
    [Arguments]                                   ${test_url}     ${title}      ${body}       ${user_id}      ${payload_dir}
    api_resources.POST Request and Validation     ${test_url}     ${title}      ${body}       ${user_id}      ${payload_dir}