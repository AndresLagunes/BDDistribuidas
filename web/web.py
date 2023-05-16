from flask import Flask, render_template, request, session, jsonify
import MySQLdb
import json


app = Flask(__name__)


class Conexion:
    def __init__(self, host, user, password, port, db):
        self.host = host
        self.user = user
        self.password = password
        self.port = port
        self.db = db

    def conectar(self):
        try:
            self.conexion = MySQLdb.connect(
                self.host, self.user, self.password, self.db, self.port, connect_timeout=3)
            self.cursor = self.conexion.cursor()
            return True
        except Exception as e:
            print(e)
            return False

    def desconectar(self):
        self.conexion.close()


def conectar_nodo(esquema, comando):
    resultado = []
    if esquema == ESQUEMA_A:
        conexion = Conexion(NODO_A, USER, PASSWORD, PUERTO_A, ESQUEMA_A)
        if not conexion.conectar():
            conexion = Conexion(NODO_B, USER, PASSWORD, PUERTO_B, ESQUEMA_A)
            if not conexion.conectar():
                conexion = Conexion(NODO_C, USER, PASSWORD,
                                    PUERTO_C, ESQUEMA_A)
                if not conexion.conectar():
                    return resultado, 'No se pudo conectar a la base de datos {}'.format(ESQUEMA_A)

    elif esquema == ESQUEMA_B:
        conexion = Conexion(NODO_B, USER, PASSWORD, PUERTO_B, ESQUEMA_B)
        if not conexion.conectar():
            conexion = Conexion(NODO_C, USER, PASSWORD, PUERTO_C, ESQUEMA_B)
            if not conexion.conectar():
                conexion = Conexion(NODO_A, USER, PASSWORD,
                                    PUERTO_A, ESQUEMA_B)
                if not conexion.conectar():
                    return resultado, 'No se pudo conectar a la base de datos {}'.format(ESQUEMA_B)

    elif esquema == ESQUEMA_C:
        conexion = Conexion(NODO_C, USER, PASSWORD, PUERTO_C, ESQUEMA_C)
        if not conexion.conectar():
            conexion = Conexion(NODO_A, USER, PASSWORD, PUERTO_A, ESQUEMA_C)
            if not conexion.conectar():
                conexion = Conexion(NODO_B, USER, PASSWORD,
                                    PUERTO_B, ESQUEMA_C)
                if not conexion.conectar():
                    return resultado, 'No se pudo conectar a la base de datos {}'.format(ESQUEMA_C)
    try:
        print(esquema)
        conexion.cursor.execute(comando)
        resultado = conexion.cursor.fetchall()
        conexion.desconectar()
    except Exception as e:
        print(e)
        return resultado, 'No se pudo ejecutar el comando {}'.format(comando)
    return resultado, ''


USER = 'master'
PASSWORD = 'master'

NODO_A = '172.29.102.117'
NODO_B = '172.29.197.96'
NODO_C = '172.29.38.254'

PUERTO_A = 3306
PUERTO_B = 3306
PUERTO_C = 3306

ESQUEMA_A = 'Inversiones_A'
ESQUEMA_B = 'Inversiones_B'
ESQUEMA_C = 'Inversiones_C'

# Modificar el arreglo de ESQUEMAS para que se conecte a todos los nodos/esquemas
ESQUEMAS = [ESQUEMA_A, ESQUEMA_B, ESQUEMA_C]
# ESQUEMAS = [ESQUEMA_A]
conexion = object


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/altas', methods=['GET', 'POST'])
def altas():
    return render_template('altas.html')

@app.route('/alta_cliente', methods=['GET', 'POST'])
def alta_cliente():
    return render_template('alta_cliente.html')



@app.route('/clientes', methods=['GET', 'POST'])
def clientes():
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            comando = "SELECT * FROM clientes "
            i = 1
            for llave, valor in valores.items():
                if i == 1:
                    comando += " WHERE "
                comando += llave + " = '" + valor+"' "
                if i < len(valores):
                    comando += " AND "
                    i = i + 1
        else:
            comando = 'SELECT * FROM clientes'

    resultado, error = conectar_nodo(ESQUEMA_A, comando)
    if not error == '':
        return render_template('clientes.html', clientes=[], mensaje=error)

    return render_template('clientes.html', clientes=resultado, mensaje='')


@app.route('/contratos', methods=['POST'])
def contratos():
    resultados = []
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            comando = "SELECT * FROM contrato_inversion "
            i = 1
            for llave, valor in valores.items():
                if i == 1:
                    comando += " WHERE "
                comando += llave + " = '" + valor+"' "
                if i < len(valores):
                    comando += " AND "
                    i = i + 1
        else:
            comando = 'SELECT * FROM contrato_inversion'
    # Modificar el arreglo de ESQUEMAS para que se conecte a todos los nodos/esquemas
    for esquema in ESQUEMAS:
        resultado, error = conectar_nodo(esquema, comando)
        if not error == '':
            return render_template('contratos.html', contratos=[], mensaje=error)
        resultados += resultado

    return render_template('contratos.html', contratos=resultados, mensaje='')


@app.route('/inversiones', methods=['POST'])
def inversiones():
    resultados = []
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            comando = "SELECT * FROM inversiones "
            i = 1
            for llave, valor in valores.items():
                if i == 1:
                    comando += " WHERE "
                comando += llave + " = '" + valor+"' "
                if i < len(valores):
                    comando += " AND "
                    i = i + 1
        else:
            comando = "SELECT * FROM inversiones"

    # Modificar el arreglo de ESQUEMAS para que se conecte a todos los nodos/esquemas
    for esquema in ESQUEMAS:
        resultado, error = conectar_nodo(esquema, comando)
        if not error == '':
            return render_template('inversiones.html', inversiones=[], mensaje=error)
        resultados += resultado

    return render_template('inversiones.html', inversiones=resultados, mensaje='')


@app.route('/ganancias', methods=['POST'])
def ganancias():
    resultados = []
    if request.method == 'POST':
        if 'rfc' in request.form:
            rfc = json.loads(request.form['rfc'])
            comando = "SELECT * FROM contrato_inversion WHERE rfc_cliente = '" + rfc + "'"
        else:
            comando = ''

    cliente, error_cliente = conectar_nodo(
        ESQUEMA_A, 'select * from clientes where rfc = "'+rfc+'"')
    # Modificar el arreglo de ESQUEMAS para que se conecte a todos los nodos/esquemas

    if comando == '':
        return render_template('ganancias.html', clientes=[], ganancias=[], mensaje='Error al consultar el cliente')
    for esquema in ESQUEMAS:
        resultado, error = conectar_nodo(esquema, comando)
        if not error == '':
            return render_template('ganancias.html', clientes=[], ganancias=[], mensaje=error)
        resultados += resultado
        if resultado:
            break
    return render_template('ganancias.html', clientes=cliente, ganancias=resultados, mensaje='')


@app.route('/inversionesClientes', methods=['POST'])
def inversionesClientes():
    resultados = []
    contrato = []
    if request.method == 'POST':
        if 'folioContrato' in request.form:
            folio_contrato = json.loads(request.form['folioContrato'])
            comando = "SELECT * FROM inversiones WHERE folio_contrato = '" + folio_contrato + "'"
        else:
            comando = ''
    for esquema in ESQUEMAS:
        contrato, error_cliente = conectar_nodo(
            esquema, 'SELECT * FROM contrato_inversion WHERE folio_contrato = "'+folio_contrato+'"')
        if contrato:
            break
    # Modificar el arreglo de ESQUEMAS para que se conecte a todos los nodos/esquemas

    for esquema in ESQUEMAS:
        resultado, error = conectar_nodo(esquema, comando)
        if not comando == '' and not error == '':
            return render_template('inversionesClientes.html', contratos=[], inversiones=[], mensaje=error)
        if comando == '':
            return render_template('inversionesClientes.html', contratos=[], inversiones=[], mensaje='Error al consultar el contrato')
        resultados += resultado
    return render_template('inversionesClientes.html', contratos=contrato, inversiones=resultados, mensaje='')


if __name__ == '__main__':
    app.run(debug=True, host='172.29.197.96', port=5000)
