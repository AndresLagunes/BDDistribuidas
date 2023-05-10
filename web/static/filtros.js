// Selecciona los headers de la tabla
const headers = document.querySelectorAll('#miTabla th');

// Agrega un listener de eventos para el clic del mouse en cada header
headers.forEach(header => {
header.addEventListener('click', () => {
    if(header.getAttribute('name') != 'ganancias'){
        // Crea un input en el lugar del header
        const input = document.createElement('input');
        input.value = header.textContent;
        header.textContent = '';
        header.appendChild(input);
        input.focus();
    }
    
    });
});

// Agrega una función para manejar el envío del formulario
const form = document.querySelector('#miFormulario');
form.addEventListener('submit', (event) => {
// Previene el envío del formulario
event.preventDefault();

// Obtiene los valores de los inputs
const inputs = document.querySelectorAll('#miTabla input:not([name="ganancias"])');
const valores = [];
const map = new Map();
inputs.forEach(input => {
    console.log(input.parentNode.getAttribute('name'));
    console.log(input.value)
    map.set(input.parentNode.getAttribute('name'), input.value);
    valores.push(input.value);
});
console.log(map)


// Agrega los valores al formulario
const inputValores = document.createElement('input');
inputValores.type = 'hidden';
inputValores.name = 'valores';
const obj = Object.fromEntries([...map]);
inputValores.value = JSON.stringify(obj);
form.appendChild(inputValores);

// Envía el formulario
console.log("????")
form.submit();
});