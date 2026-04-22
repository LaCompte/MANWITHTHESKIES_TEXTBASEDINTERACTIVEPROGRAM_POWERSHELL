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
# HELPERS
# =============================================================
function Center {
    param([string]$text)
    $cols = $Host.UI.RawUI.WindowSize.Width
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

function TypeWriterSlow {
    param([string]$text, [double]$delay = 0.4)   # ✅ Page 17 uses 0.4s delay

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

# SPLIT BORDERS
function SplitTop     { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom  { Write-Host "|---------------------------------------------||--------------------------------/" }
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
# PAGE SETTINGS
# =============================================================
$PageNumber = 17
$AllowSkip  = $false        # ✅ Page 17 = NON‑SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 17 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.4    # ✅ EXACT TIMING PRESERVED
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    # NO SKIP OPTION
    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k) {
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
    SplitLine "He waited for the arrival of Laraiez." ""
    SplitLine "After a certain time had passed, he" ""
    SplitLine "got up and walked out of the office." ""
    SplitLine "He walked straight, and in the middle" ""
    SplitLine "of the hall, he turned right. He" ""
    SplitLine "walked down the hall to the open" ""
    SplitLine "doors, where he looked out into a" ""
    SplitLine "school playground. Unlike the one he" ""
    SplitLine "had passed through when entering the" ""
    SplitLine "school, this one had a number of" ""
    SplitLine "gardens broken by numerous pathways." ""
    SplitLine "These pathways were composed of" ""
    SplitLine "granite slabs, of square shape," ""
    SplitLine "placed in a manner that all the" ""
    SplitLine "patches of grass looked like the" ""
    SplitLine "same area, shape, and consistency." ""
    SplitLine "There were portions in which seating" ""
    SplitLine "areas had been marked: benches with" ""
    SplitLine "a canopy to provide shade. He always" ""
    SplitLine "wondered whether the fees rising in" ""
    SplitLine "their school had to do with" ""
    SplitLine "maintaining this part of the school," ""
    SplitLine "or if there had actually been a" ""
    SplitLine "series of unfortunate events which" ""
    SplitLine "led to this happening." ""
    SplitLine "" ""
    SplitLine "He turned around and went back to" ""
    SplitLine "the entrance of the school, and" ""
    SplitLine "turned towards the playground. He" ""
    SplitLine "took a stroll around it, noting that" ""
    SplitLine "it was not yet free-time to play" ""
    SplitLine "with all the toys in the playground." ""
    SplitLine "Some of the swings looked like they" ""
    SplitLine "had been used often, to which he saw" ""
    SplitLine "some scribbles on the base. He kept" ""
    SplitLine "strolling around, accompanied by" ""
    SplitLine "distant sounds of words which were" ""
    SplitLine "being spoken but could not be heard" ""
    SplitLine "clearly. Amidst this sound was also" "[1] What is that sound?"
    SplitLine "the creaking of metal, which he" "    I know it somehow."
    SplitLine "could see the source of, but not" "[2] A familiar sound,"
    SplitLine "clearly." "    somehow."
    SplitLine "" "[3] I have heard that"
    SplitLine "" "    sound somehow."
    SplitLine "" ""
    SplitBottom

    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($choice) {
        '1' { }
        '2' { }
        '3' { }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath    # ✅ Loop back on invalid input
            exit
        }
    }

    # SECOND SPLIT BLOCK
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He took out his notepad, and looked" ""
    SplitLine "at some of his scribbles. He put the" ""
    SplitLine "notepad back, and felt his pockets." ""
    SplitLine "He made his way out of the school," ""
    SplitLine "nodding." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 18, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_18.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
