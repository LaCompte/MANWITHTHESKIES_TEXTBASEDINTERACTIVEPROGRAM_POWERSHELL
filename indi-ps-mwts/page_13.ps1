#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK = "`e[38;2;0;0;0m"
$BLUE  = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width
    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"

    for ($i=0; $i -lt $rows; $i++) {
        Write-Host ($cream + (" " * $cols) + $RESET)
    }

    Write-Host "`e[H"
}

# =============================================================
# UI HELPERS
# =============================================================
function Center {
    param([string]$text)
    $width = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)

    foreach ($ch in $text.ToCharArray()) {
        Write-Host -NoNewline $ch
        Start-Sleep -Milliseconds ($delay * 1000)
    }

    Write-Host ""
}

function FadeIn {
    param([string]$text, [string]$color)

    Write-Host "`e[2m$color$text$RESET"
    Start-Sleep -Seconds 2

    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep -Seconds 1

    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$txt)
    Write-Host ("| " + ("{0,-83}" -f $txt) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE SETTINGS
# =============================================================
$PageNumber = 13
$AllowSkip  = $true     # ✅ Page 13 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 13 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host ""

    Write-Host (Center "Press any key to begin")

    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        's' { if ($AllowSkip) { return "skip" } }
        default { return "continue" }
    }
}

# =============================================================
# TEXT PAGE
# =============================================================
function Show-TextPage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    BorderTop
    BorderLine "He walked on the cemented path, up the flight of stairs, and knocked on"
    BorderLine "the door... by pressing the bell on the wall marked \"bell\". He stepped"
    BorderLine "back, hearing the sound of footsteps - loud, marked footsteps - from"
    BorderLine "within the building. It took a while for the door to open, but it was an"
    BorderLine "intense duration of waiting."
    BorderLine ""
    BorderLine "The door opened. An elderly gentleman looked out and was greeted as per"
    BorderLine "custom, by the couple."
    BorderLine ""
    BorderLine "\"We take pride in him\" they said. the elderly gentleman offered his hand"
    BorderLine "to the applicant being discussed. He shook it, in what can best be"
    BorderLine "summarized as a neutral way of shaking hands: there was just enough"
    BorderLine "force to show acknowledgement but not enough to imply endearment - one"
    BorderLine "could not make an opinion from it."
    BorderLine ""
    BorderLine "the couple then cheered their son, and informed him that they will come"
    BorderLine "to pick him up before lunch. When he was inside the school, the Qin"
    BorderLine "smiled and described it to him. \"My father used to love walking in this"
    BorderLine "hallway\" he said, as he led him up a flight of stairs to the first"
    BorderLine "floor, left towards the fifth room in the general direction of the"
    BorderLine "teacher staff room. There were plenty of chairs and tables laid in an"
    BorderLine "orderly fashion in the room. \"You will be attended to, in a while\" the"
    BorderLine "Qin said, to which he responded to the Qin: \"Very well, sir\"."
    BorderLine ""
    BorderLine "\"Laraiez, if you must address me\" responded the Qin."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 14, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($k2) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_14.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
$result = Show-TitlePage
if ($result -ne "skip") {
    Start-Sleep -Milliseconds 300
}
Show-TextPage
