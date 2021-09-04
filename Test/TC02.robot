*** Settings ***
Resource        ../PageObjects/productDetailsPage.robot

Library         DataDriver          ../Test_Data/UI/TC02_Data.csv       encoding=utf_8

Test Setup     CommonFunctions.Open browser to page       ${url}      ${implicit_timeout}
Test Teardown  CommonFunctions.End Test Case

Test Template   Test Case 2

*** Test Cases ***
Test Case 2         ${product_details_url}      ${brand_name}           ${product_name}          ${productID}           ${product_discount_price}            ${product_old_price}        ${subtotal_price}
    ...             ${ratings}                  ${nickname}             ${email}                 ${review_summary}      ${region}                            ${review_dettails}

*** Keywords ***
Test Case 2
    [Arguments]         ${product_details_url}         ${brand_name}            ${product_name}          ${productID}           ${product_discount_price}           ${product_old_price}      ${subtotal_price}
    ...                 ${ratings}                     ${nickname}              ${email}                 ${review_summary}      ${region}                           ${review_dettails}                                                      
    
    Go To               ${product_details_url}

    # Step 1: Verify Product Detail page Information
    productDetailsPage.Verify Product Detail Page Information           ${brand_name}  ${product_name}  ${productID}  ${product_discount_price}  ${product_old_price}

    # Step 2: Click "Add A Review" Button
    productDetailsPage.Click Add A Review Button

    # Verify Customer Review Area Information
    productDetailsPage.Verify Customer Review Field Information           ${product_name}

    # Step 3: Fill in Review Information
    Fill All Customer Review Fields, Submit and Verify Thank You Message         ${ratings}                  ${nickname}             ${email}            ${review_summary}       ${region}       ${review_dettails}




