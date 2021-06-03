def compare_responses(ids, exec_resp_list):  # Делать так - плохая практика, однако, у меня возникли проблемы
    # с тем, что Json'ы от респонсов PostgreSQLDB execute_string_mapped и RequestLibrary get_on_session составляются
    # по-разному, и я вышел из ситуации, сравнивая только значения в столбце customerid:
    exec_ids = []
    for i in exec_resp_list:
        exec_ids.append(i['customerid'])
    return sorted(ids) == sorted(exec_ids)