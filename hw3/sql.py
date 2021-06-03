import PostgreSQLDB as Db


class Sql(object):
    db = Db.PostgreSQLDB()

    def execute_sql_string_mapped(self, string, **params):
        return self.db.execute_sql_string_mapped(string, **params)

    def connect_postgres(self, dbname, username, password, ip, port):
        self.db.connect_to_postgresql(dbname, username, password, ip, port)

    def disconnect_postgres(self):
        self.db.disconnect_from_postgresql()