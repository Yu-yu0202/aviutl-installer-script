@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

<#!
 #  MIT License
 #
 #  Copyright (c) 2025 menndouyukkuri, atolycs, Yu-yu0202
 #
 #  Permission is hereby granted, free of charge, to any person obtaining a copy
 #  of this software and associated documentation files (the "Software"), to deal
 #  in the Software without restriction, including without limitation the rights
 #  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 #  copies of the Software, and to permit persons to whom the Software is
 #  furnished to do so, subject to the following conditions:
 #
 #  The above copyright notice and this permission notice shall be included in all
 #  copies or substantial portions of the Software.
 #
 #  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 #  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 #  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 #  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 #  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 #  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 #  SOFTWARE.
#>

# GitHub���|�W�g���̍ŐV�Ń����[�X�̃_�E�����[�hURL���擾����
function GithubLatestReleaseUrl ($repo) {
	# GitHub��API����ŐV�Ń����[�X�̏����擾����
	$api = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/latest"

	# �ŐV�Ń����[�X�̃_�E�����[�hURL�݂̂�Ԃ�
	return($api.assets.browser_download_url)
}

$DisplayNameOfThisScript = "AviUtl Installer Script (Version 1.1.2_2025-01-21)"
$Host.UI.RawUI.WindowTitle = $DisplayNameOfThisScript
Write-Host "$($DisplayNameOfThisScript)`r`n`r`n"

# �J�����g�f�B���N�g���̃p�X�� $scriptFileRoot �ɕۑ� (�N�����@�̂����� $PSScriptRoot ���g�p�ł��Ȃ�����)
$scriptFileRoot = (Get-Location).Path

# �{�̂̍X�V�m�F by Yu-yu0202 (20250121)
Write-Host "�{�̂̍X�V���m�F���܂�..."
$tagName = Invoke-RestMethod -Uri "https://api.github.com/repos/menndouyukkuri/aviutl-installer-script/releases/latest" | Select-Object -ExpandProperty tag_name
if ($tagName -ne $Version) {
	Write-Host "�V�����o�[�W����������܂��B�X�V���s���܂�..."
	#tmp�t�H���_���쐬+�ړ�
	New-Item -ItemType Directory -Path tmp -Force | Out-Null
	Set-Location tmp
	# �{�̂̍ŐV�ł̃_�E�����[�hURL���擾
	$AISDownloadUrl = GithubLatestReleaseUrl "menndouyukkuri/aviutl-installer-script"
	# �{�̂�zip�t�@�C�����_�E�����[�h (�ҋ@)
	Start-Process -FilePath curl.exe -ArgumentList "-OL $AISDownloadUrl" -WindowStyle Hidden -Wait
	#tagName����擪�́uv�v���폜
	$tagName = $tagName.Substring(1)
	# �{�̂�zip�t�@�C����W�J (�ҋ@)
	Start-Process powershell -ArgumentList "-command Expand-Archive -Path aviutl-installer_$tagName.zip -Force" -WindowStyle Hidden -Wait
	# �W�J���zip���폜
	Remove-Item aviutl-installer_$($tagName).zip
	# �V�o�[�W�������N��
	Write-Host "�V�����o�[�W�������N�����܂�..."
	# �W�J��̃t�H���_�Ɉړ�
	Set-Location "aviutl-installer_$tagName"
	Start-Process -FilePath "aviutl-installer.cmd"
	# ���o�[�W�������I��
	Exit
}

Write-Host -NoNewline "AviUtl���C���X�g�[������t�H���_���쐬���Ă��܂�..."

# C:\Applications �f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications -ItemType Directory -Force" -WindowStyle Hidden -Wait

# C:\Applications\AviUtl �f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl �f�B���N�g������ plugins, script, license, readme ��4�̃f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\plugins, C:\Applications\AviUtl\script, C:\Applications\AviUtl\license, C:\Applications\AviUtl\readme -ItemType Directory -Force" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "`r`n�ꎞ�I�Ƀt�@�C����ۊǂ���t�H���_���쐬���Ă��܂�..."

# tmp �f�B���N�g�����쐬���� (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item tmp -ItemType Directory -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location tmp

Write-Host "����"
Write-Host -NoNewline "`r`nAviUtl�{�� (version 1.10) ���_�E�����[�h���Ă��܂�..."

# AviUtl version 1.10��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL http://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "AviUtl�{�̂��C���X�g�[�����Ă��܂�..."

# AviUtl��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path aviutl110.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g���� aviutl110 �f�B���N�g���ɕύX
Set-Location aviutl110

# AviUtl\readme ���� aviutl �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\aviutl -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl �f�B���N�g������ aviutl.exe ���AAviUtl\readme\aviutl ���� aviutl.txt �����ꂼ��ړ�
Move-Item aviutl.exe C:\Applications\AviUtl -Force
Move-Item aviutl.txt C:\Applications\AviUtl\readme\aviutl -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`n�g���ҏWPlugin version 0.92���_�E�����[�h���Ă��܂�..."

# �g���ҏWPlugin version 0.92��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL http://spring-fragrance.mints.ne.jp/aviutl/exedit92.zip" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "�g���ҏWPlugin���C���X�g�[�����Ă��܂�..."

# �g���ҏWPlugin��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path exedit92.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g���� exedit92 �f�B���N�g���ɕύX
Set-Location exedit92

# AviUtl\readme ���� exedit �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\exedit -ItemType Directory -Force" -WindowStyle Hidden -Wait

# exedit.ini �͎g�p�����A�����̌�̏����Ŏז��ɂȂ�̂ō폜���� (�ҋ@)
Start-Process powershell -ArgumentList "-command Remove-Item exedit.ini" -WindowStyle Hidden -Wait

# AviUtl\readme\exedit ���� exedit.txt, lua.txt �� (�ҋ@) �AAviUtl �f�B���N�g�����ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item *.txt C:\Applications\AviUtl\readme\exedit -Force" -WindowStyle Hidden -Wait
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
Start-Process -FilePath curl.exe -ArgumentList "-OL $patchAulUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "patch.aul (�䂳���ȃt�H�[�N��) ���C���X�g�[�����Ă��܂�..."

# patch.aul��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path patch.aul_*.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����patch.aul��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "patch.aul_*"

# AviUtl\license ���� patch-aul �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\license\patch-aul -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl �f�B���N�g������ patch.aul �� (�ҋ@) �AAviUtl\license\patch-aul ���ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item patch.aul C:\Applications\AviUtl -Force" -WindowStyle Hidden -Wait
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
Start-Process -FilePath curl.exe -ArgumentList "-OL $lSmashWorksUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "L-SMASH Works (Mr-Ojii��) ���C���X�g�[�����Ă��܂�..."

# AviUtl\license\l-smash_works ���� Licenses �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\license\l-smash_works\Licenses") {
	Remove-Item C:\Applications\AviUtl\license\l-smash_works\Licenses -Recurse
}

# L-SMASH Works��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path L-SMASH-Works_*.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����L-SMASH Works��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "L-SMASH-Works_*"

# AviUtl\readme, AviUtl\license ���� l-smash_works �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\l-smash_works, C:\Applications\AviUtl\license\l-smash_works -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\plugins �f�B���N�g������ lw*.au* ���AAviUtl\readme\l-smash_works ���� READM* �� (�ҋ@) �A
# AviUtl\license\l-smash_works ���ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item lw*.au* C:\Applications\AviUtl\plugins -Force; Move-Item READM* C:\Applications\AviUtl\readme\l-smash_works -Force" -WindowStyle Hidden -Wait
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
Start-Process -FilePath curl.exe -ArgumentList "-OL $InputPipePluginUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "InputPipePlugin���C���X�g�[�����Ă��܂�..."

# InputPipePlugin��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path InputPipePlugin_*.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����InputPipePlugin��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "InputPipePlugin_*\InputPipePlugin"

# AviUtl\readme, AviUtl\license ���� inputPipePlugin �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\inputPipePlugin, C:\Applications\AviUtl\license\inputPipePlugin -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\license\inputPipePlugin ���� LICENSE ���AAviUtl\readme\inputPipePlugin ���� Readme.md �� (�ҋ@) �A
# AviUtl\plugins �f�B���N�g�����ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item LICENSE C:\Applications\AviUtl\license\inputPipePlugin -Force; Move-Item Readme.md C:\Applications\AviUtl\readme\inputPipePlugin -Force" -WindowStyle Hidden -Wait
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
Start-Process -FilePath curl.exe -ArgumentList "-OL $x264guiExUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "x264guiEx���C���X�g�[�����Ă��܂�..."

# AviUtl\plugins ���� x264guiEx_stg �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\plugins\x264guiEx_stg") {
	Remove-Item C:\Applications\AviUtl\plugins\x264guiEx_stg -Recurse
}

# x264guiEx��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path x264guiEx_*.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "x264guiEx_*\x264guiEx_*"

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g������ plugins �f�B���N�g���ɕύX
Set-Location plugins

# AviUtl\plugins ���Ɍ��݂̃f�B���N�g���̃t�@�C����S�Ĉړ�
Move-Item * C:\Applications\AviUtl\plugins -Force

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g������ exe_files �f�B���N�g���ɕύX
Set-Location ..\exe_files

# AviUtl �f�B���N�g������ exe_files �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\exe_files -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\exe_files ���Ɍ��݂̃f�B���N�g���̃t�@�C����S�Ĉړ�
Move-Item * C:\Applications\AviUtl\exe_files -Force

# �J�����g�f�B���N�g����x264guiEx��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location ..

# AviUtl\readme ���� x264guiEx �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\x264guiEx -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\readme\x264guiEx ���� x264guiEx_readme.txt ���ړ�
Move-Item x264guiEx_readme.txt C:\Applications\AviUtl\readme\x264guiEx -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..\..

Write-Host "����"
Write-Host -NoNewline "`r`nMFVideoReader�̍ŐV�ŏ����擾���Ă��܂�..."

# MFVideoReader�̍ŐV�ł̃_�E�����[�hURL���擾
$MFVideoReaderUrl = GithubLatestReleaseUrl "amate/MFVideoReader"

Write-Host "����"
Write-Host -NoNewline "MFVideoReader���_�E�����[�h���Ă��܂�..."

# MFVideoReader��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $MFVideoReaderUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "MFVideoReader���C���X�g�[�����Ă��܂�..."

# MFVideoReader��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path MFVideoReader_*.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����MFVideoReader��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "MFVideoReader_*\MFVideoReader"

# AviUtl\readme, AviUtl\license ���� MFVideoReader �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\MFVideoReader, C:\Applications\AviUtl\license\MFVideoReader -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\license\MFVideoReader ���� LICENSE ���AAviUtl\readme\MFVideoReader ���� Readme.md �� (�ҋ@) �A
# AviUtl\plugins �f�B���N�g�����ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item LICENSE C:\Applications\AviUtl\license\MFVideoReader -Force; Move-Item Readme.md C:\Applications\AviUtl\readme\MFVideoReader -Force" -WindowStyle Hidden -Wait
Move-Item * C:\Applications\AviUtl\plugins -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..\..

Write-Host "����"
Write-Host -NoNewline "`r`nWebP Susie Plug-in���_�E�����[�h���Ă��܂�..."

# WebP Susie Plug-in��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL https://toroidj.github.io/plugin/iftwebp11.zip" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "WebP Susie Plug-in���C���X�g�[�����Ă��܂�..."

# WebP Susie Plug-in��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path iftwebp11.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g���� iftwebp11 �f�B���N�g���ɕύX
Set-Location iftwebp11

# AviUtl\readme ���� iftwebp �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\iftwebp -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl �f�B���N�g������ iftwebp.spi ���AAviUtl\readme\iftwebp ���� iftwebp.txt �����ꂼ��ړ�
Move-Item iftwebp.spi C:\Applications\AviUtl -Force
Move-Item iftwebp.txt C:\Applications\AviUtl\readme\iftwebp -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`nifheif�̍ŐV�ŏ����擾���Ă��܂�..."

# ifheif�̍ŐV�ł̃_�E�����[�hURL���擾
$ifheifUrl = GithubLatestReleaseUrl "Mr-Ojii/ifheif"

Write-Host "����"
Write-Host -NoNewline "ifheif���_�E�����[�h���Ă��܂�..."

# ifheif��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $ifheifUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "ifheif���C���X�g�[�����Ă��܂�..."

# AviUtl\license\ifheif ���� Licenses �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\license\ifheif\Licenses") {
	Remove-Item C:\Applications\AviUtl\license\ifheif\Licenses -Recurse
}

# ifheif��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path ifheif.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����ifheif��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "ifheif"

# AviUtl\readme, AviUtl\license ���� ifheif �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\ifheif, C:\Applications\AviUtl\license\ifheif -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl �f�B���N�g������ ifheif.spi ���AAviUtl\license\ifheif ���� LICENSE �� Licenses �f�B���N�g�����A
# AviUtl\readme\ifheif ���� Readme.md �����ꂼ��ړ�
Move-Item ifheif.spi C:\Applications\AviUtl -Force
Move-Item "LICENS*" C:\Applications\AviUtl\license\ifheif -Force
Move-Item Readme.md C:\Applications\AviUtl\readme\ifheif -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"
Write-Host -NoNewline "`r`n�uAviUtl�X�N���v�g�ꎮ�v���_�E�����[�h���Ă��܂�..."

# �uAviUtl�X�N���v�g�ꎮ�v��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL https://ss1.xrea.com/menkuri.s270.xrea.com/aviutl-installer-script/scripts/script_20160828.zip" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "�uAviUtl�X�N���v�g�ꎮ�v���C���X�g�[�����Ă��܂�..."

# AviUtl\script ���� ����_AviUtl�X�N���v�g�ꎮ �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\script\����_AviUtl�X�N���v�g�ꎮ") {
	Remove-Item "C:\Applications\AviUtl\script\����_AviUtl�X�N���v�g�ꎮ" -Recurse
}

# AviUtl\script ���� ����_ANM_ssd �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\script\����_ANM_ssd") {
	Remove-Item "C:\Applications\AviUtl\script\����_ANM_ssd" -Recurse
}

# AviUtl\script ���� ����_TA_ssd �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\script\����_TA_ssd") {
	Remove-Item "C:\Applications\AviUtl\script\����_TA_ssd" -Recurse
}

# �uAviUtl�X�N���v�g�ꎮ�v��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path script_20160828.zip -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g���� script_20160828\script_20160828 �f�B���N�g���ɕύX
Set-Location script_20160828\script_20160828

# ANM_ssd �f�B���N�g���� ����_ANM_ssd �ɁATA_ssd �f�B���N�g���� ����_TA_ssd �ɂ��ꂼ�ꃊ�l�[�� (�ҋ@)
Start-Process powershell -ArgumentList "-command Rename-Item `"ANM_ssd`" `"����_ANM_ssd`"; Rename-Item `"TA_ssd`" `"����_TA_ssd`"" -WindowStyle Hidden -Wait

# AviUtl\script ���� ����_AviUtl�X�N���v�g�ꎮ �f�B���N�g�����AAviUtl\readme ���� AviUtl�X�N���v�g�ꎮ �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item `"C:\Applications\AviUtl\script\����_AviUtl�X�N���v�g�ꎮ`", `"C:\Applications\AviUtl\readme\AviUtl�X�N���v�g�ꎮ`" -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\script ���� ����_ANM_ssd �� ����_TA_ssd ���AAviUtl\readme\AviUtl�X�N���v�g�ꎮ ���� readme.txt �� �g����.txt �� (�ҋ@) �A
# AviUtl\script\����_AviUtl�X�N���v�g�ꎮ ���ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item `"����_ANM_ssd`" C:\Applications\AviUtl\script -Force; Move-Item `"����_TA_ssd`" C:\Applications\AviUtl\script -Force; Move-Item *.txt `"C:\Applications\AviUtl\readme\AviUtl�X�N���v�g�ꎮ`" -Force" -WindowStyle Hidden -Wait
Move-Item * "C:\Applications\AviUtl\script\����_AviUtl�X�N���v�g�ꎮ" -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..\..

Write-Host "����"
Write-Host -NoNewline "`r`n�u�l�Ő}�`�v���_�E�����[�h���Ă��܂�..."

# �l�Ő}�`.obj ���_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL `"https://ss1.xrea.com/menkuri.s270.xrea.com/aviutl-installer-script/scripts/�l�Ő}�`.obj`"" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "�u�l�Ő}�`�v���C���X�g�[�����Ă��܂�..."

# AviUtl\script ���� �l�Ő}�`.obj ���ړ�
Move-Item "�l�Ő}�`.obj" "C:\Applications\AviUtl\script" -Force

Write-Host "����"
Write-Host -NoNewline "`r`n�����X�N���v�g���_�E�����[�h���Ă��܂�..."

# �����X�N���v�g��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL `"https://ss1.xrea.com/menkuri.s270.xrea.com/aviutl-installer-script/scripts/�����X�N���v�g.zip`"" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "�����X�N���v�g���C���X�g�[�����Ă��܂�..."

# �����X�N���v�g��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path `"�����X�N���v�g.zip`" -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g���� �����X�N���v�g �f�B���N�g���ɕύX
Set-Location "�����X�N���v�g"

# AviUtl\readme, AviUtl\license ���� �����X�N���v�g �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item `"C:\Applications\AviUtl\readme\�����X�N���v�g`", `"C:\Applications\AviUtl\license\�����X�N���v�g`" -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl\script ���� ����.obj ���AAviUtl\license\�����X�N���v�g ���� LICENSE.txt �� (�ҋ@) �A
# AviUtl\readme\�����X�N���v�g ���ɂ��̑��̃t�@�C�������ꂼ��ړ�
Start-Process powershell -ArgumentList "-command Move-Item `"����.obj`" C:\Applications\AviUtl\script -Force; Move-Item LICENSE.txt `"C:\Applications\AviUtl\license\�����X�N���v�g`" -Force" -WindowStyle Hidden -Wait
Move-Item * "C:\Applications\AviUtl\readme\�����X�N���v�g" -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"


# LuaJIT�̃C���X�g�[�� by Yu-yu0202 (20250109)
	# �s�������Ȃ��������ߍĎ��� by menndouyukkuri (20250110)

# AviUtl ���� exedit_lua51.dll ������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\exedit_lua51.dll") {
	Remove-Item "C:\Applications\AviUtl\exedit_lua51.dll" -Recurse
}

Write-Host -NoNewline "`r`nLuaJIT�̍ŐV�ŏ����擾���Ă��܂�..."

# LuaJIT�̍ŐV�ł̃_�E�����[�hURL���擾
$luaJitAllUrl = GithubLatestReleaseUrl "Per-Terra/LuaJIT-Auto-Builds"

# �������钆����AviUtl�p�̂��̂̂ݎc��
$luaJitUrl = $luaJitAllUrl | Where-Object {$_ -like "*LuaJIT_2.1_Win_x86.zip"}

Write-Host "����"
Write-Host -NoNewline "LuaJIT���_�E�����[�h���Ă��܂�..."

# LuaJIT��zip�t�@�C�����_�E�����[�h (�ҋ@)
Start-Process -FilePath curl.exe -ArgumentList "-OL $luaJitUrl" -WindowStyle Hidden -Wait

Write-Host "����"
Write-Host -NoNewline "LuaJIT���C���X�g�[�����Ă��܂�..."

# AviUtl �f�B���N�g���Ɋ��ɂ��� lua51.dll (�g���ҏWPlugin�̂���) �����l�[�����ăo�b�N�A�b�v����
Rename-Item "C:\Applications\AviUtl\lua51.dll" "exedit_lua51.dll" -Force

# AviUtl\readme\LuaJIT ���� doc �f�B���N�g��������΍폜���� (�G���[�̖h�~)
if (Test-Path "C:\Applications\AviUtl\readme\LuaJIT\doc") {
	Remove-Item C:\Applications\AviUtl\readme\LuaJIT\doc -Recurse
}

# LuaJIT��zip�t�@�C����W�J (�ҋ@)
Start-Process powershell -ArgumentList "-command Expand-Archive -Path `"LuaJIT_2.1_Win_x86.zip`" -Force" -WindowStyle Hidden -Wait

# �J�����g�f�B���N�g����LuaJIT��zip�t�@�C����W�J�����f�B���N�g���ɕύX
Set-Location "LuaJIT_2.1_Win_x86"

# AviUtl\readme, AviUtl\license ���� LuaJIT �f�B���N�g�����쐬 (�ҋ@)
Start-Process powershell -ArgumentList "-command New-Item C:\Applications\AviUtl\readme\LuaJIT, C:\Applications\AviUtl\license\LuaJIT -ItemType Directory -Force" -WindowStyle Hidden -Wait

# AviUtl �f�B���N�g������ lua51.dll ���AAviUtl\readme\LuaJIT ���� README �� doc ���AAviUtl\license\LuaJIT ����
# COPYRIGHT �� About-This-Build.txt �����ꂼ��ړ�
Move-Item "lua51.dll" C:\Applications\AviUtl -Force
Move-Item README C:\Applications\AviUtl\readme\LuaJIT -Force
Move-Item doc C:\Applications\AviUtl\readme\LuaJIT -Force
Move-Item COPYRIGHT C:\Applications\AviUtl\license\LuaJIT -Force
Move-Item "About-This-Build.txt" C:\Applications\AviUtl\license\LuaJIT -Force

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location ..

Write-Host "����"


# HW�G���R�[�f�B���O�̎g�p�ۂ��`�F�b�N���A�\�ł���Ώo�̓v���O�C�����C���X�g�[�� by Yu-yu0202 (20250107)

Write-Host "`r`n�n�[�h�E�F�A�G���R�[�h (NVEnc / QSVEnc / VCEEnc) ���g�p�ł��邩�`�F�b�N���܂��B"
Write-Host -NoNewline "�K�v�ȃt�@�C�����_�E�����[�h���Ă��܂� (����������ꍇ������܂�) "

$hwEncoderRepos = @("rigaya/NVEnc", "rigaya/QSVEnc", "rigaya/VCEEnc")
foreach ($hwRepo in $hwEncoderRepos) {
	# ���ƂŎg���̂Ń��|�W�g����������Ă���
	$repoName = ($hwRepo -split "/")[-1]

	# �ŐV�ł̃_�E�����[�hURL���擾
	$downloadAllUrl = GithubLatestReleaseUrl $hwRepo

	# �������钆����AviUtl�p�̂��̂̂ݎc��
	$downloadUrl = $downloadAllUrl | Where-Object {$_ -like "*Aviutl*"}

	Write-Host -NoNewline "."

	# zip�t�@�C�����_�E�����[�h (�ҋ@)
	Start-Process -FilePath curl.exe -ArgumentList "-OL $downloadUrl" -WindowStyle Hidden -Wait

	Write-Host -NoNewline "."

	# zip�t�@�C����W�J (�ҋ@)
	Start-Process powershell -ArgumentList "-command Expand-Archive -Path Aviutl_${repoName}_*.zip -Force" -WindowStyle Hidden -Wait
}

Write-Host " ����"
Write-Host "�G���R�[�_�[�̃`�F�b�N�A����юg�p�\�ȏo�̓v���O�C���̃C���X�g�[�����s���܂��B"

$hwEncoders = [ordered]@{
	"NVEnc"  = "NVEncC.exe"
	"QSVEnc" = "QSVEncC.exe"
	"VCEEnc" = "VCEEncC.exe"
}

# �掿�̂悢NVEnc���珇��QSVEnc�AVCEEnc�ƃ`�F�b�N���Ă����A�ŏ��Ɏg�p�\�Ȃ��̂��m�F�������_�ł���𓱓�����foreach�𗣒E
foreach ($hwEncoder in $hwEncoders.GetEnumerator()) {
	# �G���R�[�_�[�̎��s�t�@�C���̃p�X���i�[
	Set-Location "Aviutl_$($hwEncoder.Key)_*"
	$extdir = (Get-Location).Path
	$encoderPath = Join-Path -Path $extdir -ChildPath "exe_files\$($hwEncoder.Key)C\x86\$($hwEncoder.Value)"
	Set-Location ..

	# �G���R�[�_�[�̎��s�t�@�C���̗L�����m�F
	if (Test-Path $encoderPath) {
		# �n�[�h�E�F�A�G���R�[�h�ł��邩�`�F�b�N
		$process = Start-Process -FilePath $encoderPath -ArgumentList "--check-hw" -Wait -WindowStyle Hidden -PassThru

		# ExitCode��0�̏ꍇ�̓C���X�g�[��
		if ($process.ExitCode -eq 0) {
			# AviUtl\exe_files ���� $($hwEncoder.Key)C �f�B���N�g��������΍폜���� (�G���[�̖h�~)
			if (Test-Path "C:\Applications\AviUtl\exe_files\$($hwEncoder.Key)C") {
				Remove-Item "C:\Applications\AviUtl\exe_files\$($hwEncoder.Key)C" -Recurse
			}

			# AviUtl\plugins ���� $($hwEncoder.Key)_stg �f�B���N�g��������΍폜���� (�G���[�̖h�~)
			if (Test-Path "C:\Applications\AviUtl\plugins\$($hwEncoder.Key)_stg") {
				Remove-Item "C:\Applications\AviUtl\plugins\$($hwEncoder.Key)_stg" -Recurse
			}

			Write-Host -NoNewline "$($hwEncoder.Key)���g�p�\�ł��B$($hwEncoder.Key)���C���X�g�[�����Ă��܂�..."

			# readme �f�B���N�g�����쐬
			New-Item -ItemType Directory -Path C:\Applications\AviUtl\readme\$($hwEncoder.Key) -Force | Out-Null

			# �W�J��̂��ꂼ��̃t�@�C�����ړ�
			Move-Item -Path "$extdir\exe_files\*" -Destination C:\Applications\AviUtl\exe_files -Force
			Move-Item -Path "$extdir\plugins\*" -Destination C:\Applications\AviUtl\plugins -Force
			Move-Item -Path "$extdir\*.bat" -Destination C:\Applications\AviUtl -Force
			Move-Item -Path "$extdir\*_readme.txt" -Destination C:\Applications\AviUtl\readme\$($hwEncoder.Key) -Force

			Write-Host "����"

			# �ꉞ�A�o�̓v���O�C�����������Ȃ��悤break��foreach�𔲂���
			break

		# �Ō��VCEEnc���g�p�s�������ꍇ�A�n�[�h�E�F�A�G���R�[�h���g�p�ł��Ȃ��|�̃��b�Z�[�W��\��
		} elseif ($($hwEncoder.Key) -eq "VCEEnc") {
			Write-Host "���̊��ł̓n�[�h�E�F�A�G���R�[�h�͎g�p�ł��܂���B"
		}

	# �G���R�[�_�[�̎��s�t�@�C�����m�F�ł��Ȃ��ꍇ�A�G���[���b�Z�[�W��\������
	} else {
		Write-Host "���������G���[: �G���R�[�_�[�̃`�F�b�N�Ɏ��s���܂����B`r`n�G���[�̌����@: $($hwEncoder.Key)�̎��s�t�@�C�����m�F�ł��܂���B"
	}
}


Write-Host -NoNewline "`r`nVisual C++ �ĔЕz�\�p�b�P�[�W���m�F���Ă��܂�..."

# ���W�X�g������f�X�N�g�b�v�A�v���̈ꗗ���擾����
$installedApps = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
								  "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
								  "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue |
Where-Object { $_.DisplayName -and $_.UninstallString -and -not $_.SystemComponent -and ($_.ReleaseType -notin "Update","Hotfix") -and -not $_.ParentKeyName } |
Select-Object DisplayName

# Microsoft Visual C++ 2015-20xx Redistributable (x86) ���C���X�g�[������Ă��邩�m�F����
	# Visual C++ �ĔЕz�\�p�b�P�[�W��2020��2021�͂Ȃ��̂ŁA20[2-9][0-9] �Ƃ��Ă�����2022�ȍ~���w��ł���
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
	Start-Process -FilePath curl.exe -ArgumentList "-OL https://aka.ms/vs/17/release/vc_redist.x86.exe" -WindowStyle Hidden -Wait

	Write-Host "����"
	Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[�����s���܂��B"
	Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

	# Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[�����s (�ҋ@)
		# �����C���X�g�[���I�v�V������ǉ� by Atolycs (20250106)
	Start-Process -FilePath vc_redist.x86.exe -ArgumentList "/install /passive" -WindowStyle Hidden -Wait

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
		New-Object $tChoiceDescription ("�͂�(&Y)",  "�C���X�g�[�������s���܂��B")
		New-Object $tChoiceDescription ("������(&N)", "�C���X�g�[���������A�X�L�b�v���Ď��̏����ɐi�݂܂��B")
	)

	$result = $host.ui.PromptForChoice($choiceTitle, $choiceMessage, $choiceOptions, 0)
	switch ($result) {
		0 {
			Write-Host -NoNewline "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h���Ă��܂�..."

			# Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h (�ҋ@)
			Start-Process -FilePath curl.exe -ArgumentList "-OL https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -WindowStyle Hidden -Wait

			Write-Host "����"
			Write-Host "Microsoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����s���܂��B"
			Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

			# Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[�����s (�ҋ@)
				# �����C���X�g�[���I�v�V������ǉ� by Atolycs (20250106)
			Start-Process -FilePath vcredist_x86.exe -ArgumentList "/qb" -WindowStyle Hidden -Wait

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
	Start-Process -FilePath curl.exe -ArgumentList "-OL https://aka.ms/vs/17/release/vc_redist.x86.exe" -WindowStyle Hidden -Wait

	Write-Host "����"
	Write-Host "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̓C���X�g�[������Ă��܂���B"

	# �I����������

	$choiceTitle = "Microsoft Visual C++ 2008 Redistributable - x86 ���C���X�g�[�����܂����H"
	$choiceMessage = "���̃p�b�P�[�W�͈ꕔ�̃X�N���v�g�̓���ɕK�v�ł��B�C���X�g�[���ɂ͊Ǘ��Ҍ������K�v�ł��B"

	$tChoiceDescription = "System.Management.Automation.Host.ChoiceDescription"
	$choiceOptions = @(
		New-Object $tChoiceDescription ("�͂�(&Y)",  "�C���X�g�[�������s���܂��B")
		New-Object $tChoiceDescription ("������(&N)", "�C���X�g�[���������A�X�L�b�v���Ď��̏����ɐi�݂܂��B")
	)

	$result = $host.ui.PromptForChoice($choiceTitle, $choiceMessage, $choiceOptions, 0)
	switch ($result) {
		0 {
			Write-Host -NoNewline "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h���Ă��܂�..."

			# Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[���_�E�����[�h (�ҋ@)
			Start-Process -FilePath curl.exe -ArgumentList "-OL https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -WindowStyle Hidden -Wait

			Write-Host "����"
			Write-Host "`r`nMicrosoft Visual C++ 2015-20xx Redistributable (x86) ��`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����s���܂��B"
			Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

			# VCruntimeInstall2015and2008.cmd �̑��݂���f�B���N�g�����m�F
				# VCruntimeInstall2015and2008.cmd �� Visual C++ 2015-20xx Redistributable (x86) ��
				# Visual C++ 2008 Redistributable - x86 �̃C���X�g�[���[�����ԂɎ��s���Ă��������̃X�N���v�g
			$VCruntimeInstallCmdDirectory = Join-Path -Path $scriptFileRoot -ChildPath script_files
			$VCruntimeInstallCmdPath = Join-Path -Path $VCruntimeInstallCmdDirectory -ChildPath "VCruntimeInstall2015and2008.cmd"
			if (!(Test-Path $VCruntimeInstallCmdPath)) {
				$VCruntimeInstallCmdDirectory = $scriptFileRoot
			}

			Start-Sleep -Milliseconds 500

			# VCruntimeInstall2015and2008.cmd ���Ǘ��Ҍ����Ŏ��s (�ҋ@)
			Start-Process -FilePath cmd.exe -ArgumentList "/C cd $VCruntimeInstallCmdDirectory & call VCruntimeInstall2015and2008.cmd & exit" -Verb RunAs -WindowStyle Hidden -Wait

			Write-Host "�C���X�g�[���[���I�����܂����B"
			break
		}
		1 {
			Write-Host "Microsoft Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[�����s���܂��B"
			Write-Host "�f�o�C�X�ւ̕ύX���K�v�ɂȂ�܂��B���[�U�[�A�J�E���g����̃|�b�v�A�b�v���o���� [�͂�] �������ċ����Ă��������B`r`n"

			# Visual C++ 2015-20xx Redistributable (x86) �̃C���X�g�[���[�����s (�ҋ@)
				# �����C���X�g�[���I�v�V������ǉ� by Atolycs (20250106)
			Start-Process -FilePath vc_redist.x86.exe -ArgumentList "/install /passive" -WindowStyle Hidden -Wait

			Write-Host "�C���X�g�[���[���I�����܂����B"
			Write-Host "`r`nMicrosoft Visual C++ 2008 Redistributable - x86 �̃C���X�g�[�����X�L�b�v���܂����B"
			break
		}
	}

	# �I�������܂�
}

Write-Host -NoNewline "`r`n�ݒ�t�@�C�����R�s�[���Ă��܂�..."

# �J�����g�f�B���N�g�����X�N���v�g�t�@�C���̂���f�B���N�g���ɕύX
Set-Location ..

# settings �f�B���N�g���̏ꏊ���m�F
New-Variable settingsDirectoryPath
if (Test-Path ".\settings") {
	$settingsDirectoryPath = Convert-Path ".\settings"
} elseif (Test-Path "..\settings") {
	$settingsDirectoryPath = Convert-Path "..\settings"
} else {
	Write-Host "���������G���[: settings �t�H���_��������܂���B"
}

Start-Sleep -Milliseconds 500

# �J�����g�f�B���N�g���� tmp �f�B���N�g���ɕύX
Set-Location tmp

# AviUtl\plugins ���� lsmash.ini �� MFVideoReaderConfig.ini ���R�s�[
Copy-Item "${settingsDirectoryPath}\lsmash.ini" C:\Applications\AviUtl\plugins
Copy-Item "${settingsDirectoryPath}\MFVideoReaderConfig.ini" C:\Applications\AviUtl\plugins

# AviUtl �f�B���N�g������ aviutl.ini, exedit.ini �� �f�t�H���g.cfg ���R�s�[
Copy-Item "${settingsDirectoryPath}\aviutl.ini" C:\Applications\AviUtl
Copy-Item "${settingsDirectoryPath}\exedit.ini" C:\Applications\AviUtl
Copy-Item "${settingsDirectoryPath}\�f�t�H���g.cfg" C:\Applications\AviUtl

Write-Host "����"
Write-Host -NoNewline "`r`n�f�X�N�g�b�v�ɃV���[�g�J�b�g�t�@�C�����쐬���Ă��܂�..."

# WSH��p���ăf�X�N�g�b�v��AviUtl�̃V���[�g�J�b�g���쐬����
$DesktopShortcutFolder = [Environment]::GetFolderPath("Desktop")
$DesktopShortcutFile = Join-Path -Path $DesktopShortcutFolder -ChildPath "AviUtl.lnk"
$DesktopWshShell = New-Object -comObject WScript.Shell
$DesktopShortcut = $DesktopWshShell.CreateShortcut($DesktopShortcutFile)
$DesktopShortcut.TargetPath = "C:\Applications\AviUtl\aviutl.exe"
$DesktopShortcut.IconLocation = "C:\Applications\AviUtl\aviutl.exe,0"
$DesktopShortcut.WorkingDirectory = "C:\Applications\AviUtl"
$DesktopShortcut.Save()

Write-Host "����"
Write-Host -NoNewline "�X�^�[�g���j���[�ɃV���[�g�J�b�g�t�@�C�����쐬���Ă��܂�..."

# WSH��p���ăX�^�[�g���j���[��AviUtl�̃V���[�g�J�b�g���쐬����
$ProgramsShortcutFolder = [Environment]::GetFolderPath("Programs")
$ProgramsShortcutFile = Join-Path -Path $ProgramsShortcutFolder -ChildPath "AviUtl.lnk"
$ProgramsWshShell = New-Object -comObject WScript.Shell
$ProgramsShortcut = $ProgramsWshShell.CreateShortcut($ProgramsShortcutFile)
$ProgramsShortcut.TargetPath = "C:\Applications\AviUtl\aviutl.exe"
$ProgramsShortcut.IconLocation = "C:\Applications\AviUtl\aviutl.exe,0"
$ProgramsShortcut.WorkingDirectory = "C:\Applications\AviUtl"
$ProgramsShortcut.Save()

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

	# aviutl-installer.cmd (���̃t�@�C��) �� script_files �f�B���N�g���Ɉړ�
	Move-Item aviutl-installer.cmd script_files -Force
}

# ���[�U�[�̑����҂��ďI��
Write-Host -NoNewline "`r`n`r`n`r`n�C���X�g�[�����������܂����I`r`n`r`n`r`nreadme �t�H���_���J����"
Pause

# �I������ readme �f�B���N�g����\��
Invoke-Item "C:\Applications\AviUtl\readme"
