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
    param([string]$text, [double]$delay = 0.5)
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

function SplitTop    { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom { Write-Host "|---------------------------------------------||--------------------------------/" }
function SplitLine {
    param([string]$L, [string]$R)
    Write-Host ("| {0,-43} ||  {1,-29} |" -f $L, $R)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 30
$AllowSkip  = $false   # NON-SKIPPABLE — choice page

# =============================================================
# TITLE PAGE — NO SKIP
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 30 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $header 0.5
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
    SplitLine "The child keeping his gaze on the" ""
    SplitLine "garden, was being considered in the" ""
    SplitLine "context of the note. `"Well, is there" ""
    SplitLine "any place you would like to go?`"" ""
    SplitLine "He asked Bardia. Bardia thought and" ""
    SplitLine "simply shrugged his shoulders. He" ""
    SplitLine "looked at Bardia and got up. `"I'll" ""
    SplitLine "be going now. If you need anything" ""
    SplitLine "let me know.`" He told Bardia, and" ""
    SplitLine "offered his hand. Bardia got up," ""
    SplitLine "and walked with him to the door." ""
    SplitLine "" ""
    SplitLine "Bardia stopped midway, and held his" "[1] Give him something."
    SplitLine "stomach. When he came close to" "[2] He's hungry. Do it."
    SplitLine "Bardia, he heard the sound of a" "[3] You feel it. Do it."
    SplitLine "missing ingredient." ""
    SplitLine "" ""
    SplitBottom

    # CHOICE INPUT
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

    # SECOND SPLIT SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "So he took Bardia to the kitchen," ""
    SplitLine "took out something from the fridge," ""
    SplitLine "put it in a bowl, and offered it" ""
    SplitLine "to Bardia. Bardia was suspicious at" ""
    SplitLine "first, and looked at him with a look" ""
    SplitLine "that was part apprehension and part" ""
    SplitLine "confusion. He looked at Bardia, and" ""
    SplitLine "responded in a calm, but mildly" ""
    SplitLine "involved voice, with `"I had assumed" ""
    SplitLine "you were hungry. I also assumed that" ""
    SplitLine "you would like to eat a very sweet" ""
    SplitLine "food. So I put the sweetest thing" ""
    SplitLine "in the fridge on to the table`"." ""
    SplitLine "Bardia nodded at the answer and" ""
    SplitLine "with some courage, took a bit from" ""
    SplitLine "the food. After some time, Bardia" ""
    SplitLine "took another bite. He stopped" ""
    SplitLine "counting how many bites Bardia took," ""
    SplitLine "after he had noticed the bowl had" ""
    SplitLine "been emptied." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 31, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_31.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
