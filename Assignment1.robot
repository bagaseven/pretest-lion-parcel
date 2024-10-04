*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       https://reqres.in/api

*** Test Cases ***
Scenario: Get Single User
    Given the API endpoint is available
    When I send a GET request for user with id 2
    Then the response status code should be 200
    And the response should contain user data

Scenario: Create New User
    Given the API endpoint is available
    When I send a POST request to create a user
    Then the response status code should be 201
    And the response should contain the created user data

*** Keywords ***
the API endpoint is available
    Create Session    reqres    ${BASE_URL}    verify=True

I send a GET request for user with id 2
    ${response}=    GET On Session    reqres    /users/2
    Set Test Variable    ${response}

the response status code should be ${expected_status}
    Status Should Be    ${expected_status}    ${response}

the response should contain user data
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    data
    Dictionary Should Contain Key    ${json['data']}    id
    Dictionary Should Contain Key    ${json['data']}    email
    Should Be Equal As Strings    ${json['data']['first_name']}    Janet
    Should Be Equal As Strings    ${json['data']['last_name']}    Weaver
    Should Be Equal As Strings    ${json['data']['email']}    janet.weaver@reqres.in

I send a POST request to create a user
    ${body}=    Create Dictionary    name=Bagas Andaryanto    job=QA Engineer
    ${response}=    POST On Session    reqres    /users    json=${body}
    Set Test Variable    ${response}

the response should contain the created user data
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    id
    Dictionary Should Contain Key    ${json}    name
    Dictionary Should Contain Key    ${json}    job
    Should Be Equal As Strings    ${json['name']}    Bagas Andaryanto
    Should Be Equal As Strings    ${json['job']}    QA Engineer
