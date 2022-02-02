; 1.0.6
; Tidev auto realtime script
; This script will be automatically updated periodically.
; You can edit the content, but when it is updated, the content you edit will be lost.
; Update time: 02/02/2022

#NoTrayIcon


; Antirun (close) program
#Region Antirun (close) program
AntiRunProgram('acrotray.exe')
AntiRunProgram('AdobeARM.exe')
AntiRunProgram('armsvc.exe')
AntiRunProgram('msoia.exe')
AntiRunProgram('UpdaterStartupUtility.exe')
AntiRunProgram('AAM Updates Notifier.exe')
#EndRegion Antirun (close) program


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


#Region NOT EDIT HERE