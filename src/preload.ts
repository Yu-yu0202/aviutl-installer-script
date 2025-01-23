import { contextBridge, ipcRenderer } from 'electron';

contextBridge.exposeInMainWorld('electron', {
    runInstaller: () => ipcRenderer.send('run-installer'),
});