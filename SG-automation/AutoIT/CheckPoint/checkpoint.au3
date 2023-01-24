
#include <MsgBoxConstants.au3>
Global $apppath = ""
Global $appfolder = ""
Global $account = $CmdLine[1]
Global $password = $CmdLine[2]
Global $asset = $CmdLine[3]

 $apppath =   "C:\Program Files (x86)\CheckPoint\SmartConsole\R81.10\PROGRAM\SmartConsole.exe" 
 $appfolder = "C:\Program Files (x86)\CheckPoint\SmartConsole\R81.10\PROGRAM"

;HwndWrapper[SmartConsole.exe;;ba23c55d-8f5b-434b-9e2b-bc3dbf6dc15b]

Start($apppath, $appfolder)

Login($asset, $account, $password)

Func Login($asst, $acct, $passwd)
  
  	Sleep(22500)
	
	If WinActive ( "Check Point SmartConsole" ) Then 
        Sleep(500)
		Sleep(500)
		 If WinActivate("Check Point SmartConsole") Then
                Send($acct) 		
				Sleep(500)         
        EndIf
		
		If WinActivate("Check Point SmartConsole") Then
			Send("{Tab}")
			Send($passwd)
			Sleep(500)
		EndIf
		
		If WinActivate("Check Point SmartConsole") Then
			Send("{Tab}")
			Sleep(500)
			Send("{Tab}")
			Send($asst) 
			Sleep(500)
		EndIf
		
		If WinActivate("Check Point SmartConsole") Then
			Send("{Tab}")
			Send("{Tab}")
			Send("{Tab}")
			Send("{ENTER}")
		EndIf

EndIf  

EndFunc

Func Start($path, $folder)
	Run($path, $folder)
EndFunc


