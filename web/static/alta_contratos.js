function validarFormulario() {
  var cliente = document.getElementById("cliente").value;
  var fechaInicio = document.getElementById("fecha_inicio").value;
  var fechaFin = document.getElementById("fecha_vencimiento").value;

  var clientePattern = /^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$/; // Modifica según el formato que necesites
  var fechaPattern = /^\d{4}-\d{2}-\d{2}$/; // Formato yyyy-mm-dd

  if (cliente === "" || fechaInicio === "" || fechaFin === "") {
    alert("Por favor, completa todos los campos del formulario");
    return false;
  }

  if (!clientePattern.test(cliente)) {
    alert(
      "RFC no es válido. Debe ser de 4 letras mayúsculas seguidas de 6 dígitos y opcionalmente 3 caracteres alfanuméricos."
    );
    return false;
  }

  if (!fechaPattern.test(fechaInicio) || !fechaPattern.test(fechaFin)) {
    alert("Fecha no válida. Utiliza el formato yyyy-mm-dd");
    return false;
  }

  console.log("Formulario validado con éxito. Enviando...");
  return true;
}
