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

function TypeWriterSlow {
    param([string]$text, [double]$delay = 0.3)
    foreach ($c in $text.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
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
$PageNumber = 26
$AllowSkip  = $true   # Page 26 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 26 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $header 0.3
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
    BorderLine "He looked back at the notes he had made whilst writing, and continued to"
    BorderLine "whistle as he made his written thoughts clear. He heard a horn from one"
    BorderLine "side of the road, heading in the direction of the library. He couldn't"
    BorderLine "make out who was driving, but he noted that the boy sitting on the"
    BorderLine "passenger seat was much more quiet than his general nature. It had a"
    BorderLine "certain degree of nostalgia to it, which he could not put into words. He"
    BorderLine "noted it and continued to walk downwards from the hilly road. `"Seems"
    BorderLine "like a natural way to go`" he thought to himself."
    BorderLine ""
    BorderLine "Elias had just opened a box of Yivelis, and offered it to him. `"You"
    BorderLine "might as well have some. You sound like a scientist who discovered what"
    BorderLine "our water is composed of`" Elias advised, and took note of what had been"
    BorderLine "described in the notepad. Elias nodded, and answered with foresight,"
    BorderLine "`"There may perhaps be an answer to be found at the house in the middle"
    BorderLine "of the street. It is not that far from there. The kid and you might have"
    BorderLine "a lot more in common than you think.`" Elias took one Yivelis, and dipped"
    BorderLine "it in his tea. He looked at the shelves in Elias' store, finding that"
    BorderLine "they looked the same, in a different sort of way. He noted it in his"
    BorderLine "thoughts."
    BorderLine ""
    BorderLine "He got up to walk out of the shop. Before he left, he looked at Elias."
    BorderLine "Elias pondered with his tea, and after pointing his finger towards the"
    BorderLine "sky in a revelation, he took out a box, and gave him a book. `"The kid"
    BorderLine "had asked me to reserve it for his summer break. You should ask him"
    BorderLine "about it when you two meet up.`" Elias explained to him, and Elias waved"
    BorderLine "goodbye. He left the shop, with thoughts about the purple flower having"
    BorderLine "limited importance to him."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 27, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_27.ps1"; exit }
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
