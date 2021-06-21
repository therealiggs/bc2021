import threading
import socket


def in_dictionary(imsi: str):
    imsi_dict = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '_']

    for i in range(65, 91):  # Все заглавные английские буквы
        imsi_dict.append(chr(i))
    for i in range(97, 123):  # Все строчные английские буквы
        imsi_dict.append(chr(i))

    for i in imsi:
        if imsi_dict.count(i) == 0:
            return False

    return True


class MyServer(object):
    def __init__(self, req_num, suppress_output):
        self.suppress_output = suppress_output  # Параметр отвечает за принты в скрипте, нам они не понадобятся, так что
        # из тестов запускать будем с этим параметром = True
        self.req_num = req_num
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.bind(('localhost', 80))
        self.s.listen(1)  # Это количество запросов, которые сервер может обрабатывать одновременно,
        # нам больше 1 не нужно
        self.s.settimeout(1.0)

    def run(self):
        while self.req_num > 0:
            try:
                conn, addr = self.s.accept()  # Принимаем подключение
                req_text = str(conn.recv(1024))  # Получаем текст запроса

                if req_text.find('IMSI') != -1:
                    imsi = req_text[req_text.find('IMSI') + 5: len(req_text) - 5]

                    if 15 >= len(imsi) >= 1 and in_dictionary(imsi):
                        conn.send(bytes("HTTP/1.1 200 OK", 'utf-8'))
                        if not self.suppress_output: print('imsi: ' + imsi)
                    else:
                        conn.send(bytes("HTTP/1.1 500 System Error", 'utf-8'))
                        if not self.suppress_output: print('wrong symbols')
                else:
                    conn.send(bytes("HTTP/1.1 500 System Error", 'utf-8'))
                    if not self.suppress_output: print('no imsi')

                conn.close()
                self.req_num -= 1
            except socket.timeout:
                pass


def startup(req_num):
    myserv = MyServer(int(req_num), True)
    threading.Thread(target=myserv.run).start()  # Спасибо за хороший пример,
    # в котором действительно нужна многопоточность!




