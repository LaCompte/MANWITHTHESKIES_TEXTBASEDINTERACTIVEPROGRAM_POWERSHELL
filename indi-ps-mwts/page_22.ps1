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
    $pad   = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)
    foreach ($c in $text.ToCharArray()) {
        Write-Host -NoNewline $c
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

function BorderTop    { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$t)
    Write-Host ("| " + ("{0,-83}" -f $t) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 22
$AllowSkip  = $true   # Page 22 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 22 ---"
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

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
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
    BorderLine "Punbell quietly looked at the numerous documents, and classifying them"
    BorderLine "in his routine means. He noticed Punbell's box in the center of the"
    BorderLine "table, which he had last noticed on the rightmost corner. Punbell"
    BorderLine "lowered his gaze and observed the box carefully. Punbell held the box"
    BorderLine "with both hands, placed it at the center-right, and then used gestures"
    BorderLine "to inquire regarding the nature of this gift or offering. He nodded to"
    BorderLine "the discussion which ensued, and to the message Elias had included with"
    BorderLine "the offering."
    BorderLine ""
    BorderLine "Punbell smiles - which was something that lightened up the mood in the"
    BorderLine "library - and shook his head. He opened up the box and, taking note of"
    BorderLine "what had been offered, he placed it in one of the cupboards. Punbell had"
    BorderLine "noticed him quietly looking in the direction of Towers 50 and 32."
    BorderLine "Punbell subtly took note of what had been keeping his eye diverted, and"
    BorderLine "to his disappointment, it was boredom. Punbell shook his head in"
    BorderLine "disappointment and walked up to him."
    BorderLine ""
    BorderLine "Punbell pointed at the towers and gestured him to bring a specific"
    BorderLine "something from one of the towers, noting that the details of the last"
    BorderLine "owner was missing in the files. He got up and walked up the stairs to"
    BorderLine "Tower 40. He continued walking and kept his eyes fixed onto the shelves."
    BorderLine "He accidentally bumped into a little girl, and both of them fell back."
    BorderLine "They apologized to each other. Before he could go on his way, the girl"
    BorderLine "offered her hand and said `"My name is...`" He tried to remember her name"
    BorderLine "but it did not seem to register. He took out the book from the shelf and"
    BorderLine "brought it down to Punbell."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 23, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_23.ps1"; exit }
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
