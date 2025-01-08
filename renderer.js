const { exec } = require('child_process');
const path = require('path')


document.getElementById('runButton').addEventListener('click', function () {
    const command = path.join(__dirname, 'script_files', 'aviutl-installer.cmd');
    ipcRenderer.send('run-command', command);
});

ipcRenderer.on('command-result', (event, data) => {
    const outputElement = document.getElementById('output');
    outputElement.textContent += data + '\n';  
});