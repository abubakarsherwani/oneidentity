; ONLY FOR DEMO USE
; cmd line arguments for lacunher: OI-SG-RemoteApp-Launcher.exe --cmd <path>\web_SPS.exe --args {username} {password} {asset}

Global $apppath = ""
Global $appfolder = ""
Global $account = $CmdLine[1]
Global $password = $CmdLine[2]
Global $asset = $CmdLine[3]

$apppath = "C:\Users\admin\Desktop\sqldeveloper-21.4.2.018.1706-x64\sqldeveloper\sqldeveloper.exe"
$appfolder = "C:\Users\admin\Desktop\sqldeveloper-21.4.2.018.1706-x64\sqldeveloper"

Start($apppath, $appfolder)
Login($asset, $account, $password)

Func Login($asst, $acct, $passwd)

   WinWaitActive("Oracle SQL Developer")
   Sleep(8500)
   ;Send("{CTRLDOWN}")
   Send("^n")
   ;Send("{CTRLUP}")
   WinWaitActive("New Gallery")
   ConsoleWrite("Gallery shown...  ")
   Send("i")
   Send("{ENTER}")
   WinWaitActive("New / Select Database Connection")
   ConsoleWrite("connection screen recognized")
   Sleep(1800)
   ;WinActivate("New / Select Database Connection")
   ;WinSetState("New / Select Database Connection","",@SW_HIDE)
   Send("SG-" & $acct & "@" & $asst)
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send($acct)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send($passwd)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   Send("{TAB}")
   Sleep(100)
   
   local $loc = StringInStr($asst, "_")
   local $loc_ = $loc - 1
   local $hostname = StringMid("hostname_ser", 1,$loc_)
   
   
   Send($hostname)
   ;WinSetState("New / Select Database Connection","",@SW_SHOW)

   ;-- if we get the overwrite dialog, send 'Yes'
   Sleep(500)

   If WinActive("Connection Name in use") Then
	  Send("!y")
   EndIf
  ; ----------------

  ;-- if we get the password prompt of an already saved connection
   Sleep(500)

   If WinActive("Connection Information") Then
	  Send($passwd)
   EndIf
  ; ----------------


EndFunc

Func Start($path, $folder)
	Run($path, $folder);, @SW_MAXIMIZE)
EndFunc

