function validarFormulario() {
    var tasa = document.getElementById('tasa').value;
    var tipoInversion = document.getElementById('tipo_de_inversion').value;
    var montoInversion = document.getElementById('monto_de_inversion').value;

    // var tasaPattern = /^[A-Za-z0-9\s]+$/; // Modifica según el formato que necesites
    var montoPattern = /^\d+(\.\d{1,2})?$/; // Formato de número decimal con máximo 2 decimales

    if (tasa === '' || tipoInversion === '' || montoInversion === '') {
        alert('Por favor, completa todos los campos del formulario');
        return false;
    }

    if (!tasaPattern != "") {
        alert('Tasa no válida. Seleccione una tasa.');
        return false;
    }

    if (!montoPattern.test(montoInversion)) {
        alert('Monto de inversión no válido. Utiliza un formato de número decimal válido (por ejemplo, 1000 o 1000.50).');
        return false;
    }

    console.log('Formulario validado con éxito. Enviando...');
    return true;
}

document.getElementById('monto_de_inversion_input').addEventListener('input', function (e) {
    e.target.value = parseFloat(e.target.value.replace(/[^\d\.]/g, '')).toFixed(2);
    if(isNaN(e.target.value)) {
        e.target.value = "";
    }
});
