*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB
Library         JsonValidator
*** Test Cases ***
Post Requests with Json Data
    &{json}=    create dictionary    categoryname=test
    ${resp}=    Req.Patch on session   alias    /categories    ${json}
    log    ${resp}
    ${resp1}=      Req.GET On Session     alias    categories?      params=select=*

*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432
Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql