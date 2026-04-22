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
    $pad  = [Math]::Max(0, [Math]::Floor(($cols - $t.Length) / 2))
    return (' ' * $pad) + $t
}

function TypeWriterSlow {
    param([string]$t, [double]$delay = 0.6)
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
$PageNumber = 84
$AllowSkip  = $true   # ✅ Page 84 IS skippable

# =============================================================
# TITLE PAGE (SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 84 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.6
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
    BorderLine "Bardia acknowledged his father's request with a tinge of regret and an"
    BorderLine "abundance of calm composure. He stoked up on his feed, walked to his"
    BorderLine "father, and requested if he may kiss him on the forehead. He was granted"
    BorderLine "this permission, and completed the task with a modicum of grace and"
    BorderLine "humility."
    BorderLine ""
    BorderLine "Bardia and he walked out of the hospital. And he took his leave, walking"
    BorderLine "to the main thoroughfare on the corner of Colonial Point, and turned to"
    BorderLine "the avenue following the redwood. He looked around to his amusement at"
    BorderLine "the number of tourists who had busied themselves in the vicinity. \"If"
    BorderLine "they are indeed somewhat enthusiastic about this region, they would make"
    BorderLine "a pretty penny for the Hillview Hotel\" he thought to himself as he made"
    BorderLine "his way past the avenue. \"Something my father once told me about mother,"
    BorderLine "perhaps I could let her know.\" He thought wondering at the envelope in"
    BorderLine "his pocket. He had taken it out and read it in Tabitha's Flower Shop."
    BorderLine ""
    BorderLine "\"An excellent choice; young and eternal, forever blessed in the paradise"
    BorderLine "we could only dream of... surely to pay for complimentary flowers is"
    BorderLine "foolish... yes, indeed, you are quite right; she would be most proud..."
    BorderLine "do visit again whenever you pass by\" he heard, to which he looked at"
    BorderLine "Tabatha, smiled, nodded his head, and bid farewell. As he walked past"
    BorderLine "the avenue, and turned right, and took some twists and turns, he found"
    BorderLine "himself facing those words. He responded with his offering, and a moment"
    BorderLine "of contemplation."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 85, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_85.ps1"; exit }
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
