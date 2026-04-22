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
$PageNumber = 2
$AllowSkip = $true   # Page 02 allows skip

# =============================================================
# TITLE PAGE ROUTINE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 02 ---"
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
# TEXT PAGE ROUTINE
# =============================================================
function Show-TextPage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    BorderTop
    BorderLine "\"Your good name please:, to wit, the response was noted and shared with"
    BorderLine "the check-in booth. The car made its way through the lush green, fairly"
    BorderLine "moist front yard of the Niner, in the direction of the entrance of the"
    BorderLine "hotel. He handed the car to the valet, and climbed the stairs. \"Where"
    BorderLine "are you lovely princesses, who were mentioned in the brochure?\" he asked"
    BorderLine "himself, as he turned to and for. With an \"Ah!\" he made his way to the"
    BorderLine "reception. \"Welcome to the Niner hotel, where... you seem to have been a"
    BorderLine "regular of ours, always a pleasure... We made a few changes to the hotel"
    BorderLine "even if it seems that the Niner looks the same as your father"
    BorderLine "described... spoken like a true Niner, well... here are the details of"
    BorderLine "your room, and also... ah, great; enjoy your stay here, elevators are at"
    BorderLine "the left atrium.\""
    BorderLine ""
    BorderLine "The guest walked to the elevators, holding his briefcase and hotel keys."
    BorderLine "He was given company by the tapping sound which his shoes made as they"
    BorderLine "made contact with the freshly polished granite floor. From where he"
    BorderLine "stood, it looked like a painting; it was boring, and reminded of how"
    BorderLine "long the elevator took to arrive to its relevant floor. Upon entering,"
    BorderLine "he found that it had been full of air, giving off a cold aura. It wasn't"
    BorderLine "in fact the case; The elevator stopped at the required floor, from where"
    BorderLine "the guest made his way to his room. \"Aye, mist... that view indeed.\" he"
    BorderLine "said, looking at the fog over the lake."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 03, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_03.ps1"; exit }
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
