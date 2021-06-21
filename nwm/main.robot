*** Settings ***
Documentation    ${doc}
Metadata    Автор    Шер Игорь
Test Timeout    2s
Suite Setup      Suite Setup
# Suite Teardown не требуется
Resource    resource.robot
*** Test Cases ***
Test for length 0
     Send GET inquiry with IMSI    ''
     Resp should be    500 System Error

Test for length 1 and correct IMSI
     Send GET inquiry with IMSI  a
     Resp should be    200 OK
Test for length 1 and incorrect IMSI
     Send GET inquiry with IMSI    +
     Resp should be    500 System Error

Test for length 2 and correct IMSI
     Send GET inquiry with IMSI    _A
     Resp should be    200 OK
Test for length 2 and incorrect IMSI
     Send GET inquiry with IMSI    _Г
     Resp should be    500 System Error

Test for length 14 and correct IMSI
     Send GET inquiry with IMSI   test1234567890
     Resp should be    200 OK
Test for length 14 and incorrect IMSI
     Send GET inquiry with IMSI    тест1234567890
     Resp should be    500 System Error

Test for length 15 and correct IMSI
     Send GET inquiry with IMSI    TEST12345678910
     Resp should be    200 OK
Test for length 15 and incorrect IMSI
     Send GET inquiry with IMSI    ТЕСТ12345678910
     Resp should be    500 System Error

Test for length 16 and correct IMSI
     Send GET inquiry with IMSI    Test_12345678910
     Resp should be    500 System Error
Test for length 16 and incorrect IMSI
     Send GET inquiry with IMSI    Тест_12345678910
     Resp should be    500 System Error

Test for large IMSI
    Send GET inquiry with large IMSI
    Resp should be    500 System Error