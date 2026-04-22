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
$PageNumber = 91
$AllowSkip  = $true   # ✅ Page 91 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 91 ---"
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
    BorderLine "It seemed that the people were gathered around for a performance by"
    BorderLine "someone, or perhaps by a major act, as they were moving to a rightwards"
    BorderLine "direction, with the accompaniment of pronounced, definable breathing in"
    BorderLine "a harmonic rhythmic and musical tone. The old couple and their son"
    BorderLine "seemed to be indifferent to these sounds, although the younger child was"
    BorderLine "much more intrigued by these sounds. Bardia noticed the chiding and the"
    BorderLine "constant push towards going where the sound was coming from, anyone who"
    BorderLine "would preferably give a response at least."
    BorderLine ""
    BorderLine "The sound caught Bardia's ear because it was, at least lyrically, very"
    BorderLine "familiar to something he knew. Something he had written perhaps, a very"
    BorderLine "long time ago. Bardia looked through his pockets and found a paper on"
    BorderLine "which the piece was transcribed and spoken all that time back."
    BorderLine ""
    BorderLine "I had once walked through the breeze of"
    BorderLine ""
    BorderLine "An unkempt, forlorn dream; where I"
    BorderLine ""
    BorderLine "Had stopped to wake up, I know not. The puff"
    BorderLine ""
    BorderLine "Of a thought disappearing before my eye"
    BorderLine ""
    BorderLine "Money marked that abrupt transition."
    BorderLine ""
    BorderLine "We have seen beyond the clouds, I know"
    BorderLine ""
    BorderLine "Far more than what we speak in vision"
    BorderLine ""
    BorderLine "Abolution in that which is beyond, which grows"
    BorderLine ""
    BorderLine "Like a tree granting eternal life, yet not"
    BorderLine ""
    BorderLine "To those who seek adventures,"
    BorderLine ""
    BorderLine "But I have no place from that tree, only to rot"
    BorderLine ""
    BorderLine "As those who were led only by their futile rapture:"
    BorderLine ""
    BorderLine "The Doors beyond are a gathering, to us seeking"
    BorderLine ""
    BorderLine "A purpose to our lives, strength in meaning\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 92, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_92.ps1"; exit }
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
