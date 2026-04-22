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
$PageNumber = 36
$AllowSkip  = $true   # Page 36 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 36 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")

    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

    Write-Host ""
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
    BorderLine "He nodded at Laraiez, and bid him farewell. He looked at the ants,"
    BorderLine "scurrying around the field. Some of them gathered into a big cluster,"
    BorderLine "and with their combined might, they pulled some of the breadcrumbs"
    BorderLine "together with them into their ant-house. He felt a tingling feeling on"
    BorderLine "his back, running up to his neck and down his spine. He got up, more out"
    BorderLine "of an unavoidable, involuntary reflex to be as far away from the insects"
    BorderLine "as possible. He shuddered at his situation, but said to himself, `"you"
    BorderLine "are bigger than them, you should not worry about being overwhelmed.`" He"
    BorderLine "decided to walk over to the office of the Qin."
    BorderLine ""
    BorderLine "Bardia arrived at the entrance of the office of the Qin. He was"
    BorderLine "initially worried, but seemed to be at ease once he saw one of his own"
    BorderLine "sitting and waiting. He smiled at Bardia, and asked him `"How did your"
    BorderLine "day go?`" Bardia shrugged his shoulders, and bobbed his head to and fro."
    BorderLine "He nodded at Bardia, and offered him a seat. Both Bardia and he, sat"
    BorderLine "next to each other, quietly noting a blank wall opposite to the office"
    BorderLine "of the Qin. He told Bardia `"You should know, there used to be a painting"
    BorderLine "on that wall at one point.`" Bardia looked at the wall, then looked at"
    BorderLine "him. Bardia shook his head in disagreement. He looked at Bardia and"
    BorderLine "nodding, reassuring that there had been a painting on this wall. Bardia"
    BorderLine "disagreed a second time. He got up, walked to the wall, and took note of"
    BorderLine "its details."
    BorderLine ""
    BorderLine "`"Ah ha! There it is!`" He pointed to a hole at one point of the wall."
    BorderLine "Bardia looked at the hole in question, and gave a look of confusion."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 37, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_37.ps1"; exit }
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
