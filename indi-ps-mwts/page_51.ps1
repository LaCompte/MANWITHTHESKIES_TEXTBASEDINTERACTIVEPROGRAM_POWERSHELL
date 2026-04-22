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
    for ($i=0; $i -lt $rows; $i++){
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
    foreach($c in $t.ToCharArray()){
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
function BorderLine    { param([string]$t) ; Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 51
$AllowSkip  = $true   # ✅ Page 51 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 51 ---"
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
    switch($k){
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
    BorderLine "He looked at Bardia and raised an eyebrow. More an attempt at raising an"
    BorderLine "eyebrow than fully raising an eyebrow. He wondered and asked Bardia \"If"
    BorderLine "I asked you to describe a stork for me, would you be able to do so?\" To"
    BorderLine "which Bardia thought about it and then with a nod, stood up and used"
    BorderLine "gestures to describe something."
    BorderLine ""
    BorderLine "He occasionally interrupted Bardia to take more clarity about the"
    BorderLine "description, but mostly he kept quiet and listened to what Bardia had to"
    BorderLine "say. It was less said and more of actions being performed to emphasize"
    BorderLine "the dimensions, look and the sheer presence of what constituted, in"
    BorderLine "Bardia's mind, a stork. He nodded at the conclusion of Bardia's"
    BorderLine "description of a stork, and did not ask further questions. They both"
    BorderLine "wondered off in their minds, to which Bardia was asked: \"Shouldn't you"
    BorderLine "be heading home by now? It is getting quite late.\" Bardia wondered at"
    BorderLine "this point and pointed to the sky. He saw plenty of fog, yet it did not"
    BorderLine "seem to indicate that the day was still ongoing. He got up and walked"
    BorderLine "over to the stairs, with Bardia in arm's reach. They made their way"
    BorderLine "towards the road, from where they traveled for some time and finally"
    BorderLine "reached the house in the middle of the street."
    BorderLine ""
    BorderLine "Once he had dropped Bardia back to the house, he made his way to the"
    BorderLine "road. Instead of heading in the direction of the Birtash, he decided to"
    BorderLine "head back towards the shops. So he walked through a series of"
    BorderLine "thoroughfares and opened the door to Elias' shop."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 52, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch($next){
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_52.ps1"; exit }
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
