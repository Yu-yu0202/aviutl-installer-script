import { app, BrowserWindow, ipcMain } from 'electron';
import * as path from 'path';
import { exec } from 'child_process';

function createWindow() {
    const mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: path.join(__dirname, 'preload.js'),
            nodeIntegration: false,
            contextIsolation: true,
        },
    });

    mainWindow.loadFile('index.html');
}

app.on('ready', createWindow);

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
        createWindow();
    }
});

ipcMain.on('run-installer', () => {
    const installer = exec('cmd.exe /c aviutl-installer.cmd');

    installer.stdout?.on('data', (data) => {
        console.log(`Stdout: ${data}`);
    });

    installer.stderr?.on('data', (data) => {
        console.error(`Stderr: ${data}`);
    });

    installer.on('error', (error) => {
        console.error(`Error: ${error.message}`);
    });

    installer.on('close', (code) => {
        console.log(`Installer exited with code ${code}`);
    });
});