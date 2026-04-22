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
        Write-Host ($cream + (' ' * $cols) + $RESET)
    }
    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$text)
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $text
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
    Start-Sleep 2
    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
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
# PAGE SETTINGS
# =============================================================
$PageNumber = 19
$AllowSkip  = $true    # ✅ Page 19 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 19 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
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
    BorderLine "Elias looked at him and asked whilst he took out some more dolls: \"I"
    BorderLine "heard that you started working at the library\". Most of the dolls which"
    BorderLine "Elias took out from the box were hand-made, and had small notes included"
    BorderLine "with each one provided separately. They were varied in length - some of"
    BorderLine "them were only two sentences long, others tended to be at least two"
    BorderLine "paragraphs. Their quality, however, was uniform: they explained where"
    BorderLine "the dolls had been hand-sown and what manufacturing quality standards"
    BorderLine "were followed. \"So I heard; Lebrius Punbell should come over to my shop"
    BorderLine "from time to time. Do let him know next time you get to meet him.\" He"
    BorderLine "heard Elias say as he entered the shop."
    BorderLine ""
    BorderLine "Upon entering, Elias tapped him on the shoulder and offered him a box."
    BorderLine "\"As an offering from me to Punbell. Just share those words with him when"
    BorderLine "you meet him, he will understand what I am referring to.\" he took the"
    BorderLine "box from Elias and left the shop. He saw some of the flowers were being"
    BorderLine "taken from Tabitha's. He hastened his way in the direction of Punbell,"
    BorderLine "preoccupied at the moment to note who the buyer was."
    BorderLine ""
    BorderLine "The fog was thickest as he left the street towards the main road but"
    BorderLine "slowly became less thick after some time. It was being referred in the"
    BorderLine "radio as well. \"Where does the lonely road go\" was among the better"
    BorderLine "known songs which would have radio play, and yet it would always run"
    BorderLine "from the middle - the chorus - rather than the beginning. He whistled"
    BorderLine "the chorus to himself as he walked onwards."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 20, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($k2) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_20.ps1"; exit }
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
