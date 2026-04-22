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
    param([string]$text)
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $text
}

function TypeWriterSlow {
    param([string]$text, [double]$delay = 1.5)   # ✅ Page 29 uses VERY slow speed
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
    Start-Sleep 2
    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
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
# PAGE SETTINGS
# =============================================================
$PageNumber = 29
$AllowSkip  = $false   # ✅ Page 29 is NON-SKIPPABLE (your rule)

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 29 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $header 1.5   # ✅ EXACT SPEED preserved
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
        'm' { & "$ProjectRoot/main_menu.ps1" ; exit }
        'q' { exit }
        default { return }
    }
}

# =============================================================
# TEXT PAGE (LINEAR PAGE)
# =============================================================
function Show-TextPage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    BorderTop
    BorderLine "\"I don't like seeing dragonflies. Or insects"
    BorderLine ""
    BorderLine "What if I get lost? If somebody takes me"
    BorderLine ""
    BorderLine "What if I lose my parents."
    BorderLine ""
    BorderLine "They like it, but I don't. I don't want to go!\""
    BorderLine ""
    BorderLine "PLEASE... Don't make me go. Mom said I can stay in the house as long as"
    BorderLine "I have supervision."
    BorderLine ""
    BorderLine "Please don't make me go..."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 30, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1" ; exit }
        'q' { exit }
        default { & "$ScriptDir/page_30.ps1" ; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
