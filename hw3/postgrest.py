import RequestsLibrary as Rl


class Postgrest(object):
    keywords = Rl.RequestsOnSessionKeywords()

    def create_session(self, alias, url):
        self.keywords.create_session(alias=alias, url=url)

    def delete_all_sessions(self):
        self.keywords.delete_all_sessions()

    def send_post(self, alias, table, json):
        self.keywords.patch_on_session(alias, table, json)

    def send_get(self, alias, table):
        return self.keywords.get_on_session(alias, table + '?', params='select=*')

    def send_multi_get(self, alias, table1, table2):
        return self.keywords.get_on_session(alias, table1 + '?', params='age=lt.21&customerid=lt.100&select=age,' +
                                                                        table2 + '(customerid)')


