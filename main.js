const { app, BrowserWindow, ipcMain } = require('electron')
const { exec } = require('child_process')

let mainWindow;

app.on("ready", () => {
	// GUIを初期化
	mainWindow = new BrowserWindow({
		width: 800,
		height: 600,
		webPreferences: {
			nodeIntegration: true,
			contextIsolation: false,
		},
	});

	mainWindow.loadFile("index.html")

	// command execの設定
	ipcMain.on("run-command", (event, command) => {
		exec(command, (error, stdout, stderr) => {
			if (error) {
				console.error(`Error: ${error.message}`)
				event.reply("command-result", `Error: ${error.message}`)
				return;
			}
			if (stderr) {
				console.error(`Stderr: ${stderr}`);
				event.reply("command-result", `Stderr: stderr`)
				return;
			}
			event.reply("command-result", stdout)
		});
	});
});

app.on("window-all-closed", () => {
	app.quit();
});