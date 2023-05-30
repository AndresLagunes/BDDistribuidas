function confirmarEliminacion(event) {
    var confirmation = confirm('¿Está seguro de que desea eliminar esta inversion?');
    if (!confirmation) {
      event.preventDefault();
    }
  }