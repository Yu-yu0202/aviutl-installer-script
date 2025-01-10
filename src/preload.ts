import { contextBridge, ipcRenderer } from 'electron';
import path from 'path';

contextBridge.exposeInMainWorld('electron', {
    pathJoin: (...args: string[]) => path.join(...args),
    sendCommand: (command: string) => ipcRenderer.send('run-command', command),
    onCommandResult: (callback: (result: { stdOut?: string, Error?: string, exitCode?: number }) => void) => {
        // 'command-result'イベントが発生したときにコールバックを呼び出す
        ipcRenderer.on('command-result', (event, result) => {
            callback(result); // eventを無視して、resultだけを渡す
        });
    }
});