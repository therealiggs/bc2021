*** Variables ***
${post_doc}    Отправляет на PgSQL сервер POST-запрос и GET-запросом проверяет правильность внесённых данных
${multiget_doc}    Отправляет на PgSQL сервер один GET-запрос для двух таблиц
*** Variables ***
${get_resp}
${ids}
*** Settings ***
Resource    libs.robot
*** Keywords ***
Suite Setup
    [Timeout]    0.5s
    Rest.create session    alias       http://localhost:3000
    Sql.connect postgres    hadb    authenticator   mysecretpassword    localhost  8432

Suite Teardown
    [Timeout]    0.5s
    Rest.delete all sessions
    Sql.disconnect postgres

Send POST inquiry
    [Timeout]    0.5s
    [Tags]    inquiry    post
    &{post_json}=    create dictionary    categoryname=test
    Rest.send post    alias    categories    ${post_json}

Send GET inquiry
    [Timeout]    0.5s
    [Tags]    inquiry    get
    ${temp}    Rest.send get  alias    categories
    ${get_resp}    set variable    ${temp.json()}
    set global variable    ${get_resp}

Validate GET response
    [Timeout]    0.5s
    [Tags]    validation
    ${expec_get_resp}    Sql.execute sql string mapped    SELECT * FROM BOOTCAMP.CATEGORIES
    should be equal as strings    ${get_resp}    ${expec_get_resp}


Send GET inquiry for tables
    [Timeout]    0.5s
    [Tags]    inquiry    get
    ${temp}    Rest.send multi get  alias    customers    cust_hist
    ${ids}    get elements   ${temp.json()}    $..customerid
    set global variable    ${ids}

Validate multiple GET response
    [Timeout]    0.5s
    [Tags]    validation
    ${params1}    create dictionary    age=21     customerid=100
    ${SQL1}          set variable    SELECT AGE, T1.CUSTOMERID FROM BOOTCAMP.CUSTOMERS T1, BOOTCAMP.CUST_HIST T2 WHERE T1.CUSTOMERID = T2.CUSTOMERID AND T1.CUSTOMERID < %(customerid)s AND AGE<%(age)s
    ${expec_multi_get_resp}    Sql.execute sql string mapped   ${SQL1}   &{params1}

    ${flag}    Comp.compare responses    ${ids}     ${expec_multi_get_resp}
    should be true   ${flag}

