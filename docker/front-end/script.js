const API_URL = "http://localhost:8080/api/employees";

// Récupérer les éléments du DOM
const employeeForm = document.getElementById("employeeForm");
const employeeTable = document.getElementById("employeeTable").getElementsByTagName("tbody")[0];
const submitButton = document.getElementById("submitButton");

// Fonction pour charger et afficher les employés
async function loadEmployees() {
    const response = await fetch(API_URL);
    const employees = await response.json();

    employeeTable.innerHTML = ""; // Vider le tableau

    employees.forEach(employee => {
        const row = employeeTable.insertRow();
        row.innerHTML = `
            <td>${employee.id}</td>
            <td>${employee.name}</td>
            <td>${employee.email}</td>
            <td>${employee.address}</td>
            <td>${employee.phone}</td>
            <td class="actions">
                <button class="edit" onclick="editEmployee(${employee.id})">Modifier</button>
                <button class="delete" onclick="deleteEmployee(${employee.id})">Supprimer</button>
            </td>
        `;
    });
}

// Fonction pour ajouter ou modifier un employé
employeeForm.addEventListener("submit", async (event) => {
    event.preventDefault();

    const formData = new FormData(employeeForm);
    const employee = {
        name: formData.get("name"),
        email: formData.get("email"),
        address: formData.get("address"),
        phone: formData.get("phone")
    };

    const id = formData.get("id");
    const method = id ? "PUT" : "POST";
    const url = id ? `${API_URL}/${id}` : API_URL;

    await fetch(url, {
        method: method,
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(employee)
    });

    employeeForm.reset();
    submitButton.textContent = "Ajouter";
    loadEmployees();
});

// Fonction pour éditer un employé
async function editEmployee(id) {
    const response = await fetch(`${API_URL}/${id}`);
    const employee = await response.json();

    document.getElementById("employeeId").value = employee.id;
    document.getElementById("name").value = employee.name;
    document.getElementById("email").value = employee.email;
    document.getElementById("address").value = employee.address;
    document.getElementById("phone").value = employee.phone;

    submitButton.textContent = "Modifier";
}

// Fonction pour supprimer un employé
async function deleteEmployee(id) {
    await fetch(`${API_URL}/${id}`, {
        method: "DELETE"
    });
    loadEmployees();
}

// Charger les employés au démarrage
loadEmployees();