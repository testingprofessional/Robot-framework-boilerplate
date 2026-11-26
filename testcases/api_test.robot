*** Settings ***
Library          RequestsLibrary
Library          Collections
Suite Setup      Create Session    dummyapi    ${BASE_URL}

*** Variables ***
${BASE_URL}    https://dummyjson.com

*** Test Cases ***
Product Ophalen Via GET Request
    ${response}=      GET On Session     dummyapi    /products/1
    Status Should Be  200                ${response}
    ${json}=          Set Variable       ${response.json()}
    Should Be Equal   ${json}[title]     Essence Mascara Lash Princess
    Should Be True    ${json}[price] > 0

Nieuw Product Aanmaken Via POST Request
    &{nieuw_product}=    Create Dictionary    title=Robot Framework Handboek    price=${29.95}
    ${response}=         POST On Session      dummyapi    /products/add    json=${nieuw_product}
    Status Should Be     201                  ${response}
    ${json}=             Set Variable         ${response.json()}
    Should Be Equal      ${json}[title]       Robot Framework Handboek

Niet Bestaand Product Geeft 404 Foutmelding
    ${response}=      GET On Session     dummyapi    /products/99999    expected_status=404
    Status Should Be  404                ${response}
