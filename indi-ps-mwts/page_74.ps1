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
$PageNumber = 74
$AllowSkip  = $true   # ✅ Page 74 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 74 ---"
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
    BorderLine "Whilst he was busy listening to Elias, Bardia checked the doll"
    BorderLine "collection which Elias had started some time ago. There were various"
    BorderLine "ones here and there. One which stood out was the stork. Bardia kept"
    BorderLine "looking at it, but not touching it. He saw Bardia and kept Elias busy"
    BorderLine "whilst Bardia was doing so. Elias kept a conversation to an extent where"
    BorderLine "he wound up looking at Bardia, and with a calm, gentle yet sincere tone,"
    BorderLine "he asked:"
    BorderLine ""
    BorderLine "\"What are you really interested in? You've been looking at that stork"
    BorderLine "quite intently for quite some time. It isn't Dave, if that's enough to"
    BorderLine "answer your question.\""
    BorderLine ""
    BorderLine "Bardia wound up turning to Elias and taken aback, looked at Elias very"
    BorderLine "awkwardly. He looked at Bardia and then at Elias, and with an equally"
    BorderLine "indifferent tone, asked: \"is it natural for water to boil for so long?\""
    BorderLine "to which Elias, turning and noticing the water, pointed his pipe at him,"
    BorderLine "nodded his head as if to acknowledge the subtlety of the statement, and"
    BorderLine "removed the kettle. Elias poured the tea in all three cups, and beckoned"
    BorderLine "all three to have the brew. Bardia was reluctant, still even confused."
    BorderLine "Bardia was looking at the stork and drifting gazes between the doll, the"
    BorderLine "stork, and Elias."
    BorderLine ""
    BorderLine "Elias, taking a sip from the tea, remarked: \"You have never been to the"
    BorderLine "Birtash.\" And then turning to him Elias asked \"or has he?\" whilst"
    BorderLine "tilting his head towards Bardia. He looked at Bardia, and then told"
    BorderLine "Elias \"He has a big collection of books on birds. Has a lovely view of"
    BorderLine "them from his house as well.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 75, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_75.ps1"; exit }
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
