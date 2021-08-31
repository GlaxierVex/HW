*** Settings ***
Resource    ../Common/CommonFunctions.robot

*** Variables ***
${nav_productDetails}                           xpath://div[@id="ProductDetailPage"]/div[@data-testid="breadcrumb"]
${label_brandName}                              xpath://a[@data-testid="brandname-link"]
${label_productName}                            xpath://div[contains(@id, "inf-viewProduct")]
${label_product_discount_price}                 xpath://div[@data-testid="price-sell"]
${label_product_old_price}                      xpath://div[contains(@id, "inf-viewPriceSave-")]
${img_productImage}                             xpath://img[@alt="{productName}"]
${dropdown_quantity}                            xpath://div[contains(@id, "sel-addQty-")]/..
${btn_addToBag}                                 xpath://div[@id="btn-addCart-{productID}"]
${btn_addToWishList}                            xpath://div[@data-testid="inf-viewAddToWishlistV2View-Container"]/..
${area_product_details}                         xpath://div[@id="tabDetail"]
${area_customer_review}                         xpath://div[@id="review-section"]
${area_similar_product}                         xpath://div[@id="SimilarProduct"]
${area_you_may_like}                            xpath://div[@id="YouMayLike"]
${btn_share_facebook_page}                      xpath://a[@id="lnk-shareProductToFacebook-{productID}"]
${btn_share_twitter_page}                       xpath://a[@id="lnk-shareProductToTwitter-{productID}"]
${btn_share_mail_page}                          xpath://a[@id="lnk-shareProductToEmail-{productID}"]
${btn_share_line_page}                          xpath://a[@id="lnk-shareProductToLine-{productID}"]
${btn_minicart}                                 xpath://a[@id="btn-viewMiniCartOnMainHeader"]
${minicart_cart_quantity}                       xpath://a[@id="btn-viewMiniCartOnMainHeader"]//following-sibling::span
${minicart_label_brand_name}                    xpath://a[contains(@id, "lnk-viewBrandOnMiniCart-")]/label
${minicart_label_product_name}                  xpath://a[contains(@id, "lnk-viewProductNameOnMiniCart-")]/label
${minicart_label_product_discount_price}        xpath://div[contains(@id, "inf-viewPriceItemOnMiniCart-")]
${minicart_label_product_old_price}             xpath://div[contains(@id, "inf-viewPriceOriginalOnMiniCart-")]
${minicart_label_subtotal}                      xpath://div[@id="lnk-viewPriceSubtotalOnMiniCart"]
${minicart_button_view_cart}                    xpath://a[@id="lnk-viewCartOnMiniCart"]/div

*** Keywords ***
Verify Product Detail Page Information
    [Arguments]                                      ${brand_name}      ${product_name}     ${productID}        ${product_discount_price}       ${product_old_price}
    Verify Product Navigator Exists
    Verify Brand Name Exists                         ${brand_name}
    Verify Product Name Exists                       ${product_name}
    Verify Product Discount Price Exists             ${product_discount_price}
    Verify Product Old Price Exists                  ${product_old_price}
    Verify Product Image Exists                      ${product_name}
    Verify Quantity Drop Down Exists
    Verify Add To Bag Button Exists                  ${productID}
    Verify Add To Wish List Button Exists
    Verify Product Details Area Exists
    Verify Customer Review Area Exists
    # For some elements at the bottom of the page, user needs to scroll down for them to be loaded
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Verify Similar Product Area Exists
    Verify You May Like Area Exists
    Verify Facebook Share Button Exists              ${productID}
    Verify Twitter Share Button Exists               ${productID}
    Verify Mail Share Button Exists                  ${productID}
    Verify Line Share Button Exists                  ${productID}

Verify Mini Cart Product Information
    [Arguments]                         ${old_price}        ${discount_price}       ${brand_name}       ${product_name}     ${subtotal}
    Verify Mini Cart Old Price          ${old_price}
    Verify Mini Cart Discount Price     ${discount_price}
    Verify Mini Cart Brand Name         ${brand_name}
    Verify Mini Cart Product Name       ${product_name}
    Verify Mini Cart Subtotal           ${subtotal}

Verify Product Navigator Exists
    Element Should Be Visible           ${nav_productDetails}

Verify Brand Name Exists
    [Arguments]                         ${brandName}
    Element Should Be Visible           ${label_brandName}
    ${textBrandName}                    Get Text                            ${label_brandName}
    Should Be Equal As Strings          ${textBrandName}                    ${brandName}

Verify Product Name Exists
    [Arguments]                         ${productName}
    Element Should Be Visible           ${label_productName}
    ${textProductName}                  Get Text                            ${label_productName}
    Should Be Equal As Strings          ${textProductName}                  ${productName}

Verify Product Discount Price Exists
    [Arguments]                         ${displayed_price}
    Element Should Be Visible           ${label_product_discount_price}
    ${price}                            Get Text                             ${label_product_discount_price}
    Should Be Equal As Strings          ${price}                             ${displayed_price}

Verify Product Old Price Exists
    [Arguments]                         ${displayed_price}
    Element Should Be Visible           ${label_product_old_price}
    ${price}                            Get Text                             ${label_product_old_price}
    Should Be Equal As Strings          ${price}                             ${displayed_price}

Verify Product Image Exists
    [Arguments]                         ${productName}
    ${img_productImage}=                Format String                    ${img_productImage}            productName=${productName}
    Element Should Be Visible           ${img_productImage}

Verify Quantity Drop Down Exists
    Element Should Be Visible           ${dropdown_quantity}

Verify Add To Bag Button Exists
    [Arguments]                         ${productID}
    ${btn_addToBag}=                    Format String                    ${btn_addToBag}            productID=${productID}
    Element Should Be Visible           ${btn_addToBag}

Verify Add To Wish List Button Exists
    Element Should Be Visible           ${btn_addToWishList}

Verify Product Details Area Exists
    Element Should Be Visible           ${area_product_details}

Verify Customer Review Area Exists
    Element Should Be Visible           ${area_customer_review}

Verify Similar Product Area Exists
    Element Should Be Visible           ${area_similar_product}

Verify You May Like Area Exists
    Element Should be Visible           ${area_you_may_like}

Verify Facebook Share Button Exists
    [Arguments]                         ${productID}
    ${btn_share_facebook_page}=         Format String                    ${btn_share_facebook_page}         productID=${productID}
    Element Should Be Visible           ${btn_share_facebook_page}

Verify Twitter Share Button Exists
    [Arguments]                         ${productID}
    ${btn_share_twitter_page}=          Format String                     ${btn_share_twitter_page}         productID=${productID}
    Element Should Be Visible           ${btn_share_twitter_page}

Verify Mail Share Button Exists
    [Arguments]                         ${productID}
    ${btn_share_mail_page}=             Format String                        ${btn_share_mail_page}         productID=${productID}
    Element Should Be Visible           ${btn_share_mail_page}

Verify Line Share Button Exists
    [Arguments]                         ${productID}
    ${btn_share_line_page}=             Format String                        ${btn_share_line_page}         productID=${productID}
    Element Should Be Visible           ${btn_share_line_page}

Click Mini Cart
    CommonFunctions.Common Click Element                            ${btn_minicart}

Click Add To Bag Button
    [Arguments]                         ${productID}
    ${btn_addToBag}=                    Format String                        ${btn_addToBag}            productID=${productID}
    CommonFunctions.Common Click Element                            ${btn_addToBag}

Verify Mini Cart Discount Price
    [Arguments]                         ${displayed_price}
    Element Should Be Visible           ${minicart_label_product_discount_price}
    ${price}                            Get Text                    ${minicart_label_product_discount_price}
    Should Be Equal As Strings          ${displayed_price}          ${price}

Verify Mini Cart Old Price
    [Arguments]                         ${displayed_price}
    Element Should Be Visible           ${minicart_label_product_old_price}
    ${price}                            Get Text                    ${minicart_label_product_old_price}
    Should Be Equal As Strings          ${displayed_price}          ${price}

Verify Mini Cart Subtotal
    [Arguments]                         ${displayed_price}
    Element Should Be Visible           ${minicart_label_subtotal}
    ${price}                            Get Text                    ${minicart_label_subtotal}
    Should Be Equal As Strings          ${displayed_price}          ${price}

Verify Mini Cart Brand Name
    [Arguments]                         ${brand_name}
    Element Should Be Visible           ${minicart_label_brand_name}
    ${brand}                            Get Text                    ${minicart_label_brand_name}
    Should Be Equal As Strings          ${brand_name}               ${brand}

Verify Mini Cart Product Name
    [Arguments]                         ${product_name}
    Element Should Be Visible           ${minicart_label_product_name}
    ${product}                          Get Text                    ${minicart_label_product_name}
    Should Be Equal As Strings          ${product_name}             ${product}

Verify Mini Cart Quantity
    ${quantity}                         Get Text                    ${minicart_cart_quantity}
    Should Be Equal As Integers         ${quantity}                 1

Click Mini Cart View Cart Button
    CommonFunctions.Common Click Element                            ${minicart_button_view_cart}



