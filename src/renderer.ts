// renderer.ts

const outputElement = document.getElementById('output') as HTMLElement;

document.getElementById('runButton')?.addEventListener('click', function () {
    try {
        // pathJoin を使用してコマンドのパスを生成
        const command = window.electron.pathJoin(__dirname, 'script_files', 'aviutl-installer.cmd');

        // メインプロセスにコマンドを送信
        window.electron.sendCommand(command);
    } catch (error) {
        outputElement.textContent += 'コマンド送信中にエラーが発生しました: ' + error.message + '\n';
    }
});

// コマンド実行結果を受け取る
window.electron.onCommandResult((result: { stdOut?: string, Error?: string, exitCode?: number }) => {
    const appendOutput = (message: string) => {
        outputElement.textContent += message + '\n';
    };

    if (result.stdOut) {
        appendOutput(result.stdOut);
    }
    if (result.Error) {
        appendOutput('エラー: ' + result.Error);
    }
    if (result.exitCode !== undefined) {
        appendOutput(`プロセスは 停止コード ${result.exitCode} で終了しました`);
    }
});
