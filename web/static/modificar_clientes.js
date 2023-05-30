function enviarDatosCliente(clienteId) {
    var filaCliente = document.getElementById(clienteId);

    // Obtener los datos del cliente de la fila correspondiente
    var rfc = filaCliente.cells[0].innerText;
    var nombre = filaCliente.cells[1].innerText;
    var apellidoPaterno = filaCliente.cells[2].innerText;
    var apellidoMaterno = filaCliente.cells[3].innerText;
    var direccion = filaCliente.cells[4].innerText;
    var telefono = filaCliente.cells[5].innerText;
    var email = filaCliente.cells[6].innerText;
    var sucursal = filaCliente.cells[7].innerText;

    // Crear un formulario y agregar los datos del cliente como campos ocultos
    var form = document.createElement('form');
    form.method = 'post';
    form.action = '/modificar_cliente';

    var inputRFC = document.createElement('input');
    inputRFC.type = 'hidden';
    inputRFC.name = 'rfc';
    inputRFC.value = rfc;
    form.appendChild(inputRFC);

    var inputNombre = document.createElement('input');
    inputNombre.type = 'hidden';
    inputNombre.name = 'nombre';
    inputNombre.value = nombre;
    form.appendChild(inputNombre);

    var inputApellidoP = document.createElement('input');
    inputApellidoP.type = 'hidden';
    inputApellidoP.name = 'apellidoPaterno';
    inputApellidoP.value = apellidoPaterno;
    form.appendChild(inputApellidoP);

    var inputApellidoM = document.createElement('input');
    inputApellidoM.type = 'hidden';
    inputApellidoM.name = 'apellidoMaterno';
    inputApellidoM.value = apellidoMaterno;
    form.appendChild(inputApellidoM);

    var inputDireccion = document.createElement('input');
    inputDireccion.type = 'hidden';
    inputDireccion.name = 'direccion';
    inputDireccion.value = direccion;
    form.appendChild(inputDireccion);

    var inputTelefono = document.createElement('input');
    inputTelefono.type = 'hidden';
    inputTelefono.name = 'telefono';
    inputTelefono.value = telefono;
    form.appendChild(inputTelefono);

    var inputEmail = document.createElement('input');
    inputEmail.type = 'hidden';
    inputEmail.name = 'email';
    inputEmail.value = email;
    form.appendChild(inputEmail);
    
    var inputSucursal = document.createElement('input');
    inputSucursal.type = 'hidden';
    inputSucursal.name = 'sucursal';
    inputSucursal.value = sucursal;
    form.appendChild(inputSucursal);
    

    // Agrega el formulario al cuerpo del documento y envíalo
    document.body.appendChild(form);
    console.log(form)
    form.submit();
  }