import socket


def send_sock_request(imsi):
    host = 'localhost'
    port = 80
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((host, port))
    client.send(bytes(("GET / HTTP/1.1\r\nHost:localhost\r\nIMSI:" + imsi + "\r\n").encode('utf-8')))
    resp = client.recv(4096)
    return str(resp.decode())[9:]  # Возвращаем только код респонса и пояснение к нему





