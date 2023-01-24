#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
#include <Array.au3>
#include <WinAPI.au3>

_Example()
Func _Example()
    MsgBox(0, "Make your window active!" , 'This Message Box will be closed in 5 seconds', 5)

    Local $sControlText = GetAllWindowsControls(WinGetHandle("[ACTIVE]"))
    ClipPut($sControlText)
    ConsoleWrite($sControlText)
EndFunc   ;==>_Example


; #FUNCTION# ====================================================================================================================
; Name ..........: GetAllWindowsControls
; Description ...:
; Syntax ........: GetAllWindowsControls($hCallersWindow[, $bOnlyVisible = Default[, $sStringIncludes = Default[, $sClass = Default]]])
; Parameters ....: $hCallersWindow      - a handle value.
;                  $bOnlyVisible        - [optional] a boolean value. Default is Default.
;                  $sStringIncludes     - [optional] a string value. Default is Default.
;                  $sClass              - [optional] a string value. Default is Default.
; Return values .: String with Controls descriptions.
; Author ........: jdelaney
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........: https://www.autoitscript.com/forum/topic/164226-get-all-windows-controls/
; Example .......: No
; ===============================================================================================================================
Func GetAllWindowsControls($hCallersWindow, $bOnlyVisible = Default, $sStringIncludes = Default, $sClass = Default)
    If Not IsHWnd($hCallersWindow) Then
        ConsoleWrite("$hCallersWindow must be a handle...provided=[" & $hCallersWindow & "]" & @CRLF)
        Return False
    EndIf

    ; Get all list of controls
    If $bOnlyVisible = Default Then $bOnlyVisible = False
    If $sStringIncludes = Default Then $sStringIncludes = ""
    If $sClass = Default Then $sClass = ""

    Local $sClassList = WinGetClassList($hCallersWindow)

    ; Create array
    Local $aClassList = StringSplit($sClassList, @CRLF, 2)

    ; Sort array
    _ArraySort($aClassList)
    _ArrayDelete($aClassList, 0)

    ; Loop
    Local $iCurrentClass = ""
    Local $iCurrentCount = 1
    Local $iTotalCounter = 1

    If StringLen($sClass) > 0 Then
        For $i = UBound($aClassList) - 1 To 0 Step -1
            If $aClassList[$i] <> $sClass Then
                _ArrayDelete($aClassList, $i)
            EndIf
        Next
    EndIf

    Local $hControl = Null, $aControlPos
    Local $sControlText = ''
    Local $iControlID = 0
    Local $bIsVisible = False
    Local $sResult = ''

    For $iClass_idx = 0 To UBound($aClassList) - 1
        If $aClassList[$iClass_idx] = $iCurrentClass Then
            $iCurrentCount += 1
        Else
            $iCurrentClass = $aClassList[$iClass_idx]
            $iCurrentCount = 1
        EndIf

        $hControl = ControlGetHandle($hCallersWindow, "", "[CLASSNN:" & $iCurrentClass & $iCurrentCount & "]")
        $sControlText = StringRegExpReplace(ControlGetText($hCallersWindow, "", $hControl), "[\n\r]", "{@CRLF}")
        $aControlPos = ControlGetPos($hCallersWindow, "", $hControl)
        $iControlID = _WinAPI_GetDlgCtrlID($hControl)
        $bIsVisible = ControlCommand($hCallersWindow, "", $hControl, "IsVisible")
        If $bOnlyVisible And Not $bIsVisible Then
            $iTotalCounter += 1
            ContinueLoop
        EndIf

        If StringLen($sStringIncludes) > 0 Then
            If Not StringInStr($sControlText, $sStringIncludes) Then
                $iTotalCounter += 1
                ContinueLoop
            EndIf
        EndIf

        If IsArray($aControlPos) Then
            $sResult &= "Func=[GetAllWindowsControls]: ControlCounter=[" & StringFormat("%3s", $iTotalCounter) & "] ControlID=[" & StringFormat("%5s", $iControlID) & "] Handle=[" & StringFormat("%10s", $hControl) & "] ClassNN=[" & StringFormat("%19s", $iCurrentClass & $iCurrentCount) & "] XPos=[" & StringFormat("%4s", $aControlPos[0]) & "] YPos=[" & StringFormat("%4s", $aControlPos[1]) & "] Width=[" & StringFormat("%4s", $aControlPos[2]) & "] Height=[" & StringFormat("%4s", $aControlPos[3]) & "] IsVisible=[" & $bIsVisible & "] Text=[" & $sControlText & "]." & @CRLF
        Else
            $sResult &= "Func=[GetAllWindowsControls]: ControlCounter=[" & StringFormat("%3s", $iTotalCounter) & "] ControlID=[" & StringFormat("%5s", $iControlID) & "] Handle=[" & StringFormat("%10s", $hControl) & "] ClassNN=[" & StringFormat("%19s", $iCurrentClass & $iCurrentCount) & "] XPos=[winclosed] YPos=[winclosed] Width=[winclosed] Height=[winclosed] Text=[" & $sControlText & "]." & @CRLF
        EndIf

        If Not WinExists($hCallersWindow) Then ExitLoop
        $iTotalCounter += 1
    Next
    Return $sResult
EndFunc   ;==>GetAllWindowsControls