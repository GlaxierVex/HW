*** Settings ***
Resource        ../PageObjects/productDetailsPage.robot
Resource        ../PageObjects/cartPage.robot

Library         DataDriver          ../Test_Data/UI/TC01_Data.csv       encoding=utf_8

Test Setup     CommonFunctions.Open browser to page       ${url}      ${implicit_timeout}
Test Teardown  CommonFunctions.End Test Case

Test Template   Test Case 1

*** Test Cases ***
Test Case 1         ${product_details_url}      ${brand_name}           ${product_name}          ${productID}           ${product_discount_price}            ${product_old_price}        ${subtotal_price}

*** Keywords ***
Test Case 1
    [Arguments]         ${product_details_url}         ${brand_name}            ${product_name}          ${productID}        ${product_discount_price}           ${product_old_price}      ${subtotal_price}                                                         
    
    Go To               ${product_details_url}
    
    # Step 1: Verify Product Detail page Information
    productDetailsPage.Verify Product Detail Page Information           ${brand_name}  ${product_name}  ${productID}  ${product_discount_price}  ${product_old_price}

    # Step 2: Click "Add To Bag" Button
    productDetailsPage.Click Add To Bag Button                          ${productID}
    # Sleep to wait for message to dissapear
    Sleep                                                               10
    # Verify Added Quatity in Mini Cart Icon
    productDetailsPage.Verify Mini Cart Quantity

    # Step 3.1: Click Mini Cart Icon
    productDetailsPage.Click Mini Cart
    # Verify Mini Cart message Information
    productDetailsPage.Verify Mini Cart Product Information             ${product_old_price}  ${product_discount_price}  ${brand_name}  ${product_name}     ${subtotal_price}

    # Step 3.2: Click "View Cart" Button
    productDetailsPage.Click Mini Cart View Cart Button
    # Verify Redirected to Cart Page
    cartPage.Verify Cart Page URL



