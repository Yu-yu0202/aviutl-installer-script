@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

#
#   MIT License
#
#   Copyright (c) 2025 menndouyukkuri, atolycs, Yu-yu0202
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.
#

# GitHub���|�W�g���̍ŐV�Ń����[�X�̃_�E�����[�hURL���擾����
function GithubLatestReleaseUrl ($repo) {
    # GitHub��API����ŐV�Ń����[�X�̏����擾����
    $api = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/latest"

    # �ŐV�Ń����[�X�̃_�E�����[�hURL�݂̂�Ԃ�
    return($api.assets.browser_download_url)
}

Write-Host "AviUtl Installer Script (Version 1.0.9b1_2025-01-08)`r`n`r`n"

# �J�����g�f�B���N�g���̃p�X�� $scriptFileRoot �ɕۑ� (�N�����@�̂����� $PSScriptRoot ���g�p�ł��Ȃ�����)
$scriptFileRoot = (Get-Location).Path

Write-Host -NoNewline "AviUtl���C���X�g�[������t�H���_���쐬���Ă��܂�..."

# C:\Applications �f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications -ItemType Directory -Force" -WindowStyle Minimized -Wait

# C:\Applications\AviUtl �f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl �f�B���N�g������ plugins, script, license, readme ��4�̃f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\plugins, C:\Applications\AviUtl\script, C:\Applications\AviUtl\license, C:\Applications\AviUtl\readme -ItemType Directory -Force" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "`r`n�ꎞ�I�Ƀt�@�C����ۊǂ���t�H���_���쐬���Ă��܂�..."

# tmp �f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item tmp -ItemType Directory -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location tmp

Write-Host "����"
Write-Host -NoNewline "`r`nAviUtl�{�� (version 1.10) ���_�E�����[�h���Ă��܂�..."

# AviUtl version 1.10��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL http://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "AviUtl�{�̂��C���X�g�[�����Ă��܂�..."

# AviUtl��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path aviutl110.zip -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g���� aviutl110 �f�B���N�g���ɕύX
Set-Location aviutl110

# AviUtl\readme ���� aviutl �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\aviutl -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl �f�B���N�g������ aviutl.exe ���AAviUtl\readme\aviutl ���� aviutl.txt �����ꂼ��ړ�
Move-Item aviutl.exe C:\Applications\AviUtl -Force
Move-Item aviutl.txt C:\Applications\AviUtl\readme\aviutl -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`n�g���ҏWPlugin version 0.92���_�E�����[�h���Ă��܂�..."

# �g���ҏWPlugin version 0.92��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL http://spring-fragrance.mints.ne.jp/aviutl/exedit92.zip" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "�g���ҏWPlugin���C���X�g�[�����Ă��܂�..."

# �g���ҏWPlugin��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path exedit92.zip -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g���� exedit92 �f�B���N�g���ɕύX
Set-Location exedit92

# AviUtl\readme ���� exedit �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\exedit -ItemType Directory -Force" -WindowStyle Minimized -Wait

# exedit.ini �͎g�p�����A�����̌�̏����Ŏז��ɂȂ�̂ō폜���� (�ҋ@)
Start-Process powershell -ArgumentList "-command Remove-Item exedit.ini" -WindowStyle Minimized -Wait

# AviUtl\readme\exedit ���� exedit.txt, lua.txt �� (�ҋ@) �AAviUtl �f�B���N�g�����ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item *.txt C:\Applications\AviUtl\readme\exedit -Force" -WindowStyle Minimized -Wait
Move-Item * C:\Applications\AviUtl -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`npatch.aul (�䂳���ȃt�H�[�N��) �̍ŐV�ŏ����擾���Ă��܂�..."

# patch.aul (�䂳���ȃt�H�[�N��) �̍ŐV�ł̃_�E�����[�hURL���擾
$patchAulUrl = GithubLatestReleaseUrl "nazonoSAUNA/patch.aul"

Write-Host "����"
Write-Host -NoNewline "patch.aul (�䂳���ȃt�H�[�N��) ���_�E�����[�h���Ă��܂�..."

# patch.aul (�䂳���ȃt�H�[�N��) ��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $patchAulUrl" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "patch.aul (�䂳���ȃt�H�[�N��) ���C���X�g�[�����Ă��܂�..."

# patch.aul��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path patch.aul_*.zip -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g����patch.aul��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "patch.aul_*"

# AviUtl\license ���� patch-aul �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\license\patch-aul -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl �f�B���N�g������ patch.aul �� (�ҋ@) �AAviUtl\license\patch-aul ���ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item patch.aul C:\Applications\AviUtl -Force" -WindowStyle Minimized -Wait
Move-Item * C:\Applications\AviUtl\license\patch-aul -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`nL-SMASH Works (Mr-Ojii��) �̍ŐV�ŏ����擾���Ă��܂�..."

# L-SMASH Works (Mr-Ojii��) �̍ŐV�ł̃_�E�����[�hURL���擾
$lSmashWorksAllUrl = GithubLatestReleaseUrl "Mr-Ojii/L-SMASH-Works-Auto-Builds"

# �������钆����AviUtl�p�̂��̂̂ݎc��
$lSmashWorksUrl = $lSmashWorksAllUrl | Where-Object {$_ -like "*Mr-Ojii_vimeo*"}

Write-Host "����"
Write-Host -NoNewline "L-SMASH Works (Mr-Ojii��) ���_�E�����[�h���Ă��܂�..."

# L-SMASH Works (Mr-Ojii��) ��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $lSmashWorksUrl" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "L-SMASH Works (Mr-Ojii��) ���C���X�g�[�����Ă��܂�..."

# AviUtl\license\l-smash_works ���� Licenses �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\license\l-smash_works\Licenses") {
    Remove-Item C:\Applications\AviUtl\license\l-smash_works\Licenses -Recurse
}

# L-SMASH Works��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path L-SMASH-Works_*.zip -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g����L-SMASH Works��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "L-SMASH-Works_*"

# AviUtl\readme, AviUtl\license ���� l-smash_works �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\l-smash_works, C:\Applications\AviUtl\license\l-smash_works -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl\plugins �f�B���N�g������ lw*.au* ���AAviUtl\readme\l-smash_works ���� READM* �� (�ҋ@) �A
# AviUtl\license\l-smash_works ���ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item lw*.au* C:\Applications\AviUtl\plugins -Force; Move-Item READM* C:\Applications\AviUtl\readme\l-smash_works -Force" -WindowStyle Minimized -Wait
Move-Item * C:\Applications\AviUtl\license\l-smash_works -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`nInputPipePlugin�̍ŐV�ŏ����擾���Ă��܂�..."

# InputPipePlugin�̍ŐV�ł̃_�E�����[�hURL���擾
$InputPipePluginUrl = GithubLatestReleaseUrl "amate/InputPipePlugin"

Write-Host "����"
Write-Host -NoNewline "InputPipePlugin���_�E�����[�h���Ă��܂�..."

# InputPipePlugin��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $InputPipePluginUrl" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "InputPipePlugin���C���X�g�[�����Ă��܂�..."

# InputPipePlugin��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path InputPipePlugin_*.zip -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g����InputPipePlugin��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "InputPipePlugin_*\InputPipePlugin"

# AviUtl\readme, AviUtl\license ���� inputPipePlugin �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\inputPipePlugin, C:\Applications\AviUtl\license\inputPipePlugin -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl\license\inputPipePlugin ���� LICENSE ���AAviUtl\readme\inputPipePlugin ���� Readme.md �� (�ҋ@) �A
# AviUtl\plugins �f�B���N�g�����ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item LICENSE C:\Applications\AviUtl\license\inputPipePlugin -Force; Move-Item Readme.md C:\Applications\AviUtl\readme\inputPipePlugin -Force" -WindowStyle Minimized -Wait
Move-Item * C:\Applications\AviUtl\plugins -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..\..

Write-Host "����"
Write-Host -NoNewline "`r`nx264guiEx�̍ŐV�ŏ����擾���Ă��܂�..."

# x264guiEx�̍ŐV�ł̃_�E�����[�hURL���擾
$x264guiExUrl = GithubLatestReleaseUrl "rigaya/x264guiEx"

Write-Host "����"
Write-Host -NoNewline "x264guiEx���_�E�����[�h���Ă��܂�..."

# x264guiEx��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $x264guiExUrl" -WindowStyle Minimized -Wait

Write-Host "����"
Write-Host -NoNewline "x264guiEx���C���X�g�[�����Ă��܂�..."

# AviUtl\plugins ���� x264guiEx_stg �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\plugins\x264guiEx_stg") {
    Remove-Item C:\Applications\AviUtl\plugins\x264guiEx_stg -Recurse
}

# x264guiEx��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path x264guiEx_*.zip -Force" -WindowStyle Minimized -Wait

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "x264guiEx_*\x264guiEx_*"

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g������ plugins �f�B���N�g���ɕύX
Set-Location plugins

# AviUtl\plugins ���Ɍ��݂̃f�B���N�g���̃t�@�C����S�Ĉړ�
Move-Item * C:\Applications\AviUtl\plugins -Force

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g������ exe_files �f�B���N�g���ɕύX
Set-Location ..\exe_files

# AviUtl �f�B���N�g������ exe_files �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\exe_files -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl\exe_files ���Ɍ��݂̃f�B���N�g���̃t�@�C����S�Ĉړ�
Move-Item * C:\Applications\AviUtl\exe_files -Force

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location ..

# AviUtl\readme ���� x264guiEx �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\x264guiEx -ItemType Directory -Force" -WindowStyle Minimized -Wait

# AviUtl\readme\x264guiEx ���� x264guiEx_readme.txt ���ړ�
Move-Item x264guiEx_readme.txt C:\Applications\AviUtl\readme\x264guiEx -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..\..

Write-Host "`r`nx264guiEx�̃C���X�g�[�����������܂����B"

# HW�G���R�[�f�B���O�̎g�p�ۂ��`�F�b�N���A�\�ł���Ώo�̓v���O�C�����C���X�g�[�� by Yu-yu0202 (20250107)
Write-Host "`r`n�n�[�h�E�F�A�G���R�[�h (NVEnc / VCEEnc / QSVEnc) ���g�p�ł��邩�`�F�b�N���܂��B"

# tmp �f�B���N�g���̃p�X�� $tmpDir �ɕۑ�
$tmpDir = Join-Path -Path $scriptFileRoot -ChildPath tmp

Write-Host -NoNewline "�K�v�ȃt�@�C�����_�E�����[�h���܂� (����������ꍇ������܂�) ..."

$repos = @("rigaya/VCEEnc", "rigaya/NVEnc", "rigaya/QSVEnc")
foreach ($repo in $repos) {
    $apiUrl = "https://api.github.com/repos/$repo/releases/latest"
    $response = Invoke-RestMethod -Uri $apiUrl
    $tagName = $response.tag_name

    $repoName = ($repo -split "/")[-1]

    #�o�̓v���O�C�����_�E�����[�h+�W�J
    $downloadUrl = "https://github.com/$repo/releases/download/$tagName/Aviutl_${repoName}_${tagName}.zip"
    $tempZip = Join-Path -Path $tmpDir -ChildPath "Aviutl_${repoName}_${tagName}.zip"
    $extractDir = Join-Path -Path $tmpDir -ChildPath $($repoName)

    Start-Process -FilePath "curl" -ArgumentList "-L", $downloadUrl, "-o", $tempZip -WindowStyle Minimized -Wait
    Start-Process powershell -ArgumentList "-command Expand-Archive -Path $tempZip -Destination $extractDir -Force" -WindowStyle Minimized -Wait
    Remove-Item -Path $tempZip
}

Write-Host "����"
Write-Host "`r`n�G���R�[�_�[�̃`�F�b�N�A����юg�p�\�ȏo�̓v���O�C���̃C���X�g�[�����s���܂��B"

$encoders = [ordered]@{
    "NVEnc"  = "NVEncC.exe"
    "QSVEnc" = "QSVEncC.exe"
    "VCEEnc" = "VCEEncC.exe"
}

# �掿�̂悢NVEnc���珇��QSVEnc�AVCEEnc�ƃ`�F�b�N���Ă����A�ŏ��Ɏg�p�\�Ȃ��̂��m�F�������_�ł���𓱓�����foreach�𗣒E
foreach ($encoder in $encoders.GetEnumerator()) {
    $encoderPath = Join-Path -Path $tmpDir -ChildPath "$($encoder.Key)\exe_files\$($encoder.Key)C\x86\$($encoder.Value)"
    if (Test-Path -Path $encoderPath) {
        $process = Start-Process -FilePath $encoderPath -ArgumentList "--check-hw" -Wait -WindowStyle Minimized -PassThru

        # ExitCode��0�̏ꍇ�̓C���X�g�[��
        if ($process.ExitCode -eq 0) {
            Write-Host -NoNewline "$($encoder.Key)���g�p�\�ł��B$($encoder.Key)���C���X�g�[�����܂�..."

            # �W�J��̂��ꂼ��̃t�H���_���ړ�
            $extdir = Join-Path -Path $tmpDir -ChildPath "$($encoder.Key)"
            Move-Item -Path "$extdir\exe_files\*" -Destination "$AviutlPath\exe_files" -Force; Move-Item -Path "$extdir\plugins\*" -Destination "$AviutlPath\plugins" -Force
            New-Item -ItemType Directory -Path $AviutlPath\readme\$($encoder.Key) -Force | Out-Null
            Move-Item -Path $extdir\*_readme.* -Destination $AviutlPath\readme\$($encoder.Key)\$($encoder.Key).txt -Force
            Write-Host "����"

            # �ꉞ�A�o�̓v���O�C�����������Ȃ��悤break��foreach�𔲂���
            break

        # �Ō��VCEEnc���g�p�s�������ꍇ�A�n�[�h�E�F�A�G���R�[�h���g�p�ł��Ȃ��|�̃��b�Z�[�W��\��
        } elseif ($($encoder.Key) -eq "VCEEnc") {
            Write-Host "�n�[�h�E�F�A�G���R�[�h�͎g�p�ł��܂���B"
        }
    
    # �G���R�[�_�[�̎��s�t�@�C�����m�F�ł��Ȃ��ꍇ�A�G���[���b�Z�[�W��\������
    } else {
        Write-Host "���������G���[: �G���R�[�_�[�̃`�F�b�N�Ɏ��s���܂����B`r`n�G���[�̌����@: �G���R�[�_�[�̎��s�t�@�C�����m�F�ł��܂���B"
    }
}

Write-Host -NoNewline "`r`nVisual C++ �ĔЕz�\�p�b�P�[�W���m�F���Ă��܂�..."

# ���W�X�g������f�X�N�g�b�v�A�v���̈ꗗ���擾����
$installedApps = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
                                  'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                                  'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue |
Where-Object { $_.DisplayName -and $_.UninstallString -and -not $_.SystemComponent -and ($_.ReleaseType -notin 'Update','Hotfix') -and -not $_.ParentKeyName } |
Select-Object DisplayName

# Microsoft Visual C++ 2015-20xx Redistributable (x86) ���C���X�g�[������Ă��邩�m�F����
# �EVisual C++ �ĔЕz�\�p�b�P�[�W��2020��2021�͂Ȃ��̂ŁA20[2-9][0-9] �Ƃ��Ă�����2022�ȍ~���w��ł���
$Vc2015App = $installedApps.DisplayName -match "Microsoft Visual C\+\+ 2015-20[2-9][0-9] Redistributable \(x86\)"

# Microsoft Visual C++ 2008 Redistributable - x86 ���C���X�g�[������Ă��邩�m�F����
$Vc2008App = $installedApps.DisplayName -match "Microsoft Visual C\+\+ 2008 Redistributable - x86"

Write-Host "����"

# $Vc2015App �� $Vc2008App �̌��ʂŏ����𕪊򂷂�

# �����C���X�g�[������Ă���ꍇ�A���b�Z�[�W�����\��
if ($Vc2015App -and $Vc2008App) {
    Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̓C���X�g�[���ς݂ł��B"
    Write-Host "Microsoft Visual C++ 2008 Redistributable - x86 �̓C���X�g�[���ς݂ł��B"

# 2008�̂݃C���X�g�[������Ă���ꍇ�A2015�������C���X�g�[��
} elseif ($Vc2008App) {
    Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̓C���X�g�[������Ă��܂���B"
    Write-Host "���̃p�b�P�[�W�� patch.aul �ȂǏd�v�ȃv���O�C���̓���ɕK�v�ł��B�C���X�g�[���ɂ͊Ǘ��Ҍ������K�v�ł��B`r`n"
    Write-Host -NoNewline "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[���_�E�����[�h���Ă��܂�..."

    # Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[���_�E�����[�h (�ҋ@)
    Start-Process -FilePath curl.exe -ArgumentList "-OL https://aka.ms/vs/17/release/vc_redist.x86.exe" -WindowStyle Minimized -Wait

    Write-Host "����"
    Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[�����s���܂��B"
    Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

    # Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[�����s (�ҋ@)
	    # �����C���X�g�[���I�v�V������ǉ� by Atolycs (20250106)
    Start-Process -FilePath vc_redist.x86.exe -ArgumentList "/install /passive" -WindowStyle Minimized -Wait

    Write-Host "�C���X�g�[���[���I�����܂����B"
    Write-Host "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̓C���X�g�[���ς݂ł��B"

# 2015�̂݃C���X�g�[������Ă���ꍇ�A2008�̃C���X�g�[�������[�U�[�ɑI��������
} elseif ($Vc2015App) {
    Write-Host "Microsoft Visual C++ 2008 Redistributable - x86 �̓C���X�g�[������Ă��܂���B"

    # �I����������

    $choiceTitle = "Microsoft Visual C++ 2008 Redistributable - x86 ���C���X�g�[�����܂����H"
    $choiceMessage = "���̃p�b�P�[�W�͈ꕔ�̃X�N���v�g�̓���ɕK�v�ł��B�C���X�g�[���ɂ͊Ǘ��Ҍ������K�v�ł��B"

    $tChoiceDescription = "System.Management.Automation.Host.ChoiceDescription"
    $choiceOptions = @(
        New-Object $tChoiceDescription ("�͂�(&Y)",       "�C���X�g�[�������s���܂��B")
        New-Object $tChoiceDescription ("������(&N)",     "�C���X�g�[���������A�X�L�b�v���Ď��̏����ɐi�݂܂��B")
    )

    $result = $host.ui.PromptForChoice($choiceTitle, $choiceMessage, $choiceOptions, 0)
    switch ($result) {
        0 {
            Write-Host -NoNewline "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h���Ă��܂�..."

            # Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h (�ҋ@)
            Start-Process -FilePath curl.exe -ArgumentList "-OL https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -WindowStyle Minimized -Wait

            Write-Host "����"
            Write-Host "Microsoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����s���܂��B"
            Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

            # Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[�����s (�ҋ@)
        	    # �����C���X�g�[���I�v�V������ǉ� by Atolycs (20250106)
            Start-Process -FilePath vcredist_x86.exe -ArgumentList "/qb" -WindowStyle Minimized -Wait

            Write-Host "�C���X�g�[���[���I�����܂����B"
            break
        }
        1 {
            Write-Host "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����X�L�b�v���܂����B"
            break
        }
    }

    # �I�������܂�

# �����C���X�g�[������Ă��Ȃ��ꍇ�A2008�̃C���X�g�[�������[�U�[�ɑI�������A2008���C���X�g�[������ꍇ�͗����C���X�g�[�����A
# 2008���C���X�g�[�����Ȃ��ꍇ��2015�̂ݎ����C���X�g�[��
} else  {
    Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̓C���X�g�[������Ă��܂���B"
    Write-Host "���̃p�b�P�[�W�� patch.aul �ȂǏd�v�ȃv���O�C���̓���ɕK�v�ł��B�C���X�g�[���ɂ͊Ǘ��Ҍ������K�v�ł��B`r`n"
    Write-Host -NoNewline "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[���_�E�����[�h���Ă��܂�..."

    # Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[���_�E�����[�h (�ҋ@)
    Start-Process -FilePath curl.exe -ArgumentList "-OL https://aka.ms/vs/17/release/vc_redist.x86.exe" -WindowStyle Minimized -Wait

    Write-Host "����"
    Write-Host "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̓C���X�g�[������Ă��܂���B"

    # �I����������

    $choiceTitle = "Microsoft Visual C++ 2008 Redistributable - x86 ���C���X�g�[�����܂����H"
    $choiceMessage = "���̃p�b�P�[�W�͈ꕔ�̃X�N���v�g�̓���ɕK�v�ł��B�C���X�g�[���ɂ͊Ǘ��Ҍ������K�v�ł��B"

    $tChoiceDescription = "System.Management.Automation.Host.ChoiceDescription"
    $choiceOptions = @(
        New-Object $tChoiceDescription ("�͂�(&Y)",       "�C���X�g�[�������s���܂��B")
        New-Object $tChoiceDescription ("������(&N)",     "�C���X�g�[���������A�X�L�b�v���Ď��̏����ɐi�݂܂��B")
    )

    $result = $host.ui.PromptForChoice($choiceTitle, $choiceMessage, $choiceOptions, 0)
    switch ($result) {
        0 {
            Write-Host -NoNewline "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h���Ă��܂�..."

            # Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h (�ҋ@)
            Start-Process -FilePath curl.exe -ArgumentList "-OL https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -WindowStyle Minimized -Wait

            Write-Host "����"
            Write-Host "`r`nMicrosoft Visual C++ 2015-20xx Redistributable (x86) ��`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����s���܂��B"
            Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

            # VCruntimeInstall2015and2008.cmd �̑��݂���f�B���N�g�����m�F
        	    # VCruntimeInstall2015and2008.cmd �� Visual C++ 2015-20xx Redistributable (x86) ��
                # Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[�����ԂɎ��s���Ă��������̃X�N���v�g
            $VCruntimeInstallCmdDirectory = Join-Path -Path $scriptFileRoot -ChildPath script_files
            $VCruntimeInstallCmdPath = Join-Path -Path $VCruntimeInstallCmdDirectory -ChildPath 'VCruntimeInstall2015and2008.cmd'
            if (!(Test-Path $VCruntimeInstallCmdPath)) {
                $VCruntimeInstallCmdDirectory = $scriptFileRoot
            }

            Start-Sleep -Milliseconds 500

            # VCruntimeInstall2015and2008.cmd ���Ǘ��Ҍ����Ŏ��s (�ҋ@)
            Start-Process -FilePath cmd.exe -ArgumentList "/C cd $VCruntimeInstallCmdDirectory & call VCruntimeInstall2015and2008.cmd & exit" -Verb RunAs -WindowStyle Minimized -Wait

            Write-Host "�C���X�g�[���[���I�����܂����B"
            break
        }
        1 {
            Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[�����s���܂��B"
            Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

            # Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[�����s (�ҋ@)
	            # �����C���X�g�[���I�v�V������ǉ� by Atolycs (20250106)
            Start-Process -FilePath vc_redist.x86.exe -ArgumentList "/install /passive" -WindowStyle Minimized -Wait

            Write-Host "�C���X�g�[���[���I�����܂����B"
            Write-Host "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����X�L�b�v���܂����B"
            break
        }
    }

    # �I�������܂�
}

Write-Host -NoNewline "`r`n�ݒ�t�@�C�����R�s�[���Ă��܂�..."

# �J�����g�f�B���N�g���� settings �f�B���N�g���ɕύX
Set-Location ..\settings

# AviUtl\plugins ���� lsmash.ini ���AAviUtl ���ɂ��̑��̃t�@�C�����R�s�[
Copy-Item lsmash.ini C:\Applications\AviUtl\plugins
Copy-Item aviutl.ini C:\Applications\AviUtl
Copy-Item exedit.ini C:\Applications\AviUtl
Copy-Item �f�t�H���g.cfg C:\Applications\AviUtl

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..\tmp

Write-Host "����"
Write-Host -NoNewline "`r`n�f�X�N�g�b�v�ɃV���[�g�J�b�g�t�@�C�����쐬���Ă��܂�..."

# WSH��p���ăf�X�N�g�b�v��AviUtl�̃V���[�g�J�b�g���쐬����
$ShortcutFolder = [Environment]::GetFolderPath("Desktop")
$ShortcutFile = Join-Path -Path $ShortcutFolder -ChildPath "AviUtl.lnk"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = "C:\Applications\AviUtl\aviutl.exe"
$Shortcut.IconLocation = "C:\Applications\AviUtl\aviutl.exe,0"
$Shortcut.WorkingDirectory = "."
$Shortcut.Save()

Write-Host "����"
Write-Host -NoNewline "�X�^�[�g���j���[�ɃV���[�g�J�b�g�t�@�C�����쐬���Ă��܂�..."

# WSH��p���ăX�^�[�g���j���[��AviUtl�̃V���[�g�J�b�g���쐬����
$ShortcutFolder = [Environment]::GetFolderPath("Programs")
$ShortcutFile = Join-Path -Path $ShortcutFolder -ChildPath "AviUtl.lnk"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = "C:\Applications\AviUtl\aviutl.exe"
$Shortcut.IconLocation = "C:\Applications\AviUtl\aviutl.exe,0"
$Shortcut.WorkingDirectory = "."
$Shortcut.Save()

Write-Host "����"
Write-Host -NoNewline "`r`n�C���X�g�[���Ɏg�p�����s�v�ȃt�@�C�����폜���Ă��܂�..."

# �J�����g�f�B���N�g�����X�N���v�g�t�@�C���̂���f�B���N�g���ɕύX
Set-Location ..

# tmp �f�B���N�g�����폜
Remove-Item tmp -Recurse

Write-Host "����"

if (Test-Path "script_files\�K�{�v���O�C�����X�V����.cmd") {
    # �K�{�v���O�C�����X�V����.cmd ���J�����g�f�B���N�g���Ɉړ�
    Move-Item "script_files\�K�{�v���O�C�����X�V����.cmd" . -Force

    # aviutl-installer.cmd (���̃t�@�C��) �� settings �f�B���N�g���� script_files �f�B���N�g���Ɉړ�
    Move-Item settings script_files -Force
    Move-Item aviutl-installer.cmd script_files -Force
}

# ���[�U�[�̑����҂��ďI��
Write-Host -NoNewline "`r`n`r`n`r`n�C���X�g�[�����������܂����I`r`n`r`n`r`nreadme�t�H���_���J����"
Pause

# �I������readme�t�H���_��\��
Invoke-Item "C:\Applications\AviUtl\readme"