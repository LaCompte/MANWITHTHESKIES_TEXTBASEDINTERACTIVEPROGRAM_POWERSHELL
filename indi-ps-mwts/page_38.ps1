#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK  = "`e[38;2;0;0;0m"
$BLUE   = "`e[38;2;0;200;255m"
$RESET  = "`e[0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width
    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"
    for ($i=0; $i -lt $rows; $i++){
        Write-Host ($cream + (' ' * $cols) + $RESET)
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
    return (' ' * $pad) + $text
}

function TypeWriterSlow {
    param([string]$text, [double]$delay = 0.06)   # ✅ Page 38 slow title typing
    foreach ($ch in $text.ToCharArray()){
        Write-Host -NoNewline $ch
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)
    foreach ($ch in $text.ToCharArray()){
        Write-Host -NoNewline $ch
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

function FadeIn {
    param([string]$text, [string]$color)
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
# CONFIG
# =============================================================
$PageNumber = 38
$AllowSkip  = $false   # ✅ NON-SKIPPABLE PAGE

# =============================================================
# TITLE PAGE (NO SKIP OPTION)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 38 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $header 0.06   # ✅ EXACT speed from Bash
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    # NO SKIP ALLOWED
    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch($k){
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
    # FIRST SPLIT BLOCK
    #
    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "`\"He's fine at home.`\"" ""
    SplitLine "" ""
    SplitLine "`\"What are his pastimes and hobbies" ""
    SplitLine "at home?\" Laraiez inquired." ""
    SplitLine "" ""
    SplitLine "`\"He finished his homework, and sits" ""
    SplitLine "in the garden.`\"" ""
    SplitLine "" ""
    SplitLine "`\"What about writing? Does he do any" ""
    SplitLine "writing at home?`\"" ""
    SplitLine "" ""
    SplitLine "`\"None apart from what is necessary." ""
    SplitLine "He does spend time talking though.`\"" ""
    SplitLine "" ""
    SplitLine "`\"With whom?\" Laraiez asked." "[1] With me."
    SplitLine "" "[2] With me."
    SplitLine "" "[3] With me."
    SplitLine "" ""
    SplitBottom

    #
    # CHOICE HANDLING (INVALID LOOPS)
    #
    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch($choice){
        '1' { }
        '2' { }
        '3' { }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath   # loop same page
            exit
        }
    }

    #
    # SECOND SPLIT BLOCK
    #
    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "Laraiez nodded at the answer." ""
    SplitLine "Laraiez looked at Bardia and" ""
    SplitLine "answered Bardia's confused, mildly" ""
    SplitLine "nervous look with \"Don't worry about" ""
    SplitLine "a thing. You just do your best, and" ""
    SplitLine "smile more often.\" Bardia left the" ""
    SplitLine "room with him, and both of them" ""
    SplitLine "greeted Laraiez as they reached the" ""
    SplitLine "door and exited the school." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 39, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch($next){
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_39.ps1"; exit }
    }
}

# =============================================================
# MAIN
# =============================================================
Show-TitlePage
Show-TextPage
