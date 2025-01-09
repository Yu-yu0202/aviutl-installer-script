const { app, BrowserWindow, ipcMain } = require('electron');
const { spawn } = require('child_process');
const path = require('path');

let mainWindow;

app.on("ready", () => {
    mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: path.join('./preload.js'),
            nodeIntegration: false,
            contextIsolation: true,
            devTools: true
        }
    });

    mainWindow.loadFile("index.html");

    ipcMain.on("run-command", (event, command) => {
        const process = spawn(command, [], { shell: true });

        process.stdout.on('data', (data) => {
            console.log(`stdout: ${data.toString()}`);
            event.reply("command-result", { stdOut: data.toString() });
        });

        process.stderr.on('data', (data) => {
            console.error(`stderr: ${data.toString()}`);
            event.reply("command-result", { Error: data.toString() });
        });

        process.on('close', (code) => {
            event.reply("command-result", { exitCode: code });
        });
    });
});

app.on("window-all-closed", () => {
    app.quit();
});
