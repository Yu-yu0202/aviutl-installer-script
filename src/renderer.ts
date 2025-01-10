// renderer.ts

const outputElement = document.getElementById('output') as HTMLElement;

document.getElementById('runButton')?.addEventListener('click', function () {
    // pathJoin を使用してコマンドのパスを生成
    const command = window.electron.pathJoin(__dirname, 'script_files', 'aviutl-installer.cmd');

    // メインプロセスにコマンドを送信
    window.electron.sendCommand(command);
});

// コマンド実行結果を受け取る
window.electron.onCommandResult((result: { stdOut?: string, Error?: string, exitCode?: number }) => {
    if (result.stdOut) {
        outputElement.textContent += result.stdOut + '\n';
    }
    if (result.Error) {
        outputElement.textContent += 'エラー: ' + result.Error + '\n';
    }
    if (result.exitCode !== undefined) {
        outputElement.textContent += `プロセスは 停止コード ${result.exitCode} で終了しました\n`;
    }
});
