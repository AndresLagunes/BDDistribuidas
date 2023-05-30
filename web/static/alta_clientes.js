function validarFormulario() {
  var rfc = document.getElementById("rfc").value;
  var nombre = document.getElementById("nombre").value;
  var apellido_paterno = document.getElementById("apellido_paterno").value;
  var apellido_materno = document.getElementById("apellido_materno").value;
  var direccion = document.getElementById("direccion").value;
  var telefono = document.getElementById("telefono").value;
  var email = document.getElementById("email").value;

  var rfcPattern = /^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}?$/; // Modifica según el formato que necesites
  var nombrePattern = /^[a-zA-Z\s]+$/;
  var telefonoPattern = /^[0-9]{10}$/; // Modifica según el formato que necesites
  var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (
    rfc === "" ||
    nombre === "" ||
    apellido_paterno === "" ||
    apellido_materno === "" ||
    direccion === "" ||
    telefono === "" ||
    email === ""
  ) {
    alert("Por favor, completa todos los campos del formulario");
    return false;
  }

  if (!rfcPattern.test(rfc)) {
    alert(
      "RFC no es válido. Debe ser de 4 letras mayúsculas seguidas de 6 dígitos y opcionalmente 3 caracteres alfanuméricos."
    );
    return false;
  }

  if (
    !nombrePattern.test(nombre) ||
    !nombrePattern.test(apellido_paterno) ||
    !nombrePattern.test(apellido_materno)
  ) {
    alert("Los nombres y apellidos solo pueden contener letras y espacios");
    return false;
  }

  if (!telefonoPattern.test(telefono)) {
    alert("Número de teléfono no válido. Debe contener 10 dígitos.");
    return false;
  }

  if (!emailPattern.test(email)) {
    alert("Email no es válido");
    return false;
  }

  console.log("Formulario validado con éxito. Enviando...");
  return true;
}
