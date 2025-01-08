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
		const process = spawn(command, [], { shell: true });
		// 標準出力（stdout）のデータをリアルタイムで受け取る
		process.stdout.on('data', (data) => {
			event.reply("command-result", data.toString());
		});

		// 標準エラー出力（stderr）のデータもリアルタイムで受け取る
		process.stderr.on('data', (data) => {
			event.reply("command-result", `ERROR: ${data.toString()}`);
		});

		// プロセス終了時の処理
		process.on('close', (code) => {
			event.reply("command-result", `Process exited with code: ${code}`);
		});
	});
});

app.on("window-all-closed", () => {
	app.quit();
});