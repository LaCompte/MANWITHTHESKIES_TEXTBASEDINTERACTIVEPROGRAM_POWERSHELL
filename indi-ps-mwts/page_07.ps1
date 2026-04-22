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

    for ($i = 0; $i -lt $rows; $i++) {
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

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$text)
    Write-Host ("| " + ("{0,-83}" -f $text) + " |")
}

function SplitTop {
    Write-Host "|----------------------------------------------------||-------------------------------\"
}
function SplitBottom {
    Write-Host "|----------------------------------------------------||-------------------------------/"
}
function SplitLine {
    param([string]$left, [string]$right)
    Write-Host ("| {0,-50} ||  {1,-29} |" -f $left, $right)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# PAGE SETTINGS
$PageNumber = 7
$AllowSkip  = $false    # ✅ PAGE 07 IS NON-SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 07 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    # NO SKIP OPTION. 's' does nothing.
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { return }
    }
}

# =============================================================
# TEXT PAGE WITH CHOICES
# =============================================================
function Show-TextPage {

    # FIRST SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "`"The fog has ended, now if you would...`"" ""
    SplitLine "I see, well, he is there.`"" ""
    SplitLine "" ""
    SplitLine "He took note of the directions of the" ""
    SplitLine "shop, and after thanking Homaiz, he" ""
    SplitLine "walked out. He made slow and steady" ""
    SplitLine "strides in some direction, knowing" ""
    SplitLine "that inevitably he will find a shop" ""
    SplitLine "and then he could ask the shopkeeper" ""
    SplitLine "something, if need be. The sound of" ""
    SplitLine "rustling leaves and wind blowing made" ""
    SplitLine "way to a droning sound which was" ""
    SplitLine "difficult to describe." ""
    SplitLine "" ""
    SplitLine "He kept walking until he came across" "[1] Trusting it, taking"
    SplitLine "a Y section. Both routes did not have" "    the turning"
    SplitLine "any signposts. He heard the sound of" ""
    SplitLine "a horn from the distance, followed by" "[2] Pausing, wondering,"
    SplitLine "laughter. \"The Qin is going to put" "  then taking it anyway"
    SplitLine "those boys in a tough spot\" he thought." ""
    SplitLine "He recalled directions from his" "[3] Not to think, walk"
    SplitLine "conversation in the Niner Hotel" ""
    SplitLine "and decided..." ""
    SplitLine "" ""
    SplitBottom

    # CHOICE INPUT
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
        '1' { }   # All choices lead to the same continuation
        '2' { }
        '3' { }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            # loop back to choice section
            & $PSCommandPath
            exit
        }
    }

    # SECOND SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He decided to take the turning. He" ""
    SplitLine "walked, making a curve with the road" ""
    SplitLine "as the road curved. As he made his" ""
    SplitLine "way downwards from the road, he found" ""
    SplitLine "that the fog had become thicker. He" ""
    SplitLine "kept his pace, and continued on his" ""
    SplitLine "path. The scent of water beating with" ""
    SplitLine "wood marked the indicator he needed" ""
    SplitLine "to confirm his suspicions; he" ""
    SplitLine "continued to walk onward." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 8, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key2) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_08.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage

