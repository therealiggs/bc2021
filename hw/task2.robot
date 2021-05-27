*** Test Cases ***
Test for 0
    ${results}=    to_fahrenheit    0
    should be equal as integers  ${results}    32
Test for 350
    ${results}=    to_fahrenheit    350
    should be equal as integers  ${results}    662
Test for -32
    ${results}=    to_fahrenheit    -32
    should be equal as numbers   ${results}    -25.6
Test for 100
    ${results}=    to_fahrenheit    100
    should be equal as integers  ${results}    212

*** Keywords ***
to_fahrenheit    [Arguments]    ${celsius}
    ${res}=  Evaluate    ${celsius} * 9 / 5 + 32
    [Return]    ${res}