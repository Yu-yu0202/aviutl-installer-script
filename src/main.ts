import { app, BrowserWindow, ipcMain } from 'electron';
import { spawn } from 'child_process';
import path from 'path';

let mainWindow: BrowserWindow;

app.on('ready', () => {
	mainWindow = new BrowserWindow({
		width: 800,
		height: 600,
		webPreferences: {
			preload: path.join(__dirname, 'preload.js'),
			nodeIntegration: false,
			contextIsolation: true,
			devTools: true,
		},
	});

	mainWindow.loadFile(path.Join(__dirname, 'index.html'));

	ipcMain.on('run-command', (event, command) => {
		const process = spawn(command, [], { shell: true });

		process.stdout.on('data', (data) => {
			console.log(`stdout: ${data.toString()}`);
			event.reply('command-result', { stdOut: data.toString() });
		});

		process.stderr.on('data', (data) => {
			console.error(`stderr: ${data.toString()}`);
			event.reply('command-result', { Error: data.toString() });
		});

		process.on('close', (code) => {
			event.reply('command-result', { exitCode: code });
		});
	});
});

app.on('window-all-closed', () => {
	app.quit();
});
