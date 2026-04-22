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

function SplitTop    { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom { Write-Host "|---------------------------------------------||--------------------------------/" }
function SplitLine {
    param([string]$l, [string]$r)
    Write-Host ("| {0,-43} ||  {1,-29} |" -f $l, $r)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 25
$AllowSkip  = $false   # NON-SKIPPABLE — choice page

# =============================================================
# TITLE PAGE — NO SKIP
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 25 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { return }
    }
}

# =============================================================
# TEXT PAGE — CHOICE PAGE
# =============================================================
function Show-TextPage {

    # FIRST SPLIT BLOCK
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "`"Don't worry, I won't run you over.`"" ""
    SplitLine "Maira giggled, and offered her hand" ""
    SplitLine "again. He nodded, shook hands and" ""
    SplitLine "gave a cursory smile. He kept quiet" ""
    SplitLine "and gestured towards the waves." ""
    SplitLine "Maira nodded, tipped her hat, and" ""
    SplitLine "she walked along in her own path." ""
    SplitLine "" ""
    SplitLine "He stood at the water, and wondered" ""
    SplitLine "about the nature of the water. He" ""
    SplitLine "wondered where did all this water" ""
    SplitLine "actually come from. He wondered" ""
    SplitLine "where did it cease to be. For as" ""
    SplitLine "long as he could remember, the beach" ""
    SplitLine "had always been there. The water had" ""
    SplitLine "always been there. There were complete" ""
    SplitLine "celebrations on this very beach which" ""
    SplitLine "he had heard about when he was young." ""
    SplitLine "Although they never included what" "[1] Walk with the water"
    SplitLine "actually `"happened`" in these beaches." "[2] ... could I walk?"
    SplitLine "" "[3] ... would I walk?"
    SplitLine "" ""
    SplitBottom

    # CHOICE HANDLING
    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($choice) {
        '1' { }
        '2' { }
        '3' { }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath
            exit
        }
    }

    # SECOND SPLIT BLOCK
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He noticed that Maira was sitting" ""
    SplitLine "near the sand that was dry and was" ""
    SplitLine "observing the water while reading" ""
    SplitLine "a book. He turned around, and walked" ""
    SplitLine "towards a shower stand. He washed" ""
    SplitLine "his feet meticulously, as well as" ""
    SplitLine "the sand which was stuck on his" ""
    SplitLine "knees. He remembered the warning in" ""
    SplitLine "the Niner. He turned to find a" ""
    SplitLine "symbolic counter to it; a series of" ""
    SplitLine "instructions which explained, step" ""
    SplitLine "by step, on how to clean up one's" ""
    SplitLine "feet and skin after coming back" ""
    SplitLine "from the beach. He took one of the" ""
    SplitLine "towels from the rack, sat down, and" ""
    SplitLine "dried his feet and knees." ""
    SplitLine "" ""
    SplitLine "He walked back on the road leading" ""
    SplitLine "to the library and headed down from" ""
    SplitLine "the road, where the fog became" ""
    SplitLine "thicker and caused visibility to be" ""
    SplitLine "limited. He thought of something" ""
    SplitLine "and whilst whistling he noted it" ""
    SplitLine "in his notepad." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 26, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_26.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
