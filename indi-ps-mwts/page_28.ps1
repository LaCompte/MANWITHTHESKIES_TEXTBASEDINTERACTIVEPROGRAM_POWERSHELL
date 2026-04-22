#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK = "`e[38;2;0;0;0m"
$BLUE  = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

function FillCreamBackground {
    $rows  = $Host.UI.RawUI.WindowSize.Height
    $cols  = $Host.UI.RawUI.WindowSize.Width
    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"
    for ($i=0; $i -lt $rows; $i++) {
        Write-Host ($cream + (' ' * $cols) + $RESET)
    }
    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param ([string]$text)
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $text
}

function TypeWriterSlow {
    param([string]$text, [double]$delay = 1.0)   # ✅ Page 28 uses 1-second typewriter
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
    param ([string]$text, [string]$color)
    Write-Host "`e[2m$color$text$RESET"
    Start-Sleep 2
    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

# SPLIT PAGE BORDERS
function SplitTop     { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom  { Write-Host "|---------------------------------------------||--------------------------------/" }
function SplitLine {
    param([string]$left, [string]$right)
    Write-Host ("| {0,-43} ||  {1,-29} |" -f $left, $right)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE SETTINGS
# =============================================================
$PageNumber = 28
$AllowSkip  = $false   # ✅ NON‑SKIPPABLE CHOICE PAGE

# =============================================================
# TITLE PAGE (NO SKIP OPTION)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 28 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 1.0     # ✅ EXACT 1-second delay
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    # No skip allowed
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

    #
    # FIRST SPLIT SECTION
    #
    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He made a fist, with the middle and" ""
    SplitLine "third finger slightly outstretched" ""
    SplitLine "from the rest of the fingers. He" ""
    SplitLine "then knocked on the door. He could" ""
    SplitLine "hear the sound of something happening" ""
    SplitLine "inside the house. It eventually led" ""
    SplitLine "to the distinct tapping which" ""
    SplitLine "footsteps make on a wooden paneled" ""
    SplitLine "floor. The door opened, and a small" ""
    SplitLine "little head poked out from inside" ""
    SplitLine "the house. He smiled at the boy," ""
    SplitLine "cleared his throat, and said to him" ""
    SplitLine "`\"Hello there, young man. Hope you`\"" ""
    SplitLine "would spare me a moment of your" ""
    SplitLine "time?\" The child looked at him" ""
    SplitLine "straight in the eyes and, after" ""
    SplitLine "pondering on it for a brief moment," ""
    SplitLine "he opened the door and let him in." ""
    SplitLine "It was a modest inner space. The" ""
    SplitLine "child went in the direction of the" ""
    SplitLine "lounge, where he sat on a sofa and" ""
    SplitLine "looked in the direction of the" ""
    SplitLine "garden. The child was asked his" ""
    SplitLine "name. \"Bardia\" the child answered." ""
    SplitLine "\"So, Bardia, what are you busy with\"" ""
    SplitLine "he asked. Bardia pointed at the" ""
    SplitLine "garden. He nodded at Bardia's answer," ""
    SplitLine "and quietly looked at the garden" ""
    SplitLine "with Bardia." ""
    SplitLine "" ""
    SplitLine "He thought about something whilst" ""
    SplitLine "Bardia did the same. He noted that" ""
    SplitLine "the sound of music and chants again" ""
    SplitLine "restarted, which he felt was nearby." ""
    SplitLine "He looked at the boy again, and" ""
    SplitLine "cleared his throat once more. He" ""
    SplitLine "asked: \"So, Bardia, well... The" ""
    SplitLine "Birtash is going to pass by your" ""
    SplitLine "house soon. Would you like to come" ""
    SplitLine "with us to...\" Bardia shook his head" "[1] Give him the paper."
    SplitLine "with his eyes closed." "[2] Don't think. Paper."
    SplitLine "" "[3] The paper. Now."
    SplitLine "" ""
    SplitBottom

    #
    # CHOICE INPUT
    #
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

    #
    # SECOND SPLIT SECTION
    #
    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He nodded, and took out a piece of" ""
    SplitLine "paper from his notepad. \"Maybe you" ""
    SplitLine "would feel comfortable writing why" ""
    SplitLine "you don't want to go.\" He said," ""
    SplitLine "handing the paper and a pencil to" ""
    SplitLine "Bardia. Bardia answered on it and" ""
    SplitLine "returned it to him. He looked at" ""
    SplitLine "the answer." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 29, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_29.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
