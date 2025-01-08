const { exec } = require('child_process');
const path = require('path')


document.getElementById('runButton').addEventListener('click', function () {
	exec(path.join(__dirname, 'script_files', 'aviutl-installer.cmd'), (error, stdout, stderr) => {
		const outputElement = document.getElementById('output');
		if (error) {
			outputElement.textContent = `エラー: ${error.message}`;
			return;
		}
		if (stdout) {
			outputElement.textContent = stdout;
		}
		if (stderr) {
			outputElement.textContent += `\nエラー: ${stderr}`;
		}
	});
});
