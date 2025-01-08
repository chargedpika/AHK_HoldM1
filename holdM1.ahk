#Persistent
#SingleInstance Force
SetWorkingDir %A_ScriptDir%  ; Ensure relative paths work

toggle := false
windowTitle := ""
clickSpeed := 50

; Launch GUI
Gui, Add, Text,, Window Title:
Gui, Add, Edit, vwindowTitle w300, write the name of the app you want to autoclick
Gui, Add, Text,, Click Speed (ms between clicks):
Gui, Add, Edit, vclickSpeed w100, 1
Gui, Add, Button, gToggleClicking, Toggle Rapid Clicking
Gui, Add, Button, gExitApp, Exit
Gui, Show,, Rapid Click Config

return

; F7 toggles rapid click mode on or off
F7::
    toggle := !toggle
    if (toggle)
    {
        Gui, Submit, NoHide  ; Update settings when toggling
        ToolTip Rapid Click: ON for %windowTitle%
    }
    else
        ToolTip Rapid Click: OFF
    Sleep 1000
    ToolTip
return

ToggleClicking:
    Gui, Submit, NoHide
    toggle := !toggle
    if (toggle)
        ToolTip Rapid Click: ON for %windowTitle%
    else
        ToolTip Rapid Click: OFF
    Sleep 1000
    ToolTip
return

~LButton::
    if (toggle)
    {
        WinGetActiveTitle, activeWin
        if (InStr(activeWin, windowTitle))
        {
            While GetKeyState("LButton", "P")
            {
                Click
                Sleep %clickSpeed%
                WinGetActiveTitle, currentWin
                if !(InStr(currentWin, windowTitle))
                    break
            }
        }
    }
return

ExitApp:
    ExitApp
return
