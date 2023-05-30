function confirmarEliminacion(event) {
    var confirmation = confirm('¿Está seguro de que desea eliminar este contrato?');
    if (!confirmation) {
      event.preventDefault();
    }
  }