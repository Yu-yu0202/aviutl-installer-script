// electron.d.ts
declare global {
    interface Window {
        electron: {
            pathJoin: (...args: string[]) => string;
            sendCommand: (command: string) => void;
            onCommandResult: (callback: (result: { stdOut?: string, Error?: string, exitCode?: number }) => void) => void;
        };
    }
}

// ���̃t�@�C�������W���[���Ƃ��ĔF�������邽�߂ɁA�Ō�ɋ�̃G�N�X�|�[�g��ǉ�
export { };