*** Settings ***
Metadata    Автор    Шер Игорь
Test Timeout    2s
Test Setup      Test Setup
Test Teardown   Test Teardown
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