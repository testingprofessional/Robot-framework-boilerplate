*** Settings ***
Library          Browser
Suite Setup      New Browser    chromium    headless=False
Test Setup       Open Webshop En Log In
Test Teardown    Close Context
Suite Teardown   Close Browser

*** Variables ***
${URL}         https://saucedemo.com
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

*** Test Cases ***
Product Toevoegen Aan Winkelwagen
    Click       id=add-to-cart-sauce-labs-backpack
    Get Text    css=.shopping_cart_badge    ==    1

Producten Sorteren Op Prijs Laag Naar Hoog
    Select Options By    css=.product_sort_container    value    lohi
    Get Text             css=.inventory_item_name >> nth=0     ==    Sauce Labs Onesie
    Get Text             css=.inventory_item_price >> nth=0    ==    $7.99

*** Keywords ***
Open Webshop En Log In
    New Context
    New Page     ${URL}
    Fill Text    id=user-name    ${USERNAME}
    Fill Text    id=password     ${PASSWORD}
    Click        id=login-button
    Get Text     css=.title      ==    Products
