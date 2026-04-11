#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; 0. AJUSTES DE INICIO Y MANTENIMIENTO
; ==============================================================================
Sleep 5000 
TraySetIcon "shell32.dll", 283 
A_IconHidden := false

; --- CARGADOR DE VARIABLES DE ENTORNO (.ENV) ---
CargarEnv() 
{
    global Path_MonitorTool, Path_SoundView, MonitorID
    EnvFile := A_ScriptDir . "\.env" ; Busca el archivo en la misma carpeta

    if FileExist(EnvFile)
    {
        Loop Read, EnvFile
        {
            ; Ignorar comentarios (#) o líneas vacías
            if (A_LoopReadLine = "" or SubStr(Trim(A_LoopReadLine), 1, 1) = "#")
                continue

            ; Separar CLAVE=VALOR
            if (InStr(A_LoopReadLine, "="))
            {
                Parts := StrSplit(A_LoopReadLine, "=", , 2)
                Key := Trim(Parts[1])
                Val := Trim(Parts[2])
                
                ; Quitar comillas dobles si existen
                Val := StrReplace(Val, '"', "")

                ; Asignar a las variables globales correspondientes
                if (Key = "PATH_MONITOR_TOOL")
                    Path_MonitorTool := Val
                else if (Key = "PATH_SOUND_VIEW")
                    Path_SoundView := Val
                else if (Key = "MONITOR_ID")
                    MonitorID := Val
            }
        }
    }
    else
    {
        MsgBox("⚠️ ADVERTENCIA: No se encontró el archivo .env`n`nAsegúrate de crearlo con tus rutas para que los atajos funcionen.")
    }
}

; Llamamos a la función inmediatamente para llenar las variables
Path_MonitorTool := ""
Path_SoundView := ""
MonitorID := ""
CargarEnv()

; ------------------------------------------------------------------------------

^!r::
{
    Reload
    SoundBeep 750, 200
}

^!e::
{
    ; Busca VS Code y abre la carpeta del proyecto (Incluye .git y .env)
    PathVSCode := EnvGet("LOCALAPPDATA") . "\Programs\Microsoft VS Code\Code.exe"
    if !FileExist(PathVSCode)
        PathVSCode := "C:\Program Files\Microsoft VS Code\Code.exe"

    if FileExist(PathVSCode)
        Run '"' . PathVSCode . '" "' . A_ScriptDir . '"'
    else
        Run "explorer.exe " . A_ScriptDir
}

; ==============================================================================
; 1. AUTO-ELEVACIÓN (ADMINISTRADOR)
; ==============================================================================
if not A_IsAdmin {
    try
    {
        Run "*RunAs " A_ScriptFullPath
    }
    catch {
        MsgBox("El script necesita permisos de administrador para funcionar.")
    }
    ExitApp
}

; ==============================================================================
; 2. CONFIGURACIÓN GLOBAL (Ya cargada desde .env)
; ==============================================================================
; Las variables Path_MonitorTool, Path_SoundView y MonitorID ya tienen valor aquí.

; ==============================================================================
; 3. GESTIÓN DE PANTALLA
; ==============================================================================
^!Up::    RotarPantalla(0)
^!Right:: RotarPantalla(90)
^!Left::  RotarPantalla(270)

RotarPantalla(grados) {
    global Path_MonitorTool, MonitorID
    if (Path_MonitorTool != "" and FileExist(Path_MonitorTool))
        Run(Path_MonitorTool . " /SetOrientation " . MonitorID . " " . grados, , "Hide")
    else
        MsgBox("Error: Ruta de MultiMonitorTool no válida en .env")
}

; ==============================================================================
; 4. UTILIDADES
; ==============================================================================
#HotIf !WinActive("ahk_exe javaw.exe")
^SPACE::
{
    if WinGetExStyle("A") & 0x8 {
        WinSetAlwaysOnTop 0, "A"
        ToolTip "📌 OFF: Ventana liberada"
    }
    else {
        WinSetAlwaysOnTop 1, "A"
        ToolTip "📌 ON: Ventana fijada"
    }
    SetTimer () => ToolTip(), -2000
}
#HotIf

::clg::console.log();{Left 2}

; ==============================================================================
; 5. TECLADO ESPAÑOL
; ==============================================================================
#HotIf !WinActive("ahk_group Juegos")
SetKeyDelay 50
>!n::SendEvent "{Text}ñ"
>!+n::SendEvent "{Text}Ñ"
>!a::SendEvent "{Text}á"
>!e::SendEvent "{Text}é"
>!i::SendEvent "{Text}í"
>!o::SendEvent "{Text}ó"
>!u::SendEvent "{Text}ú"
>!/::SendEvent "{Text}¿"
>!1::SendEvent "{Text}¡"
#HotIf

; ==============================================================================
; 6. AUDIO AVANZADO
; ==============================================================================
#HotIf MouseIsOver("ahk_class Shell_TrayWnd") or MouseIsOver("ahk_class Shell_SecondaryTrayWnd")
    WheelUp::  Send "{Volume_Up}"
    WheelDown::Send "{Volume_Down}"
    
    MButton::
    {
        SoundSetMute "-1"
        ; SoundBeep 750, 100 ; Un pequeño pitido para confirmar
    }
#HotIf

!WheelUp::   CambiarVolumenApp(5)
!WheelDown:: CambiarVolumenApp(-5)

; B) Volumen POR APP (Scroll sobre Botones: Minimizar, Maximizar, Cerrar)
; Detecta si el mouse está sobre los botones de control de la ventana
#HotIf MouseIsOverTitleButtons()
    WheelUp:: CambiarVolumenApp(5)
    WheelDown:: CambiarVolumenApp(-5)
#HotIf

; --- Función Auxiliar para detectar botones de ventana ---
MouseIsOverTitleButtons() {
    MouseGetPos , , &WinID
    if !WinID
        return false

    ; Necesitamos coordenadas absolutas (Screen) para el mensaje de Windows
    CoordMode "Mouse", "Screen"
    MouseGetPos &MX, &MY
    
    try {
        ; WM_NCHITTEST (0x0084) pregunta a la ventana: "¿Qué hay bajo el mouse?"
        ; Empaquetamos las coordenadas X e Y en el LPARAM
        HitTest := SendMessage(0x84, 0, (MY << 16) | (MX & 0xFFFF), , "ahk_id " WinID)
        
        ; Códigos de retorno de Windows:
        ; 8 = MinButton, 9 = MaxButton, 20 = CloseButton
        return (HitTest = 8 || HitTest = 9 || HitTest = 20)
    }
    return false
}
CambiarVolumenApp(step) {
    global Path_SoundView
    MouseGetPos , , &WinID
    try {
        NombreProceso := WinGetProcessName("ahk_id " . WinID)
        if (NombreProceso != "") {
            if (Path_SoundView != "" and FileExist(Path_SoundView)) {
                Run(Path_SoundView . " /ChangeVolume " . NombreProceso . " " . step, , "Hide")
                ToolTip("🔊 " . NombreProceso . ": " . step . "%")
                SetTimer () => ToolTip(), -1000
            }
        }
    }
}

MouseIsOver(WinTitle) {
    MouseGetPos , , &Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

; ==============================================================================
; 7. EXTRAS
; ==============================================================================
#!c:: 
{
    MouseGetPos &MouseX, &MouseY
    Color := PixelGetColor(MouseX, MouseY)
    A_Clipboard := Color
    ToolTip "🎨 Color copiado: " . Color
    SetTimer () => ToolTip(), -1500
}