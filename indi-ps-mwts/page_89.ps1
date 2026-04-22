#!/usr/bin/env pwsh

# =============================================================
# COLORS & BACKGROUND
# =============================================================
$BLACK  = "`e[38;2;0;0;0m"
$BLUE   = "`e[38;2;0;200;255m"
$RESET  = "`e[0m"
$CREAM  = "`e[48;2;255;253;208m`e[38;2;0;0;0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width
    for ($i = 0; $i -lt $rows; $i++) {
        Write-Host ($CREAM + (' ' * $cols) + $RESET)
    }
    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$t)
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $t
}

function TypeWriterSlow {
    param([string]$t, [double]$delay = 0.5)
    foreach ($c in $t.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

function TypeWriter {
    param([string]$t, [double]$delay = 0.02)
    foreach ($c in $t.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

function FadeIn {
    param([string]$t, [string]$color)
    Write-Host "`e[2m$color$t$RESET"
    Start-Sleep 2
    Write-Host "`e[H"
    Write-Host "$color$t$RESET"
    Start-Sleep 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$t$RESET"
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
# CONFIG
# =============================================================
$PageNumber = 89
$AllowSkip  = $true   # ✅ Page 89 IS skippable

# =============================================================
# TITLE PAGE (SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 89 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.5
    Write-Host $RESET

    FadeIn (Center "______________________") $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        's' { if ($AllowSkip) { return "skip" } }
        default { return }
    }
}

# =============================================================
# TEXT PAGE
# =============================================================
function Show-TextPage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    BorderTop
    BorderLine "He had already packed everything and placed them inside of the vehicle."
    BorderLine "The trunk had been assorted. As Bardia sat in the car, he hit the gas"
    BorderLine "after ensuring that the gear was set to reverse. It was on a moment"
    BorderLine "notice that was running on the radio as the car made the curve. It was a"
    BorderLine "cloudy day and the car was clearly howling a lot of love. It was in"
    BorderLine "nearly mint condition. Bardia whistled to the tune of the song running"
    BorderLine "on the radio, as he took the right from the downhill drive to the main"
    BorderLine "thoroughfare intending to go somewhere."
    BorderLine ""
    BorderLine "\"The coast seems to be clear\" he thought as he turned through the"
    BorderLine "Birtash avenue onto the part of \"Justin's Intersection\". On the way, he"
    BorderLine "saw a park. Taking a turn, he went to the parking lot and made his way"
    BorderLine "to the nearest open source. \"Nothing better than right in front of the"
    BorderLine "entrance.\" He exclaimed, smiling, as he made his way to the park itself."
    BorderLine ""
    BorderLine "He walked around the place, with the sound of birds, leaves rustling and"
    BorderLine "cheer coming from people marking the presence of people who were coming"
    BorderLine "and going. Most of them seemed to be there with someone as if they were"
    BorderLine "alone, they were making do with movement around the park, with an"
    BorderLine "aimless movement. \"Apparently such movement is healthy for the body. I"
    BorderLine "fail to see how\" he thought as he tried finding a place to sit down."
    BorderLine "According to the signs, there was a sitting place a while away from him,"
    BorderLine "and if he took some time to breathe, he might miss it. The approaching"
    BorderLine "hedge seemed to indicate the presence of a bench."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 90, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_90.ps1"; exit }
    }
}

# =============================================================
# MAIN
# =============================================================
$result = Show-TitlePage
if ($result -ne "skip") {
    Start-Sleep -Milliseconds 300
}
Show-TextPage
