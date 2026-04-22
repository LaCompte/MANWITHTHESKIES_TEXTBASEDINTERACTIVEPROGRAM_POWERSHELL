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
function BorderLine    { param([string]$t) ; Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 62
$AllowSkip  = $true   # ✅ Page 62 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 62 ---"
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
    BorderLine "He wondered if the couple was doing well as he had not seen them for"
    BorderLine "quite some time now. This thought came whilst walking down the slope and"
    BorderLine "heading back to town from the library. It also filled him with a tinge"
    BorderLine "of sadness wondering of Bardia's parents had returned to the house. It"
    BorderLine "was a relatively quiet descent, but it proved to be most effective... To"
    BorderLine "walk to Bardia's house rather than take any transport. \"A confusing,"
    BorderLine "intricate, Byzantine web of so much happening, so much being"
    BorderLine "coordinated, so many gong from point A to B... An overwhelming"
    BorderLine "arrangement\" was his response whenever the topic of busses came up."
    BorderLine ""
    BorderLine "He took the turning to the Birtash tents and stepped towards the door."
    BorderLine "He knocked on it and stepped back to let the owner open it. It was"
    BorderLine "initially quiet and there was no sound to be heard from quite a"
    BorderLine "distance. He rang the bell again, this time slightly agitated. He waited"
    BorderLine "some more and, when he did not get any response, took out a chain of"
    BorderLine "keys and used one to open the door. \"Bardia, is everything okay?\" He"
    BorderLine "asked as he entered the house. There was no answer for some time. He"
    BorderLine "decided to walk up the stairs to see if he was doing okay. He noticed"
    BorderLine "that one bedroom door was slightly open. He peaked through the door to"
    BorderLine "find Bardia asleep. He nodded and, with care and due consideration,"
    BorderLine "closed the door without making noise."
    BorderLine ""
    BorderLine "He noticed the bedroom adjacent to Bardia, in the sense that the"
    BorderLine "entrance had a clear view of Bardia's bedroom door. Going inside showed"
    BorderLine "that it was a well maintained bedroom, but not seemingly utilized in"
    BorderLine "quite some time. Some objects seemed to have been left in place exactly"
    BorderLine "as they would have been found, but all the same it was pleasant. He"
    BorderLine "decided to walk down to the lounge, sit on the sofa, and look out from"
    BorderLine "the window."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 63, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_63.ps1"; exit }
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
