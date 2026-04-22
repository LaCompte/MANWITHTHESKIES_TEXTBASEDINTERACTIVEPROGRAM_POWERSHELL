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
    param($L, $R)
    Write-Host ("| {0,-43} ||  {1,-29} |" -f $L, $R)
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
$PageNumber = 45
$AllowSkip  = $false   # NON-SKIPPABLE — choice page

# =============================================================
# TITLE PAGE — NO SKIP
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 45 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
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

    # FIRST SPLIT SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He continued to introspect on the" ""
    SplitLine "thought, and found himself lost in" ""
    SplitLine "a forest. He looked around, and" ""
    SplitLine "noticed a light shining from a" ""
    SplitLine "distance. He decided to walk towards" ""
    SplitLine "it. It wasn't that the forest lacked" ""
    SplitLine "any other light-source. It wasn't" ""
    SplitLine "even the case that the light was of" ""
    SplitLine "any unique color. He walked onward" ""
    SplitLine "towards it, noticing that the terrain" ""
    SplitLine "changed from thick, yet comforting," ""
    SplitLine "trees; to a lush, widespread, radiant" ""
    SplitLine "vista - only the miles upon miles of" ""
    SplitLine "grassland covering the Earth. Yet" ""
    SplitLine "the light still shone, completely" ""
    SplitLine "indifferent to the sight. So he" ""
    SplitLine "decided to keep walking forwards," ""
    SplitLine "that he may be near this source of" ""
    SplitLine "luminescence." ""
    SplitLine "" ""
    SplitLine "As he walked forwards, and forwards," ""
    SplitLine "something caught his eye. He kept" ""
    SplitLine "looking, he kept hearing, but then" ""
    SplitLine "he shrugged. `"It was probably nothing" ""
    SplitLine "significant`" he thought to himself," ""
    SplitLine "and he saw a granite path, which he" ""
    SplitLine "took. He was walking alongside a" ""
    SplitLine "cliff, a reflection of light from" ""
    SplitLine "the moon shone over the water. That" ""
    SplitLine "was what he thought was the sighting," ""
    SplitLine "yet it did not seem to be the case." ""
    SplitLine "The cliff became smooth, and the" "[1] I am not ready yet."
    SplitLine "sound of the waves became calmer." "[2] Not yet. Go deeper."
    SplitLine "It seemed to be less inclined" "[3] Not yet. Go higher."
    SplitLine "upwards too... As if the walk was" ""
    SplitLine "more horizontal." ""
    SplitLine "" ""
    SplitBottom

    # CHOICE HANDLING
    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($choice) {
        '1' {}
        '2' {}
        '3' {}
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath
            exit
        }
    }

    # SECOND SPLIT SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He noticed that Bardia was sitting" ""
    SplitLine "on the sand, looking at the water." ""
    SplitLine "`"A pleasant, calming experience," ""
    SplitLine "wouldn't you agree?`" He inquired," ""
    SplitLine "noticing that Bardia had not" ""
    SplitLine "responded back. Bardia merely nodded" ""
    SplitLine "at some thought. He looked at the" ""
    SplitLine "water, got up, and asked Bardia" ""
    SplitLine "`"Would you like to feel the water" ""
    SplitLine "on your feet?`" to which Bardia" ""
    SplitLine "looked at the waves, then pointed" ""
    SplitLine "at his wet feet. He nodded at" ""
    SplitLine "whatever thought came into his mind." ""
    SplitLine "Bardia looked at him, and wondered" ""
    SplitLine "at the thought he was having. Bardia" ""
    SplitLine "decided to instead look at the waves" ""
    SplitLine "and feel the wind pouring from the" ""
    SplitLine "overcast skies softly caressing" ""
    SplitLine "his face." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 46, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_46.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
