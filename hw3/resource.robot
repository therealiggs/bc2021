*** Variables ***

${post_doc}    Отправляет на PgSQL сервер POST-запрос и GET-запросом проверяет правильность внесённых данных
${multiget_doc}    Отправляет на PgSQL сервер один GET-запрос для двух таблиц
*** Variables ***

${expec_multi_get_resp}    [{'age': 20, 'cust_hist': [{'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}, {'customerid': 44}]}, {'age': 19, 'cust_hist': []}, {'age': 20, 'cust_hist': [{'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}, {'customerid': 69}]}, {'age': 20, 'cust_hist': []}]
${expec_get_resp}    [{'category': 1, 'categoryname': 'test'}, {'category': 2, 'categoryname': 'test'}, {'category': 3, 'categoryname': 'test'}, {'category': 4, 'categoryname': 'test'}, {'category': 5, 'categoryname': 'test'}, {'category': 6, 'categoryname': 'test'}, {'category': 7, 'categoryname': 'test'}, {'category': 8, 'categoryname': 'test'}, {'category': 9, 'categoryname': 'test'}, {'category': 10, 'categoryname': 'test'}, {'category': 11, 'categoryname': 'test'}, {'category': 12, 'categoryname': 'test'}, {'category': 13, 'categoryname': 'test'}, {'category': 14, 'categoryname': 'test'}, {'category': 15, 'categoryname': 'test'}, {'category': 16, 'categoryname': 'test'}]
*** Variables ***
${post_column}    categoryname
${post_msg}    test
${post_table}    categories

@{multi_select_tables}    customers    cust_hist

${get_resp}
${multi_get_resp}
*** Settings ***

Library    RequestsLibrary     WITH NAME    Req
Library    inquiries.Inquiries       WITH NAME    Inq
*** Keywords ***
Test Setup
    [Timeout]    0.5s
    Inq.create session    alias       http://localhost:3000

Test Teardown
    [Timeout]    0.5s
    Inq.delete all sessions

Send POST inquiry
    [Timeout]    0.5s
    [Tags]    inquiry    post
    &{post_json}=    create dictionary    ${post_column}=${post_msg}
    Inq.send post  alias    ${post_table}    ${post_json}

Send GET inquiry
    [Timeout]    0.5s
    [Tags]    inquiry    get
    ${temp}    Inq.send get  alias    ${post_table}
    ${get_resp}    set variable    ${temp.json()}
    set global variable    ${get_resp}

Validate GET response
    [Timeout]    0.5s
    [Tags]    validation
    should be equal as strings    ${get_resp}    ${expec_get_resp}


Send GET inquiry for tables
    [Timeout]    0.5s
    [Tags]    inquiry    get
    ${temp}    Inq.send multi get  alias    @{multi_select_tables}
    ${multi_get_resp}    set variable    ${temp.json()}
    set global variable    ${multi_get_resp}

Validate multiple GET response
    [Timeout]    0.5s
    [Tags]    validation
    should be equal as strings    ${multi_get_resp}    ${expec_multi_get_resp}