function confirmarEliminacion(event) {
    var confirmation = confirm('¿Está seguro de que desea eliminar este cliente?');
    if (!confirmation) {
      event.preventDefault();
    }
  }