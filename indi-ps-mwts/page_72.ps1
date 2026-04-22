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
function BorderLine    { param([string]$t); Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 72
$AllowSkip  = $true   # ✅ Page 72 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 72 ---"
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
    BorderLine "Elias was putting some pots and crockery into a box when he entered the"
    BorderLine "shop. \"Fancy seeing you again\" he said to a plate, which he cleared and"
    BorderLine "then put into the box. Elias picked up the box and took it with him to"
    BorderLine "the back of the store. He went to the counter, and heard Elias running a"
    BorderLine "conversation with someone. It was not very audible, and it seemed of"
    BorderLine "little consequence. Bardia looked through the window and wondered at"
    BorderLine "what was being discussed."
    BorderLine ""
    BorderLine "Elias stepped out of his room and towards the counter. \"Just got a new"
    BorderLine "shipment of tea and a few other items. Interested?\" Elias asked him. He"
    BorderLine "wondered at what these items might be and then turned around, looked at"
    BorderLine "the window, and waved Bardia to enter the shop. When Bardia entered,"
    BorderLine "Elias walked towards him and offered his hand."
    BorderLine ""
    BorderLine "\"Hello there, young man. Pleasant surprise.\""
    BorderLine ""
    BorderLine "Bardia shook his hand and smiled, although his gaze was clearly"
    BorderLine "distracted by something in the shop. Elias looked in the direction in"
    BorderLine "which Bardia was looking. He picked up a stick which had a hook grafted"
    BorderLine "on to the end. He took out some of the objects from the shelves and"
    BorderLine "after some time, whether Bardia mentioned it or whether he mentioned to"
    BorderLine "Elias what Bardia liked about the object, Elias would turn the object to"
    BorderLine "its rightful place."
    BorderLine ""
    BorderLine "\"Yes, quite a collection, but still quite a long way to go before I can"
    BorderLine "call it a complete collection\""
    BorderLine ""
    BorderLine "Elias sighed, and shook his head."
    BorderLine ""
    BorderLine "\"There is... are... so many places to go, before I can be fully"
    BorderLine "conclusive with what I have. I do wonder though...\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 73, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_73.ps1"; exit }
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
