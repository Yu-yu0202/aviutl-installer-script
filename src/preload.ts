import { contextBridge, ipcRenderer } from 'electron';
import path from 'path';

contextBridge.exposeInMainWorld('electron', {
    pathJoin: (...args: string[]) => path.join(...args),
    sendCommand: (command: string) => ipcRenderer.send('run-command', command),
    onCommandResult: (callback: (result: { stdOut?: string, Error?: string, exitCode?: number }) => void) => {
        // 'command-result'�C�x���g�����������Ƃ��ɃR�[���o�b�N���Ăяo��
        ipcRenderer.on('command-result', (event, result) => {
            callback(result); // event�𖳎����āAresult������n��
        });
    }
});