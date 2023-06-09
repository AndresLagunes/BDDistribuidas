# COMENTARIOS - EQUIPO 1
# INTEGRANTES:
# Fontes Peña Angel De Jesus
# Ruiz Cruz Juan Jose
# Lagunes Hernández Jesús Andrés




# En este archivo tenemos las conexiones, consultas, altas, modificaciones y bajas, funciona como
# nuestro backend y es lo que comunica la apliación con la base de datos.
# También maneja las conexiones con los nodos
# 


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


def conectar_nodo(esquema, comando, solo_esquema_a=False, nodo=''):
    print(comando)
    resultado = []
    if nodo == '':
        if solo_esquema_a:
            if esquema == ESQUEMA_A:
                conexion = Conexion(NODO_A, USER, PASSWORD, PUERTO_A, ESQUEMA_A)
                print('1')
                if not conexion.conectar():
                    return resultado, 'No se pudo registrar el cliente en la Sucursal 1'
            elif esquema == ESQUEMA_B:
                conexion = Conexion(NODO_B, USER, PASSWORD, PUERTO_B, ESQUEMA_A)
                print('2')
                if not conexion.conectar():
                    return resultado, 'No se pudo registrar el cliente en la Sucursal 2'
            elif esquema == ESQUEMA_C:
                conexion = Conexion(NODO_C, USER, PASSWORD, PUERTO_C, ESQUEMA_A)
                print('3')
                if not conexion.conectar():
                    return resultado, 'No se pudo registrar el cliente en la Sucursal 3'  
            
        elif esquema == ESQUEMA_A:
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
            print(conexion.host)
            conexion.cursor.execute(comando)
            conexion.conexion.commit()
            resultado = conexion.cursor.fetchall()
            conexion.desconectar()
        except Exception as e:
            print(e)
            return resultado, 'No se pudo ejecutar el comando {}'.format(comando)
    else:
        print('intentando en nodo ' + nodo)
        # cambia el puerto conforme el nodo que se utilice
        puerto = PUERTO_A if nodo == NODO_A else PUERTO_B if nodo == NODO_B else PUERTO_C
        conexion = Conexion(nodo, USER, PASSWORD, puerto, esquema)
        if not conexion.conectar():
            return resultado, 'No se pudo conectar al nodo {}'.format(nodo)
        try:
            print(esquema)
            print(conexion.host)
            conexion.cursor.execute(comando)
            conexion.conexion.commit()
            resultado = conexion.cursor.fetchall()
            conexion.desconectar()
        except Exception as e:
            print(e)
            return resultado, 'No se pudo ejecutar el comando {}'.format(comando)
         
    return resultado, ''


def verificar_nodos():
    resultados = {}

    for nodo, puerto in zip(NODOS, PUERTOS):
        conexion = Conexion(nodo, USER, PASSWORD, puerto, ESQUEMA_A)  # Esquema A se utiliza si todos los nodos replican el mismo esquema.
        resultado_conexion = conexion.conectar()
        if resultado_conexion:
            conexion.desconectar()
        resultados[nodo] = resultado_conexion

    return resultados

USER = 'master'
PASSWORD = 'master'

NODO_A = 'JESUSLAGUNES'
NODO_B = 'ANGELFP'
NODO_C = 'JUANJORUIZ'
NODOS = [NODO_A, NODO_B, NODO_C]

PUERTO_A = 3306
PUERTO_B = 3306
PUERTO_C = 3308
PUERTOS = [PUERTO_A, PUERTO_B, PUERTO_C]

ESQUEMA_A = 'Inversiones_A'
ESQUEMA_B = 'Inversiones_B'
ESQUEMA_C = 'Inversiones_C'

#Esquema al que se va a conectar
ESQUEMA_DEFAULT = ESQUEMA_A
SUCURSAL = 1


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
@app.route('/modificaciones', methods=['GET', 'POST'])
def modificaciones():
    return render_template('modificaciones.html')
@app.route('/bajas', methods=['GET', 'POST'])
def bajas():
    return render_template('bajas.html')




# CLIENTES

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


@app.route('/alta_cliente', methods=['GET', 'POST'])
def alta_cliente():
    return render_template('alta_cliente.html')


@app.route('/crear_cliente', methods=['POST'])
def crear_cliente():
    print(request.form)
    rfc = request.form['rfc']
    nombre = request.form['nombre']
    apellido_paterno = request.form['apellido_paterno']
    apellido_materno = request.form['apellido_materno']
    direccion = request.form['direccion']
    telefono = request.form['telefono']
    email = request.form['email']

    if request.method == 'POST':
        comando = f"INSERT INTO clientes (rfc, nombre, apellido_paterno, apellido_materno, direccion, telefono, email, sucursal) VALUES ('{rfc}', '{nombre}', '{apellido_paterno}', '{apellido_materno}', '{direccion}', '{telefono}', '{email}', '{SUCURSAL}')"

    # Resto del código para procesar los datos recibidos
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se registró el cliente porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('alta_cliente.html', mensaje = msg)
        
        
    return render_template('alta_cliente.html', mensaje='Cliente registrado con éxito')

@app.route('/modificar_cliente', methods=['GET', 'POST'])
def modificar_cliente():
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            print(valores)

            comando = "SELECT * FROM clientes "
            i = 1
            longitud = len(valores)
            longitud -= 1 if 'null' in valores else 0
            for llave, valor in valores.items():
                if llave != 'null':
                    if i == 1:
                        comando += " WHERE "
                    comando += llave + " = '" + valor+"' "
                    if i < longitud:
                        comando += " AND "
                    i = i + 1
            print(comando)
        else:
            comando = 'SELECT * FROM clientes'

    resultado, error = conectar_nodo(ESQUEMA_A, comando)
    if not error == '':
        return render_template('modificar_cliente.html', clientes=[], mensaje=error)
    
    return render_template('modificar_cliente.html', clientes=resultado, mensaje='')

@app.route('/modificacion_cliente', methods=['GET', 'POST'])
def modificacion_cliente():
    if request.method == 'POST':
        print(request.form.get('rfc'))
        cliente = request.form.to_dict()
        print(cliente)

    return render_template('modificacion_cliente.html', cliente = cliente, mensaje = '')

@app.route('/actualizar_cliente', methods=['GET', 'POST'])
def actualizar_cliente():
    if request.method == 'POST':
        print(request.form.get('rfc'))
        cliente = request.form.to_dict()
        comando = f"UPDATE clientes SET nombre = '{cliente['nombre']}', apellido_paterno = '{cliente['apellido_paterno']}', " \
                f"apellido_materno = '{cliente['apellido_materno']}', direccion = '{cliente['direccion']}', " \
                f"telefono = '{cliente['telefono']}', email = '{cliente['email']}' WHERE rfc = '{cliente['rfc']}'"
        print(comando)
        
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se actualizaron los datos del cliente porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('modificar_cliente.html', mensaje=msg)
    

    return render_template('modificar_cliente.html', mensaje = 'Cliente actualizado con éxito')

@app.route('/baja_clientes', methods=['GET', 'POST'])
def baja_clientes():
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            print(valores)

            comando = "SELECT * FROM clientes "
            i = 1
            longitud = len(valores)
            longitud -= 1 if 'null' in valores else 0
            for llave, valor in valores.items():
                if llave != 'null':
                    if i == 1:
                        comando += " WHERE "
                    comando += llave + " = '" + valor+"' "
                    if i < longitud:
                        comando += " AND "
                    i = i + 1
            print(comando)
        else:
            comando = 'SELECT * FROM clientes'

    resultado, error = conectar_nodo(ESQUEMA_A, comando, True)
    if not error == '':
        return render_template('baja_clientes.html', clientes=[], mensaje=error)
    
    return render_template('baja_clientes.html', clientes=resultado, mensaje='')

@app.route('/eliminar_cliente', methods=['GET', 'POST'])
def eliminar_cliente():
    if request.method == 'POST':
        print(request.form.get('rfc'))
        cliente = request.form.to_dict()
        comando = f"DELETE FROM clientes WHERE rfc = '{cliente['rfc']}'"

        print(comando)
        
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo eliminar al cliente porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('baja_clientes.html', mensaje=msg)
        

    return render_template('baja_clientes.html', mensaje = 'Cliente eliminado con éxito')
# FIN CLIENTES


# CONTRATOS

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

@app.route('/alta_contrato', methods=['GET', 'POST'])
def alta_contrato():
    if request.method == 'POST':
        comando = 'SELECT * FROM clientes'

    resultado, error = conectar_nodo(ESQUEMA_A, comando)
    if not error == '':
        return render_template('alta_contrato.html', clientes=[], mensaje=error)
    
    return render_template('alta_contrato.html',clientes=resultado, mensaje='')

@app.route('/crear_contrato', methods=['POST'])
def crear_contrato():
    cliente = request.form['cliente']
    fecha_inicio = request.form['fecha_inicio']
    fecha_vencimiento = request.form['fecha_vencimiento']
    sucursal = request.form['sucursal']

    # Resto del código para procesar los datos recibidos
    
    if request.method == 'POST':
        comando = f"INSERT INTO contrato_inversion (rfc_cliente, fecha_inicio, fecha_vencimiento, sucursal) VALUES ('{cliente}', '{fecha_inicio}', '{fecha_vencimiento}', '{sucursal}')"
        print(comando)
        
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo crear el contrato porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('alta_contrato.html', mensaje=msg)


    return render_template('alta_contrato.html', mensaje='Contrato registrado con éxito')



@app.route('/modificar_contrato', methods=['GET', 'POST'])
def modificar_contrato():
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            print(valores)

            comando = "SELECT * FROM contrato_inversion "
            i = 1
            longitud = len(valores)
            longitud -= 1 if 'null' in valores else 0
            for llave, valor in valores.items():
                if llave != 'null':
                    if i == 1:
                        comando += " WHERE "
                    comando += llave + " = '" + valor+"' "
                    if i < longitud:
                        comando += " AND "
                    i = i + 1
            print(comando)
        else:
            comando = 'SELECT * FROM contrato_inversion'

    resultado, error = conectar_nodo(ESQUEMA_A, comando)
    if not error == '':
        return render_template('modificar_contrato.html', contratos=[], mensaje=error)
    
    return render_template('modificar_contrato.html', contratos=resultado, mensaje='') 

@app.route('/modificacion_contrato', methods=['GET', 'POST'])
def modificacion_contrato():
    if request.method == 'POST':
        contrato = request.form.to_dict()
        print(contrato)

    return render_template('modificacion_contrato.html', contrato = contrato, mensaje = '')   

@app.route('/actualizar_contrato', methods=['GET', 'POST'])
def actualizar_contrato():
    if request.method == 'POST':
        print(request.form.get('fecha_vencimiento'))
        contrato = request.form.to_dict()
        comando = f"UPDATE contrato_inversion SET fecha_vencimiento = '{contrato['fecha_vencimiento']}' WHERE folio_contrato = '{contrato['id']}'"
        print(comando)
        
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo modificar el contrato porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('modificar_contrato.html', mensaje=msg)
        
    return render_template('modificar_contrato.html', mensaje = 'Contrato actualizado con éxito')


@app.route('/baja_contratos', methods=['GET', 'POST'])
def baja_contratos():
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            print(valores)

            comando = "SELECT * FROM contrato_inversion "
            i = 1
            longitud = len(valores)
            longitud -= 1 if 'null' in valores else 0
            for llave, valor in valores.items():
                if llave != 'null':
                    if i == 1:
                        comando += " WHERE "
                    comando += llave + " = '" + valor+"' "
                    if i < longitud:
                        comando += " AND "
                    i = i + 1
            print(comando)
        else:
            comando = 'SELECT * FROM contrato_inversion'

    resultado, error = conectar_nodo(ESQUEMA_A, comando)
    if not error == '':
        return render_template('baja_contratos.html', contratos=[], mensaje=error)
    
    return render_template('baja_contratos.html', contratos=resultado, mensaje='')

@app.route('/eliminar_contrato', methods=['GET', 'POST'])
def eliminar_contrato():
    if request.method == 'POST':
        print(request.form.get('id'))
        contrato = request.form.to_dict()
        comando = f"DELETE FROM contrato_inversion WHERE folio_contrato = '{contrato['id']}'"
        print(comando)
        
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo eliminar el contrato porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('baja_contratos.html', mensaje=msg)

    return render_template('baja_contratos.html', mensaje = 'Contrato eliminado con éxito')
# FIN CONTRATOS

# INVERSIONES

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

@app.route('/alta_inversion', methods=['GET', 'POST'])
def alta_inversion():
    if request.method == 'POST':
        comandoContrato = 'SELECT * FROM contrato_inversion'
        comandoTasa = 'SELECT * FROM tasa'

    resultadoContrato, errorContrato = conectar_nodo(ESQUEMA_A, comandoContrato)
    resultadoTasa, errorTasa = conectar_nodo(ESQUEMA_A, comandoTasa)
    if not errorContrato == ''  and not errorTasa == '':
        return render_template('alta_inversion.html', resultadoContrato=[], resultadoTasa=[], mensajeContrato=errorContrato, mensajeTasa=errorTasa)
    
    return render_template('alta_inversion.html',resultadoContrato=resultadoContrato, resultadoTasa=resultadoTasa, mensaje='')

@app.route('/crear_inversion', methods=['POST'])
def crear_inversion():
    contrato = request.form['contrato']
    tasa = request.form['tasa']
    tipo_de_inversion = request.form['tipo_de_inversion']
    monto_de_inversion = request.form['monto_de_inversion']
    sucursal = request.form['sucursal']


    if request.method == 'POST':
        comando = f"INSERT INTO inversiones (folio_contrato, clave_tasa, tipo_inversion, monto_invertido, sucursal) VALUES ('{contrato}', '{tasa}', '{tipo_de_inversion}', '{monto_de_inversion}', '{sucursal}')"
        print(comando)


    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo crear la inversión porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('alta_inversion.html', mensaje=msg)
    

    return render_template('alta_inversion.html', mensaje='Inversión registrada con éxito')



@app.route('/modificar_inversion', methods=['GET', 'POST'])
def modificar_inversion():
    resultados = []
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            comando = "SELECT * FROM inversiones "
            i = 1
            longitud = len(valores)
            longitud -= 1 if 'null' in valores else 0
            for llave, valor in valores.items():
                if llave != 'null':
                    if i == 1:
                        comando += " WHERE "
                    comando += llave + " = '" + valor+"' "
                    if i < longitud:
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

    return render_template('modificar_inversion.html', inversiones=resultados, mensaje='')
    
@app.route('/modificacion_inversion', methods=['GET', 'POST'])
def modificacion_inversion():
    if request.method == 'POST':
        inversion = request.form.to_dict()
        print(inversion)
    if request.method == 'POST':
        comandoTasa = 'SELECT * FROM tasa'

    resultadoTasa, errorTasa = conectar_nodo(ESQUEMA_A, comandoTasa)
    if not errorTasa == '':
        return render_template('modificar_inversion.html', resultadoContrato=[], tasas=[], mensajeTasa=errorTasa)
    return render_template('modificacion_inversion.html', tasas=resultadoTasa,  inversion = inversion, mensaje = '')   

@app.route('/actualizar_inversion', methods=['GET', 'POST'])
def actualizar_inversion():
    if request.method == 'POST':
        print(request.form.get('clave_tasa'))
        inversion = request.form.to_dict()
        comando = f"UPDATE inversiones SET clave_tasa = '{inversion['clave_tasa']}' WHERE folio_inversion = '{inversion['id']}'"
        print(comando)
        
    
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo modificar la inversión porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('modificar_inversion.html', mensaje=msg)
     

    return render_template('modificar_inversion.html', mensaje = 'Inversión actualizada con éxito')



@app.route('/baja_inversiones', methods=['GET', 'POST'])
def baja_inversiones():
    if request.method == 'POST':
        if 'valores' in request.form:
            valores = json.loads(request.form['valores'])
            print(valores)

            comando = "SELECT * FROM inversiones "
            i = 1
            longitud = len(valores)
            longitud -= 1 if 'null' in valores else 0
            for llave, valor in valores.items():
                if llave != 'null':
                    if i == 1:
                        comando += " WHERE "
                    comando += llave + " = '" + valor+"' "
                    if i < longitud:
                        comando += " AND "
                    i = i + 1
            print(comando)
        else:
            comando = 'SELECT * FROM inversiones'

    resultado, error = conectar_nodo(ESQUEMA_A, comando)
    if not error == '':
        return render_template('baja_inversiones.html', inversiones=[], mensaje=error)
    
    return render_template('baja_inversiones.html', inversiones=resultado, mensaje='')

@app.route('/eliminar_inversion', methods=['GET', 'POST'])
def eliminar_inversion():
    if request.method == 'POST':
        print(request.form.get('id'))
        contrato = request.form.to_dict()
        comando = f"DELETE FROM inversiones WHERE folio_inversion = '{contrato['id']}'"

        print(comando)
        

    
    nodos = verificar_nodos()
    flag = True
    nodosCaidos = []

    for nodo, conexion_exitosa in nodos.items():
        if not conexion_exitosa:
            flag = False
            nodosCaidos.append(nodo)
    
    if flag:
        resultado1, error = conectar_nodo(ESQUEMA_A, comando, True)
        resultado2, error2 = conectar_nodo(ESQUEMA_B, comando, True)
        resultado3, error3 = conectar_nodo(ESQUEMA_C, comando, True)
    else:
        msg = 'No se pudo eliminar la inversión porque no se pudo conectar con todos los nodos: \n'
        for caido in nodosCaidos:
            msg += 'Error al conectar con el nodo {} \n'.format(caido)
        return render_template('baja_inversiones.html', mensaje=msg)
    

    return render_template('baja_inversiones.html', mensaje = 'Inversión eliminado con éxito')

# FIN DE INVERSIONES


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
    app.run(debug=True, host='JESUSLAGUNES', port=5000)
