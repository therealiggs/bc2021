*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB
Library         JsonValidator
*** Test Cases ***
Check Horizontal Filtering

    ${resp}      Req.GET On Session     alias    customers?      params=age=lt.21&customerid=lt.100&select=age,cust_hist(customerid)
    Log          ${resp.json()}


*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432
Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql