const { contextBridge, ipcRenderer } = require('electron');
const path = require('path');

// preload.js
contextBridge.exposeInMainWorld('electron', {
    pathJoin: (...args) => path.join(...args),
    sendCommand: (command) => ipcRenderer.send('run-command', command),
    onCommandResult: (callback) => ipcRenderer.on('command-result', callback)
});
