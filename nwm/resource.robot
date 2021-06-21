*** Variables ***
${doc}    Предположу, что это блэкбокс тест, потому что именно его мы обсуждали на собеседовании. Тогда рассмотрим все комбинации длины (будем рассматривать длины: 0,1,2,14,15,16) и корректности IMSI (True/False). Всего будет 11 функциональных тестов и один нагрузочный: отправим запрос с IMSI длиной 100 000 символов. Если бы у меня было больше требований, я бы написал больше тестов.
*** Variables ***
${get_resp}
*** Settings ***
Library    my_server    WITH NAME    Serv
Library    sender    WITH NAME    Sender
*** Keywords ***
Suite Setup
    [Timeout]    0.5s
    [Documentation]    Запускаем сервер и заранее указываем, после скольки запросов он завершит работу
    Serv.startup    12

Send GET inquiry with IMSI
    [Arguments]    ${args}
    [Timeout]    0.5s

    ${get resp}    Sender.send sock request    ${args}
    set global variable    ${get_resp}

Resp should be
    [Arguments]    ${args}
    [Timeout]    0.3s

    should be equal as strings    ${get_resp}    ${args}

Send GET inquiry with large IMSI
    [Timeout]    0.5s
    ${large_imsi}    evaluate    'a'*100000
    ${get_resp}    Sender.send sock request    ${large_imsi}
    set global variable    ${get_resp}



