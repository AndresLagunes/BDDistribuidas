const clientes = document.querySelectorAll('#miTabla input[name="ganancias"]');
var rfc = "";
console.log(clientes)
clientes.forEach((c) => {
  c.addEventListener("click", () => {
    rfc = c.parentNode.parentNode.parentNode.getElementsByTagName("td")[0].textContent;
    console.log(
      c.parentNode.parentNode.parentNode.getElementsByTagName("td")[0].textContent
    );
  });
});

const formsClientes = document.querySelectorAll(
  '#miTabla form[name="misGanancias"]'
);
formsClientes.forEach((fC) => {
  fC.addEventListener("submit", (event) => {
    event.preventDefault();

    const rfcValor = document.createElement("input");
    rfcValor.type = "hidden";
    rfcValor.name = "rfc";
    rfcValor.value = JSON.stringify(rfc);
    fC.appendChild(rfcValor);
    fC.submit();
  });
});
