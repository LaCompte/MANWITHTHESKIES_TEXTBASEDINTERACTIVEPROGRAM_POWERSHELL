#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK = "`e[38;2;0;0;0m"
$BLUE = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width

    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"

    for ($i = 0; $i -lt $rows; $i++) {
        Write-Host ($cream + (" " * $cols) + $RESET)
    }

    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$text)
    $width = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
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

# Borders for text page
function BorderTop { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$text)
    Write-Host ("| " + ("{0,-83}" -f $text) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# Page settings
$PageNumber = 1
$AllowSkip = $true   # Page 01 *allows* skipping title

# =============================================================
# TITLE PAGE ROUTINE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 01 ---"
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
        's' {
            if ($AllowSkip) {
                return "skip"
            }
        }
        default { return "continue" }
    }
}

# =============================================================
# TEXT PAGE ROUTINE
# =============================================================
function Show-TextPage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    BorderTop
    BorderLine "It was on a moment's notice that was running on the radio as the car"
    BorderLine "made the curve. It had rained the previous night. And the car, although"
    BorderLine "in good condition, showed signs of wear and tear. The driver did not"
    BorderLine "seemed to be bothered by this; if anything, he whistled to the tune of"
    BorderLine "the song running on the radio. \"It was truly a dark and stormy night\"."
    BorderLine "He held the steering wheel with both hands, and controlled the car's"
    BorderLine "speed with the clutch and gear."
    BorderLine ""
    BorderLine "The inside composed of leather seats, floor mats, and the car's so"
    BorderLine "called \"cock-pit\". this portion was in less clean conditions than the"
    BorderLine "rest of the car, only because of the cups attached on top of one"
    BorderLine "another. It had been a long drive, and with the clearing road ahead of"
    BorderLine "him - \"why do people say empty road when they clearly always state that"
    BorderLine "the coast is clear?\" was the thought running in his mind - he gave the"
    BorderLine "indicator and took the turning for the hotel. It passed through a"
    BorderLine "boulevard, where trees swayed to the rustling of the wind. The road,"
    BorderLine "even with the steadily increasing fog, did not lead him astray: he"
    BorderLine "slowed his car steadily, at the gate where the plaque read \"Niner"
    BorderLine "Hotel\". He opened a khaki colored folder, took out a tri folded"
    BorderLine "brochure/envelope, opened it, and held out a piece of paper in his hand."
    BorderLine "After placing a hazard indicator, he stepped out of the car and walked"
    BorderLine "to the booth marked \"check-in\"."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 02, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_02.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION LOGIC
# =============================================================
$result = Show-TitlePage
if ($result -ne "skip") {
    Start-Sleep -Milliseconds 300
}
Show-TextPage
