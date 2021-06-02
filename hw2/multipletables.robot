*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB
Library         JsonValidator
Library         Collections     WITH NAME    Col
*** Test Cases ***
Check Horizontal Filtering

    ${expec_resp_json}=    set variable    [{'age': 20, 'cust_hist': [{'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}]}, {'age': 19, 'cust_hist': []}, {'age': 20, 'cust_hist': [{'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}]}, {'age': 20, 'cust_hist': []}]

    ${resp}      Req.GET On Session     alias    customers?      params=age=lt.21&customerid=lt.100&select=age,cust_hist(customerid)

    should be equal as strings    ${expec_resp_json}    ${resp.json()}

*** Keywords ***
Test Setup
    Req.Create session                   alias       http://localhost:3000
    DB.Connect To Postgresql      hadb    authenticator   mysecretpassword    localhost  8432
Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql