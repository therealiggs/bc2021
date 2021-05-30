*** Settings ***
Library    Collections    WITH NAME    Col

*** Variables ***
@{row}    1    2    3   5   1   0   -1  10
@{no_dup_row}    1  2   3   5   0   -1  10

*** Test Cases ***
Uniques are 1 2 3 5 0 -1 10 test
    set test documentation    checks if the unique values are being found correctly
    ${expec_no_dup_row}=    Col.remove duplicates   ${row}
    col.lists should be equal    ${expec_no_dup_row}    ${no_dup_row}

Min is -1 test
    set test documentation    checks if the min value are being found correctly
    @{sort_row}=    set variable    ${row}
    Set list values to int    ${sort_row}
    Col.sort list    ${sort_row}
    should be equal as numbers    ${sort_row}[0]    -1

Max is 10 test
    set test documentation    checks if the max value are being found correctly
    @{sort_row}=    set variable    ${row}
    Set list values to int    ${sort_row}
    Col.sort list    ${sort_row}
    Col.reverse list    ${sort_row}
    should be equal as numbers    ${sort_row}[0]    10

Sum is 21 test
    set test documentation    checks if the sum of all varables are being found correctly
    @{sort_row}=    set variable    ${row}
    Set list values to int    ${sort_row}
    ${sum}=    convert to integer   0
    FOR    ${i}    IN    @{sort_row}
        ${sum}=    evaluate    ${sum} + ${i}
    END
    should be equal as numbers    ${sum}    21

*** Keywords ***
Set list values to int
    [Arguments]   ${sort_row}
    FOR    ${i}    IN    @{sort_row}
        ${i_int}=    convert to integer    ${i}
        ${i_pos}=  Col.get index from list    ${sort_row}    ${i}
        Col.set list value    ${sort_row}    ${i_pos}    ${i_int}
    END
    [Return]    ${sort_row}

















