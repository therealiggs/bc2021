*** Settings ***
Metadata    Автор    Шер Игорь
Test Timeout    2s
Suite Setup      Suite Setup
Suite Teardown   Suite Teardown
Resource    resource.robot
*** Test Cases ***
PostgreSQL POST inquiry
    [Documentation]    ${post_doc}
     Send POST inquiry
     Send GET inquiry
     Validate GET response
PostgreSQL GET inquiry for multiple tables
    [Documentation]    ${multiget_doc}
    Send GET inquiry for tables
    Validate multiple GET response