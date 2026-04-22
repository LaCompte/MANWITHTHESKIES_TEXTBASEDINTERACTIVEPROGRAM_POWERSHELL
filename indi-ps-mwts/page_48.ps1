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
$PageNumber = 48
$AllowSkip  = $true   # Page 48 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 48 ---"
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
    BorderLine "`"The stork braved through the winds and the fog, he stood his ground and"
    BorderLine "he didn't give up. You see, contrary to what the pigeons had thought,"
    BorderLine "this stork had actually traveled through similar weather just to get the"
    BorderLine "assignment. To him, it wasn't a matter of life or death, or even"
    BorderLine "survival. It was purely a test of strength. And he knew that he would"
    BorderLine "succeed. He used all his experience and skills to not only keep the"
    BorderLine "package safe, but also keep his flight safe from harm's way."
    BorderLine ""
    BorderLine "`"There was silence in the office, meanwhile. The stork had not provided"
    BorderLine "any response yet. The pigeons were concerned, but the eagle was"
    BorderLine "confident that all will turn out fine. If anyone among the pigeons had"
    BorderLine "doubts about their boss' judgment, it was driven away the moment they"
    BorderLine "heard him singing to himself. It was one of his favorite songs,"
    BorderLine "something they knew he would sing when he was sure of his decision."
    BorderLine "After all, he had never been wrong before. The rain grayed the skyline,"
    BorderLine "and the fog did not help matters either. Still, they decided to wait."
    BorderLine "One of two outcomes was inevitable in this situation - either the stork"
    BorderLine "would reach his destination; or they will receive news that their"
    BorderLine "package did not reach its destination. Still, there was no point in"
    BorderLine "being doubtful, so they hoped for the best."
    BorderLine ""
    BorderLine "`"After what seemed like a whole day, or rather, as if a day and a night"
    BorderLine "had passed, they received a phone call. There was an overwhelming"
    BorderLine "silence - the moment of truth was here. The director was put on the"
    BorderLine "line, He gave his designation, waiting for a response. And the response"
    BorderLine "came: 'we got another customer, boss. They wanted to thank you"
    BorderLine "personally.'"
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 49, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_49.ps1"; exit }
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
