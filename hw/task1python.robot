*** Variables ***
@{row}  1  2  3  5  1  0  -1  10

*** Test Cases ***
Min is -1 test
    ${min}=    Evaluate    min(int(i) for i in @{row})
    should be equal as numbers    ${min}    -1
    log    ${min}
Max is 10 test
    ${max}=    Evaluate    max(int(i) for i in @{row})
    should be equal as numbers    ${max}    10
Sum is 21 test
    ${sum}=    Evaluate    sum(int(i) for i in @{row})
    should be equal as numbers    ${sum}    21
Uniques are 1 2 3 5 0 -1 10 test
    @{uniques}=    Evaluate    sorted(list(set(int(i) for i in @{row})))
    @{answer}=    Evaluate    sorted(int(i) for i in [1,2,3,5,0,-1,10])
    should be equal    ${uniques}    ${answer}
