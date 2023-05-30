function enviarDatosInversion(inversionId) {
    var filaContrato = document.getElementById(inversionId);

    // Obtener los datos del cliente de la fila correspondiente
    var id = filaContrato.cells[0].innerText;
    var sucursal = filaContrato.cells[1].innerText;
    var rfc_cliente = filaContrato.cells[2].innerText;
    var fecha_inicio = filaContrato.cells[3].innerText;
    var fecha_vencimiento = filaContrato.cells[4].innerText;
    var folio_contrato = filaContrato.cells[5].innerText;

    // Crear un formulario y agregar los datos del cliente como campos ocultos
    var form = document.createElement('form');
    form.method = 'post';
    form.action = '/modificar_cliente';

    var inputId = document.createElement('input');
    inputId.type = 'hidden';
    inputId.name = 'id';
    inputId.value = id;
    form.appendChild(inputId);

    var inputRfcCliente = document.createElement('input');
    inputRfcCliente.type = 'hidden';
    inputRfcCliente.name = 'rfc_cliente';
    inputRfcCliente.value = rfc_cliente;
    form.appendChild(inputRfcCliente);

    var inputFechaInicio = document.createElement('input');
    inputFechaInicio.type = 'hidden';
    inputFechaInicio.name = 'fecha_inicio';
    inputFechaInicio.value = fecha_inicio;
    form.appendChild(inputFechaInicio);

    var inputFechaVencimiento = document.createElement('input');
    inputFechaVencimiento.type = 'hidden';
    inputFechaVencimiento.name = 'fecha_vencimiento';
    inputFechaVencimiento.value = fecha_vencimiento;
    form.appendChild(inputFechaVencimiento);

    var inputFolioContrato = document.createElement('input');
    inputFolioContrato.type = 'hidden';
    inputFolioContrato.name = 'folio_contrato';
    inputFolioContrato.value = folio_contrato;
    form.appendChild(inputFolioContrato);
    
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