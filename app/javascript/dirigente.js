// Dati di esempio per i dirigenti
const employees = [
    { firstName: 'Mario', lastName: 'Rossi', phone: '333 123 4567', email: 'mario.rossi@example.com', company: 'TechCorp', description: 'CEO di TechCorp', salary: { Gennaio: '5000€', Febbraio: '5100€', Marzo: '5200€' }, 
      workSchedule: { monday: { entry: '08:00', exit: '17:00' }, tuesday: { entry: '08:30', exit: '17:30' }, wednesday: { entry: '09:00', exit: '18:00' }, 
                     thursday: { entry: '08:15', exit: '17:15' }, friday: { entry: '08:45', exit: '17:45' } },
      salary: { Jan: '5000€', Feb: '5100€', Mar: '5200€', Apr: '5000€', Mar: '5100€', Giu: '5200€', Lug: '5000€', Ago: '5100€', Set: '5200€', Ott: '5000€', Nov: '5100€', Dic: '5200€' },
      leave: { taken: 10, left: 15 } },
    { firstName: 'Luigi', lastName: 'Bianchi', phone: '347 987 6543', email: 'luigi.bianchi@example.com', company: 'WebSolutions', description: 'CTO di WebSolutions', salary: { Gennaio: '4800€', Febbraio: '4850€', Marzo: '4900€' }, 
      workSchedule: { monday: { entry: '09:00', exit: '18:00' }, tuesday: { entry: '09:30', exit: '18:30' }, wednesday: { entry: '08:45', exit: '17:45' }, 
                     thursday: { entry: '09:15', exit: '18:15' }, friday: { entry: '09:00', exit: '18:00' } },
      salary: { Jan: '5000€', Feb: '5100€', Mar: '5200€', Apr: '5000€', Mar: '5100€', Giu: '5200€', Lug: '5000€', Ago: '5100€', Set: '5200€', Ott: '5000€', Nov: '5100€', Dic: '5200€' },
      leave: { taken: 10, left: 15 } },
    { firstName: 'Anna', lastName: 'Verdi', phone: '06 555 1212', email: 'anna.verdi@example.com', company: 'DesignPro', description: 'CFO di DesignPro', salary: { Gennaio: '4900€', Febbraio: '4950€', Marzo: '5000€' }, 
      workSchedule: { monday: { entry: '08:30', exit: '17:30' }, tuesday: { entry: '09:00', exit: '18:00' }, wednesday: { entry: '08:45', exit: '17:45' }, 
                     thursday: { entry: '08:45', exit: '17:45' }, friday: { entry: '09:15', exit: '18:15' } },
      salary: { Jan: '5000€', Feb: '5100€', Mar: '5200€', Apr: '5000€', Mar: '5100€', Giu: '5200€', Lug: '5000€', Ago: '5100€', Set: '5200€', Ott: '5000€', Nov: '5100€', Dic: '5200€' },
      leave: { taken: 10, left: 15 } },
];


const months = ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'];

// Popola il menu a tendina dei dirigenti
const employeeSelect = document.getElementById('employeeSelect');
employees.forEach((employee, index) => {
    const option = document.createElement('option');
    option.value = index;
    option.textContent = `${employee.firstName} ${employee.lastName}`;
    employeeSelect.appendChild(option);
});

// Mostra i dettagli del dirigente selezionato
function showEmployeeDetails() {
    const selectedIndex = employeeSelect.value;
    if (selectedIndex === "") return;
    const employee = employees[selectedIndex];
    document.getElementById('employeeFirstName').textContent = employee.firstName;
    document.getElementById('employeeLastName').textContent = employee.lastName;
    document.getElementById('employeePhone').value = employee.phone;
    document.getElementById('employeeEmail').value = employee.email;
    document.getElementById('employeeCompany').value = employee.company;
    document.getElementById('employeeDescription').value = employee.description;

    document.getElementById('employeeDetails').style.display = 'block';
    document.getElementById('saveButton').disabled = true; // Disabilita il pulsante Salva
    document.getElementById('salaryInfo').style.display = 'none';
}

// Abilita il pulsante Salva se i campi modificabili vengono modificati
function enableSaveButton() {
    document.getElementById('saveButton').disabled = false;
}

// Salva i dettagli modificati del dirigente
function saveEmployeeDetails() {
    const selectedIndex = employeeSelect.value;
    if (selectedIndex === "") return;
    const employee = employees[selectedIndex];
    employee.company = document.getElementById('employeeCompany').value;
    employee.description = document.getElementById('employeeDescription').value;
    document.getElementById('saveButton').disabled = true; // Disabilita il pulsante Salva
    alert('Dettagli salvati con successo!');
}

// Chiama le funzioni per mostrare le info
function showInfo() {
    showSalaryInfo();
    showLeaveInfo();
    showWorkSchedule();
}

// Mostra le informazioni sullo stipendio
function showSalaryInfo() {
    document.getElementById('salaryInfo').style.display = 'block';
    const selectedIndex = employeeSelect.value;
    if (selectedIndex === "") return;

    const employee = employees[selectedIndex];
    const selectedMonth = document.getElementById('monthSelect').value;

    if (selectedMonth === "") return;

    const salaryInfo = employee.salary[selectedMonth];

    // Mostra le informazioni sugli stipendi senza nascondere le altre sezioni
    document.getElementById('employeeDetails').classList.add('active');
    document.getElementById('salaryInfo').classList.add('active');
    document.getElementById('salaryAmount').textContent = salaryInfo;

    // Nascondi eventualmente altre sezioni non necessarie
    document.getElementById('workSchedule').classList.remove('active');
}

// Mostra lo stipendio per il mese selezionato
function showSalary() {
    const selectedIndex = employeeSelect.value;
    const selectedMonth = monthSelect.value;
    if (selectedIndex === "" || selectedMonth === "") return;
    const employee = employees[selectedIndex];
    const salary = employee.salary[getMonthName(selectedMonth)];
    document.getElementById('salaryAmount').textContent = salary ? salary : 'N/A';
}

function getMonthName(monthNumber) {
    const monthNames = { 1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun', 7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec' };
    return monthNames[monthNumber];
}
        
// Mostra l'orario di lavoro del dirigente selezionato
    function showWorkSchedule() {
        document.getElementById('workSchedule').style.display = 'block';
        const selectedIndex = employeeSelect.value;
        if (selectedIndex === "") return;

        const employee = employees[selectedIndex];
        const workSchedule = employee.workSchedule;

        // Mostra l'orario di lavoro del dirigente senza nascondere le altre sezioni
        document.getElementById('workSchedule').classList.add('active');
        document.getElementById('mondayEntry').textContent = workSchedule.monday.entry;
        document.getElementById('mondayExit').textContent = workSchedule.monday.exit;
        document.getElementById('tuesdayEntry').textContent = workSchedule.tuesday.entry;
        document.getElementById('tuesdayExit').textContent = workSchedule.tuesday.exit;
        document.getElementById('wednesdayEntry').textContent = workSchedule.wednesday.entry;
        document.getElementById('wednesdayExit').textContent = workSchedule.wednesday.exit;
        document.getElementById('thursdayEntry').textContent = workSchedule.thursday.entry;
        document.getElementById('thursdayExit').textContent = workSchedule.thursday.exit;
        document.getElementById('fridayEntry').textContent = workSchedule.friday.entry;
        document.getElementById('fridayExit').textContent = workSchedule.friday.exit;
}

// Mostra le informazioni sui giorni di ferie del dirigente selezionato
function showLeaveInfo() {
    document.getElementById('leaveInfo').style.display = 'block';
    const selectedIndex = employeeSelect.value;
    if (selectedIndex === "") return;
    const employee = employees[selectedIndex];

    // Aggiorna le informazioni sui giorni di ferie
    document.getElementById('daysTaken').value = employee.leave.taken;
    document.getElementById('daysLeft').value = employee.leave.left;

    // Mostra la sezione delle ferie senza nascondere le altre sezioni
    document.getElementById('leaveInfo').classList.add('active');
}

function hideSections() {
    const sections = document.querySelectorAll('.employee-section');
    sections.forEach(section => {
        section.classList.remove('active');
    });
}

// Funzione per salvare le modifiche ai giorni di ferie
function saveLeaveDays() {
    const selectedIndex = employeeSelect.value;
    if (selectedIndex === "") return;
    const employee = employees[selectedIndex];
    
    // Aggiorna i giorni di ferie presi e rimasti
    employee.leave.taken = document.getElementById('daysTaken').value;
    employee.leave.left = document.getElementById('daysLeft').value;
    document.getElementById('saveLeaveButton').disabled = true; // Disabilita il pulsante Salva

    // Aggiungi eventuali azioni aggiuntive come feedback all'utente
    alert('Modifiche ai giorni di ferie salvate con successo.');
}
// Abilita il pulsante Salva se i campi modificabili vengono modificati
function enableSaveLeaveButton() {
    document.getElementById('saveLeaveButton').disabled = false;
}