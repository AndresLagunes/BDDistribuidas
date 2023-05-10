const contratos = document.querySelectorAll('#mi_Tabla input[name="inversionesClientes"]');
var folioContrato = "";
contratos.forEach((c) => {
  c.addEventListener("click", () => {
    folioContrato = c.parentNode.parentNode.parentNode.getElementsByTagName("td")[0].textContent;
    console.log(
      c.parentNode.parentNode.parentNode.getElementsByTagName("td")[0].textContent
    );
  });
});

const formsContratos = document.querySelectorAll(
  '#mi_Tabla form[name="misInversionesClientes"]'
);
formsContratos.forEach((fC) => {
  fC.addEventListener("submit", (event) => {
    event.preventDefault();

    const folioContratoValor = document.createElement("input");
    folioContratoValor.type = "hidden";
    folioContratoValor.name = "folioContrato";
    folioContratoValor.value = JSON.stringify(folioContrato);
    fC.appendChild(folioContratoValor);
    fC.submit();
  });
});