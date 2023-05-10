# pip install mysqlclient
import MySQLdb
import os
import csv


class Conexion:
    def __init__(self, host, user, password, port, db):
        self.host = host
        self.user = user
        self.password = password
        self.port = port
        self.db = db

    def conectar(self, host=None, port=None):
        if host:
            self.host = host
        if port:
            self.port = port
        try:
            self.conexion = MySQLdb.connect(
                self.host, self.user, self.password, self.db, self.port)
            self.cursor = self.conexion.cursor()
        except Exception as e:
            print("\nEl Servidor {}:{} no esta disponible".format(
                self.host, self.port))
            print("Error: {}".format(e))

    def consulta(self, comando):
        try:
            self.cursor.execute(comando)
            self.conexion.commit()
            resultado = self.cursor.fetchall()
            if resultado == []:
                return 1
            for fila in resultado:
                print(fila)
            return 0
        except Exception as e:
            print("\nEl Servidor {}:{} no esta disponible".format(
                self.host, self.port))
            print("Error: {}".format(e))
            return 1

    def cargar_inversiones(self):
        hosts = [NodoA, NodoB]
        ports = [3307, 3306]
        for i in hosts:
            self.conectar(i, ports[hosts.index(i)])
            self.cursor.execute('select * from Inversiones')
            self.conexion.commit()
            resultados = self.cursor.fetchall()
            with open('inversiones.csv', 'a', newline='') as archivo_csv:
                writer = csv.writer(archivo_csv, delimiter=',')
                for resultado in resultados:
                    writer.writerow(resultado)

    def desconectar(self):
        self.conexion.close()


def menu():
    global conexion
    usuario = input("Ingrese el usuario: ")
    contraseña = input("Ingrese la contraseña: ")
    conexion = Conexion(NodoA, usuario, contraseña, 3307, 'Inversiones_A')
    conexion.conectar()


NodoA = '172.30.194.81'
NodoB = '172.30.38.254'
NodoC = 'xxx,xxx,xxx,xxx'

menu()
while True:
    os.system('cls')
    print("1. Consultar Clientes.")
    print("2. Consular Inversiones.")
    print("3. Salir")
    opcion = input("\nIngrese una opcion: ")

    if opcion == "1":
        while True:
            os.system('cls')
            print("1. Clientes especifico.")
            print("2. Todos los Clientes.")
            print("3. Regresar.")
            op = input("\nIngrese una opcion: ")
            if op == "1":
                rfc = input("RFC del cliente: ")
                if conexion.consulta('select * from Clientes where RFC = "{}"'.format(rfc)):
                    print("El cliente no existe")
            elif op == "2":
                conexion.consulta('select * from Clientes')
            elif op == "3":
                break
            else:
                print("Opcion incorrecta")
            input("\nPresione una tecla para continuar...")

    elif opcion == "2":
        conexion.cargar_inversiones()
        while True:
            os.system('cls')
            print("1. Inversion especifica.")
            print("2. Todas las Inversiones.")
            print("3. Regresar.")
            op = input("\nIngrese una opcion: ")
            if op == "1":
                folio = input("Folio de Inversion: ")
                encontrado = False
                with open('inversiones.csv', 'r') as archivo_csv:
                    reader = csv.reader(archivo_csv)
                    for fila in reader:
                        if fila[0] == folio:
                            print(fila)
                            encontrado = True
                            break
                    if not encontrado:
                        print(f"No se encontró la inversion: '{folio}'")

            elif op == "2":
                with open('inversiones.csv', 'r') as archivo_csv:
                    reader = csv.reader(archivo_csv)
                    for fila in reader:
                        print(fila)

            elif op == "3":
                break
            else:
                print("Opcion incorrecta")

            input("\nPresione una tecla para continuar...")

    elif opcion == "3":
        break
    else:
        print("Opcion incorrecta")
    input("\nPresione una tecla para continuar...")
