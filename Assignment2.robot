*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://www.saucedemo.com
${BROWSER}        chrome
${USERNAME}       standard_user
${PASSWORD}       secret_sauce

*** Test Cases ***
Scenario: Complete Shopping Cart Checkout
    Given I am on the SauceDemo login page
    When I login with valid credentials
    And I add an item to the cart
    And I proceed to checkout
    And I fill in the checkout information
    And I complete the order
    Then I should see the order confirmation

*** Keywords ***
I am on the SauceDemo login page
    Open Browser    ${URL}    ${BROWSER}
    Page Should Contain Element    id:login-button

I login with valid credentials
    Input Text    id:user-name    ${USERNAME}
    Input Password    id:password    ${PASSWORD}
    Click Button    id:login-button
    Page Should Contain Element    class:inventory_list

I add an item to the cart
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Contain    class:shopping_cart_badge    1

I proceed to checkout
    Click Element    class:shopping_cart_link
    Click Button    id:checkout

I fill in the checkout information
    Input Text    id:first-name    Bagas
    Input Text    id:last-name    Andaryanto
    Input Text    id:postal-code    12345
    Click Button    id:continue

I complete the order
    Click Button    id:finish

I should see the order confirmation
    Page Should Contain    Thank you for your order!
    Element Should Be Visible    class:complete-header

[Teardown]
    Close Browser
