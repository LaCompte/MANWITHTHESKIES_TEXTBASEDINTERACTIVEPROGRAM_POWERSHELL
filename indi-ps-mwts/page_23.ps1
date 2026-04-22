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
    param([string]$left, [string]$right)
    Write-Host ("| {0,-45} ||  {1,-29} |" -f $left, $right)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 23
$AllowSkip  = $false   # NON-SKIPPABLE — choice page

# =============================================================
# TITLE PAGE — NO SKIP
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 23 ---"
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
    SplitLine "`"So you finally met Maira?`" Punbell" ""
    SplitLine "inquired, the intent of teasing hidden" ""
    SplitLine "behind a very thick and opaque veneer" ""
    SplitLine "of indifferent tonal blankness." ""
    SplitLine "" ""
    SplitLine "He looked at Punbell and wondered" ""
    SplitLine "what he was referring to. Punbell" ""
    SplitLine "looked back at him, confused, and" ""
    SplitLine "gestured to the cause of his gaze." ""
    SplitLine "He shook his head, and continued" ""
    SplitLine "with his errands. After some time," ""
    SplitLine "he met Punbell at his desk. They" ""
    SplitLine "both had a cup of tea, making sure" ""
    SplitLine "that the papers were at a distance" ""
    SplitLine "from their official papers. He asked" ""
    SplitLine "Punbell something, to which receipt" ""
    SplitLine "of answer was acknowledged. Punbell" ""
    SplitLine "gestured to the `"Pending Tasks`" box." ""
    SplitLine "He took out one paper from it and" ""
    SplitLine "handed the document to Punbell." ""
    SplitLine "Punbell had finished his tea and," ""
    SplitLine "placing the utensils and china to a" ""
    SplitLine "side-table, proceeded with his work." ""
    SplitLine "He took out his map and noted some" ""
    SplitLine "details on it." ""
    SplitLine "" ""
    SplitLine "He tried to remember her name but" "[1] Someone familiar?"
    SplitLine "it did not seem to register." "[2] I recall someone."
    SplitLine "" "[3] There was someone."
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

    # SECOND SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He observed Punbell, and considered" ""
    SplitLine "his environment alongside. Most of" ""
    SplitLine "the study tables were unoccupied," ""
    SplitLine "and the towers - once supplied to" ""
    SplitLine "significant extents with books - now" ""
    SplitLine "seemed to have lost their charm." ""
    SplitLine "They were still towering with books," ""
    SplitLine "and still were in good conditions," ""
    SplitLine "but lacked something. He was about" ""
    SplitLine "to ask Punbell something but changed" ""
    SplitLine "his mind. Punbell was quietly reading" ""
    SplitLine "a newspaper since the pending tasks" ""
    SplitLine "of the day had been completed." ""
    SplitLine "Punbell offered tea and Yivelis." ""
    SplitLine "He declined, and with a gesture" ""
    SplitLine "left the library." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 24, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_24.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
