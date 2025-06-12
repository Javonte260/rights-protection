document.getElementById('affidavitForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const formData = {
        fullName: document.getElementById('fullName').value,
        address: document.getElementById('address').value,
        city: document.getElementById('city').value,
        state: document.getElementById('state').value,
        zip: document.getElementById('zip').value,
        date: document.getElementById('date').value,
        statement: document.getElementById('statement').value
    };

    const affidavitTemplate = `
STATE OF ${formData.state.toUpperCase()}
COUNTY OF ${formData.city.toUpperCase()}

BEFORE ME, the undersigned authority, personally appeared
${formData.fullName.toUpperCase()}, who, being duly sworn, deposes and says:

1. My name is ${formData.fullName.toUpperCase()}, and I am a resident of
${formData.address}, ${formData.city}, ${formData.state} ${formData.zip}.

2. The facts stated in this affidavit are true and correct to the best of my
knowledge and belief.

3. On or about ${formData.date}, the following occurred:

${formData.statement}

4. I declare under penalty of perjury that the foregoing is true and correct.

Executed on ${formData.date}.

____________________________________
${formData.fullName.toUpperCase()}

Subscribed and sworn to before me this ${formData.date}.

____________________________________
Notary Public

My Commission Expires: _______________`;

    document.getElementById('affidavitContent').innerHTML = `
        <pre style="font-family: 'Times New Roman', serif; line-height: 1.5;">
${affidavitTemplate}
        </pre>
    `;
    
    document.getElementById('affidavitPreview').classList.remove('hidden');
});

// Print function
document.getElementById('printAffidavit').addEventListener('click', function() {
    const content = document.getElementById('affidavitContent').innerHTML;
    const printWindow = window.open('', '_blank');
    printWindow.document.write(`
        <html>
        <head>
            <title>Affidavit</title>
            <style>
                body {
                    font-family: 'Times New Roman', serif;
                    line-height: 1.5;
                    margin: 20px;
                }
                pre {
                    white-space: pre-wrap;
                    word-wrap: break-word;
                }
            </style>
        </head>
        <body>
            ${content}
        </body>
        </html>
    `);
    printWindow.document.close();
    printWindow.print();
});
