; 1.0.0
; Tidev Auto Script

#NoTrayIcon


; Close program
AntiRunProgram('AdobeARM.exe')
AntiRunProgram('msoia.exe')
AntiRunProgram('UpdaterStartupUtility.exe')
AntiRunProgram('AAM Updates Notifier.exe')


; Close program X if Y not run
If ProcessExists('Chrome.exe')=0 Then
   AntiRunProgram('GoogleCrashHandler.exe')
   AntiRunProgram('GoogleCrashHandler64.exe')
EndIf

; Autocad 2020
If ProcessExists('acad.exe')=0 Then
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


If ProcessExists('revit.exe')=0 And ProcessExists('acad.exe')=0 Then
   AntiRunProgram('AdAppMgrSvc.exe')
EndIf


; Close program IDMIntegrator64.exe if IDMan.exe not run
If ProcessExists('IDMan.exe')=0 Then ProcessClose('IDMIntegrator64.exe')

; Close program and rename
If AntiRunProgram('MSOUC.EXE')=True Then
   FileMove('C:\Program Files\Microsoft Office\Office15\MSOUC.EXE','C:\Program Files\Microsoft Office\Office15\MSOUC.EXE[DISABLE]',1)
   FileMove('D:\Program Files\Microsoft Office\Office15\MSOUC.EXE','D:\Program Files\Microsoft Office\Office15\MSOUC.EXE[DISABLE]',1)
EndIf

; Close program and rename
If AntiRunProgram('MSOSYNC.EXE')=True Then
   FileMove('C:\Program Files\Microsoft Office\Office15\MSOSYNC.EXE','C:\Program Files\Microsoft Office\Office15\MSOSYNC.EXE[DISABLE]',1)
   FileMove('D:\Program Files\Microsoft Office\Office15\MSOSYNC.EXE','D:\Program Files\Microsoft Office\Office15\MSOSYNC.EXE[DISABLE]',1)
EndIf






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



