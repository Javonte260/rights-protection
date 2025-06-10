// Constitutional rights data
const CONSTITUTIONAL_RIGHTS = [
    { title: "First Amendment - Freedom of Speech, Religion, Press, Assembly, and Petition" },
    { title: "Second Amendment - Right to Keep and Bear Arms" },
    { title: "Third Amendment - Protection from Quartering of Troops" },
    { title: "Fourth Amendment - Protection from Unreasonable Searches and Seizures" },
    { title: "Fifth Amendment - Due Process, Double Jeopardy, Self-Incrimination, Takings" },
    { title: "Sixth Amendment - Rights to Fair Trial" },
    { title: "Seventh Amendment - Trial by Jury in Civil Cases" },
    { title: "Eighth Amendment - Protection from Excessive Bail, Fines, and Cruel Punishments" },
    { title: "Ninth Amendment - Protection of Rights Not Specifically Enumerated" },
    { title: "Tenth Amendment - States' Rights" },
    // Add more rights as needed
];

// Document template
template = `CONSTITUTIONAL RIGHTS PROTECTION DOCUMENT

This document serves as a formal declaration and reservation of all constitutional rights 
protected by the Constitution for the United States of America.

Name: [fullName]
Social Security Number (Last 4 digits): [ssn]
Date of Birth: [dob]
Date of Declaration: [currentDate]

I hereby declare and reserve all of my constitutional rights as enumerated in the 
Constitution for the United States of America, including but not limited to:

${CONSTITUTIONAL_RIGHTS.map(right => `• ${right.title}`).join('\n')}

This document serves as notice to all parties that any violation of the rights herein 
reserved shall be subject to penalties as outlined in the attached fee schedule.

Signature: _____________________________
Date: ___________________________________

NOTICE: This document is for personal record-keeping purposes only and does not 
constitute legal advice. For specific legal matters, consult with a licensed attorney.`;

// DOM Elements
const documentForm = document.getElementById('documentForm');
const feeScheduleSection = document.getElementById('fee-schedule');
const previewSection = document.getElementById('preview');
const documentPreview = document.getElementById('documentPreview');
const feeTableBody = document.getElementById('feeTableBody');

// Event Listeners
documentForm.addEventListener('submit', handleDocumentGeneration);

// Functions
function handleDocumentGeneration(e) {
    e.preventDefault();
    
    // Get form data
    const formData = new FormData(e.target);
    const fullName = formData.get('fullName');
    const ssn = formData.get('ssn');
    const dob = formData.get('dateOfBirth');
    const currentDate = new Date().toLocaleDateString();

    // Generate document
    const documentText = template
        .replace('[fullName]', fullName)
        .replace('[ssn]', ssn)
        .replace('[dob]', dob)
        .replace('[currentDate]', currentDate);

    // Show document preview
    documentPreview.innerHTML = `
        <pre>${documentText}</pre>
        <button id="printDocument" onclick="window.print()">Print Document</button>
    `;
    
    // Show fee schedule section
    feeScheduleSection.classList.remove('hidden');
    previewSection.classList.remove('hidden');
    
    // Generate fee schedule table
    generateFeeSchedule();
}

function generateFeeSchedule() {
    feeTableBody.innerHTML = CONSTITUTIONAL_RIGHTS.map(right => `
        <tr>
            <td>${right.title}</td>
            <td><input type="number" class="fee-input" min="0" value="0" step="100"></td>
        </tr>
    `).join('');
}

// Save fee schedule
document.getElementById('saveFees').addEventListener('click', () => {
    const fees = Array.from(document.querySelectorAll('.fee-input'))
        .map(input => ({
            right: input.parentElement.previousElementSibling.textContent,
            amount: parseFloat(input.value) || 0
        }));
    
    // Generate fee schedule document
    const feeScheduleText = `CONSTITUTIONAL RIGHTS VIOLATION FEE SCHEDULE

Name: ${document.getElementById('fullName').value}
Date: ${new Date().toLocaleDateString()}

${fees.map(fee => `${fee.right}: $${fee.amount.toLocaleString()}`).join('\n\n')}

Signature: _____________________________
Date: ___________________________________`;

    // Create download link
    const blob = new Blob([feeScheduleText], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'rights_fee_schedule.txt';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
});

// Add error handling for DOM elements
if (!documentForm) {
    console.error('Document form not found');
}
if (!feeScheduleSection) {
    console.error('Fee schedule section not found');
}
if (!previewSection) {
    console.error('Preview section not found');
}
