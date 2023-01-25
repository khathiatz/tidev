; 1.0.10
; Tidev auto realtime script
; This script will be automatically updated periodically.
; You can edit the content, but when it is updated, the content you edit will be lost.
; Update time: 09/02/2022

#NoTrayIcon
;~ #RequireAdmin



; Antirun (close) program
#Region Antirun (close) program
AntiRunProgram('acrotray.exe')
AntiRunProgram('AdobeARM.exe')
AntiRunProgram('armsvc.exe')
AntiRunProgram('msoia.exe')
AntiRunProgram('UpdaterStartupUtility.exe')
AntiRunProgram('AAM Updates Notifier.exe')
AntiRunProgram('jusched.exe')
#EndRegion Antirun (close) program


; FirewallAutoBlock program
#Region FirewallBlock program
; Adobe
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Adobe\Acrobat 11.0\Acrobat\Acrobat.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Common Files\Adobe\ARM\1.0\armsvc.exe')
; Autodesk
FirewallAutoBlock(@HomeDrive&'\Program Files\Autodesk\AutoCAD 2019\acad.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Autodesk\Autodesk Desktop App\AcWebBrowser\acwebbrowser.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Autodesk\Autodesk Desktop App\ADPClientService.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Autodesk\Autodesk Desktop App\AutodeskDesktopApp.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Autodesk\Content Service\Connect.Service.ContentService.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Common Files\Autodesk Shared\Adlm\R17\LMU.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files\Common Files\Autodesk Shared\AdLM\R12\LMU.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files\Common Files\Autodesk Shared\AdLM\R7\LMU.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files\Common Files\Autodesk Shared\AdLM\R9\LMU.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files\Common Files\Autodesk Shared\CLM\V3\MSVC14\cliccore\acwebbrowser.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files\Common Files\Macrovision Shared\FLEXnet Publisher\FNPLicensingService64.exe')
FirewallAutoBlock(@UserProfileDir&'\Autodesk\Genuine Service\GenuineService.exe')
; Office
FirewallAutoBlock(@HomeDrive&'\Program Files\Microsoft Office\Office15\WINWORD.EXE')
FirewallAutoBlock(@HomeDrive&'\Program Files\Microsoft Office\Office15\EXCEL.EXE')
FirewallAutoBlock(@HomeDrive&'\Program Files\Microsoft Office\Office15\POWERPNT.EXE')
; Orther
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\MathType\MathType.exe')
FirewallAutoBlock(@HomeDrive&'\Program Files (x86)\Common Files\Java\Java Update\jusched.exe')
FirewallAutoBlock(@HomeDrive&'\Windows\System32\spool\drivers\x64\3\fppdis4.exe')
FirewallAutoBlock(@HomeDrive&'\Windows\System32\spool\drivers\x64\3\fpphelp4.exe')

#EndRegion


; Close program X if Y not run
#Region Close program X if Y not run

If ProcessExists('acad.exe')=0 And ProcessExists('revit.exe')=0 Then ; Autocad, Revit
   AntiRunProgram('AdAppMgrSvc.exe')
   AntiRunProgram('ADPClientService.exe')
   AntiRunProgram('AdskLicensingAgent.exe')
   AntiRunProgram('AdSSO.exe')
   ;AntiRunProgram('AdskLicensingService.exe') ; Automatic services
   AntiRunProgram('FNPLicensingService.exe')
   AntiRunProgram('FNPLicensingService64.exe')
   AntiRunProgram('Connect.Service.ContentService.exe')
Else
;~    If ProcessExists('AdskLicensingService.exe')=0 Then Run('C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\9.0.1.1462\AdskLicensingService\AdskLicensingService.exe')
EndIf

;~ If ProcessExists('Chrome.exe')=0 Then ; Chrome
;~    AntiRunProgram('GoogleCrashHandler.exe')
;~    AntiRunProgram('GoogleCrashHandler64.exe')
;~ EndIf

If ProcessExists('GoogleDriveFS.exe')=0 Then ; GoogleDriveFS.exe
   AntiRunProgram('crashpad_handler.exe')
EndIf

If ProcessExists('IDMan.exe')=0 Then ; IDM
   ProcessClose('IDMIntegrator64.exe')
EndIf

#EndRegion Close program X if Y not run.


; Close program and rename
#Region Close program and rename

If AntiRunProgram('MSOUC.EXE')=True Then ; Office
   FileMove(@HomeDrive&'\Program Files\Microsoft Office\Office15\MSOUC.EXE',@HomeDrive&'\Program Files\Microsoft Office\Office15\MSOUC.EXE[DISABLE]',1)
   FileMove('D:\Program Files\Microsoft Office\Office15\MSOUC.EXE','D:\Program Files\Microsoft Office\Office15\MSOUC.EXE[DISABLE]',1)
EndIf

If AntiRunProgram('MSOSYNC.EXE')=True Then ; Office
   FileMove(@HomeDrive&'\Program Files\Microsoft Office\Office15\MSOSYNC.EXE',@HomeDrive&'\Program Files\Microsoft Office\Office15\MSOSYNC.EXE[DISABLE]',1)
   FileMove('D:\Program Files\Microsoft Office\Office15\MSOSYNC.EXE','D:\Program Files\Microsoft Office\Office15\MSOSYNC.EXE[DISABLE]',1)
EndIf

#EndRegion Close program and rename


; WinAutoFix
#Region WinAutoFix
Global $set_WinAutoFix=IniRead(@ScriptDir&'\data.ini','Settings','WinAutoFix','ON')
If $set_WinAutoFix='ON' Then
   WinAutoFix('Network')
EndIf

Func WinAutoFix($ERR)
   Local $return
   If $err='Network' Then ; #RequireAdmin
	  ; Code 0x80070035 The network path was not found
	  ; Source: https://windowsreport.com/0x80070035-internal-network by Ivan Jenic
	  ; Code 0x80004005 Unspecified error
	  ; Source: https://www.alphr.com/windows-cannot-access-computer-error-0x80004005/

;~ 	  RunWait(@ComSpec&' /c netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes','',@SW_HIDE)
;~ 	  RunWait(@ComSpec&' /c netsh advfirewall firewall set rule group="Network discovery" new enable=Yes','',@SW_HIDE)

	  ; Fix error 0x0000011b for LAN printer #RequireAdmin
	  $return=RegRead('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print','RpcAuthnLevelPrivacyEnabled') ; Default = not set
	  ;ConsoleWrite('$return = '&$return&@CRLF)
	  If $return<>0 Or $return='' Then
		 RegWrite('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print','RpcAuthnLevelPrivacyEnabled','REG_DWORD',0)
;~ 		 ConsoleWrite('RegWrite RpcAuthnLevelPrivacyEnabled = 0 (ERROR='&@error&')'&@CRLF)
	  EndIf

	  $return=RegRead('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters','restrictnullsessaccess') ; Default = 1
	  ;MsgBox(64,@ScriptName,'$return = "'&$return&'"') ; for DEV
	  If $return<>0 Then RegWrite('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters','restrictnullsessaccess','REG_DWORD',0)

	  $return=RegRead('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters','AllowInsecureGuestAuth') ; Default not set
	  ;MsgBox(64,@ScriptName,'$return = "'&$return&'"') ; for DEV
	  If $return<>1 Then RegWrite('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters','AllowInsecureGuestAuth','REG_DWORD',1)

   EndIf
EndFunc

#EndRegion WinAutoFix.

Exit ; Script will end here





#Region NOT EDIT HERE



; Auto close program if it run
; Ex: $programName = "program.exe"
; Ex: $programName = "Program" (Name of title bar)
Func AntiRunProgram($programName)
   If ProcessExists($programName)<>0 Then
	  If ProcessClose($programName)=1 Then
		 Return True
	  EndIf
   ElseIf WinExists($programName)=1 Then
	  If WinClose($programName)=1 Then
		 Return True
	  EndIf
   EndIf
   Return False
EndFunc



Func FirewallAutoBlock($file_dir)
   Local $func='FirewallAutoBlock'
   ConsoleWrite($func&': start'&@CRLF)

   If FileExists($file_dir)=0 Then
	  ConsoleWrite($func&': File not found "'&$file_dir&'"'&@CRLF)
	  Return SetError(1,0,0)
   EndIf
;~    ConsoleWrite($func&': File process "'&$file_dir&'"'&@CRLF)
;~    If IsAdmin()=0 Then Return


   Local $run, $report, $cmd, $cmd_report=@TempDir&'\TidevAuto_FirewallBlock.log'
   ; Kiểm tra có block chưa
   $cmd='netsh advfirewall firewall show rule name="'&$file_dir&'"'
   FileDelete($cmd_report)
   $run=RunWait(@ComSpec&' /c '&$cmd&' > "'&$cmd_report&'"','',@SW_HIDE)
   If @error>0 Or FileExists($cmd_report)=0 Then
	  $errorTXT='ERR_CMD_NOT_RUN_TO_CHECK'
	  ConsoleWrite($func&': '&$errorTXT&@CRLF)
	  Return SetError(1,0,0)
   EndIf
   $report=FileReadLine($cmd_report,12)
   FileDelete($cmd_report)
;~    If IsAdmin()=1 Then MsgBox(64,$func,'$report= '&$report,20) ; for DEV
;~    ConsoleWrite($func&': $report= '&$report&@CRLF)

   ; Check file is blocked
   If StringLeft($report,7)='Action:' And StringRight($report,5)='Block' Then
	  $errorTXT='ERR_FILE_BLOCKED'
	  ConsoleWrite($func&': '&$errorTXT&' ('&$file_dir&')'&@CRLF)
	  Return SetError(2,0,0)
   EndIf

   ; Block file
   $cmd='netsh advfirewall firewall delete rule name="'&$file_dir&'"' ; need Admin
   $run=RunWait(@ComSpec&' /c '&$cmd&' > "'&$cmd_report&'"','',@SW_HIDE)
   If @error>0 Or FileExists($cmd_report)=0 Then
	  $errorTXT='ERR_CMD_NOT_RUN_TO_DELETE'
	  ConsoleWrite($func&': '&$errorTXT&@CRLF)
	  Return SetError(3,0,0)
   EndIf
   $report=FileRead($cmd_report)
   FileDelete($cmd_report)
;~    If IsAdmin()=1 Then MsgBox(64,$func,'$report= '&$report,20) ; for DEV
   ConsoleWrite($func&': $report= '&$report&@CRLF)

   $cmd='netsh advfirewall firewall add rule name="'&$file_dir&'" dir=out action=block program="'&$file_dir&'" enable=yes' ; need Admin
   $run=RunWait(@ComSpec&' /c '&$cmd&' > "'&$cmd_report&'"','',@SW_HIDE)
   If @error>0 Or FileExists($cmd_report)=0 Then
	  $errorTXT='ERR_CMD_NOT_RUN_TO_ADD'
	  ConsoleWrite($func&': '&$errorTXT&@CRLF)
	  Return SetError(3,0,0)
   EndIf
   $report=FileRead($cmd_report)
   FileDelete($cmd_report)
;~    If IsAdmin()=1 Then MsgBox(64,$func,'$report= '&$report,20) ; for DEV
   ConsoleWrite($func&': $report= '&$report&@CRLF)
EndFunc



#Region NOT EDIT HERE