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
$PageNumber = 76
$AllowSkip  = $true   # ✅ Page 76 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 76 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
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
    BorderLine "Elias considered the question, sipping his tea in silence. Elias took"
    BorderLine "the cups and placed them inside his office, humming to himself as he did"
    BorderLine "so. Bardia looked at Elias with a puzzled expression., although it was"
    BorderLine "not out of disregard to the question asked. Elias came back, still"
    BorderLine "pondering on the question, and sat in a chair, facing Bardia and him."
    BorderLine "Elias answered in a modicum of finality and said: \"You probably might"
    BorderLine "not know this, but the school was built around the same time the"
    BorderLine "celebration of Samson's Circle had taken place. Why not start from"
    BorderLine "there? See what the Qin has to say?\""
    BorderLine ""
    BorderLine "He turned from Elias to Bardia, and then asked Bardia: \"You want to head"
    BorderLine "to school later when there is a day off?\" Bardia thought about it,"
    BorderLine "albeit in a more excited tone than a serious one. And answered with an"
    BorderLine "excited nod, a smile, and a handshake between Elias and his self. They"
    BorderLine "looked at Elias and appreciated his wares, and both Bardia and he left"
    BorderLine "the shop with Elias smiling behind them, from the counter. He noticed a"
    BorderLine "customer entering Tabitha's shop. The person was a lady, although it"
    BorderLine "seemed that a gentleman accompanied her as she seemed to enter in a sort"
    BorderLine "of forceful way, rather than in a composed and curious manner - the way"
    BorderLine "customers enter a shop."
    BorderLine ""
    BorderLine "Bardia and he looked around the shops, after which point he asked Bardia"
    BorderLine "about a painting. Bardia, excited, raised many questions on the matter:"
    BorderLine "they both looked at the painting, with Bardia being awestruck by it."
    BorderLine "There seemed to be a lot of awe over the contents of the painting. \"It"
    BorderLine "is for the best\" he thought, looking at how happy Bardia was. \"We"
    BorderLine "already have the paintings reprint. I'll show you later\" he informed"
    BorderLine "Bardia."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 77, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_77.ps1"; exit }
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
