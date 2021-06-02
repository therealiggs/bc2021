*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB
Library         JsonValidator
*** Test Cases ***
Post Requests with Json Data

    ${expec_resp_json}=    set variable    [{'category': 1, 'categoryname': 'test'}, {'category': 2, 'categoryname': 'test'}, {'category': 3, 'categoryname': 'test'}, {'category': 4, 'categoryname': 'test'}, {'category': 5, 'categoryname': 'test'}, {'category': 6, 'categoryname': 'test'}, {'category': 7, 'categoryname': 'test'}, {'category': 8, 'categoryname': 'test'}, {'category': 9, 'categoryname': 'test'}, {'category': 10, 'categoryname': 'test'}, {'category': 11, 'categoryname': 'test'}, {'category': 12, 'categoryname': 'test'}, {'category': 13, 'categoryname': 'test'}, {'category': 14, 'categoryname': 'test'}, {'category': 15, 'categoryname': 'test'}, {'category': 16, 'categoryname': 'test'}]

    &{params_json}=    create dictionary    categoryname=test
    Req.Patch on session   alias    /categories    ${params_json}

    ${resp}=      Req.GET On Session     alias    categories?      params=select=*

    should be equal as strings    ${expec_resp_json}    ${resp.json()}

*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432
Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql