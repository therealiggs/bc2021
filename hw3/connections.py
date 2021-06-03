import RequestsLibrary as Rl
import PostgreSQLDB as Db


class Connections(object):
    keywords = Rl.RequestsOnSessionKeywords()
    db = Db.PostgreSQLDB()




