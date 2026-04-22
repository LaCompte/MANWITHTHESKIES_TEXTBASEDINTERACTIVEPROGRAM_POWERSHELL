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

function BorderTop     { Write-Host "|------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|------------------------------------------------------------------------/" }
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
$PageNumber = 78
$AllowSkip  = $false   # ✅ NON‑SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 78 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
    Write-Host $RESET

    FadeIn (Center "______________________") $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { return }
    }
}

# =============================================================
# TEXT PAGE — CHOICE PAGE
# =============================================================
function Show-TextPage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    BorderTop
    BorderLine "He looked at Bardia and acknowledged the request. After finishing"
    BorderLine "the last one, they headed to the road. The fog was less prominent"
    BorderLine "in the way."
    BorderLine ""
    BorderLine "\"It is when we are distracted that the mysteries of life take"
    BorderLine "hold, and simply refuse to let go\" he found himself considering"
    BorderLine "this quote, which began the preface of the book he was reading."
    BorderLine "It looked around, expecting Punbell to arrive, what with the"
    BorderLine "noise of footsteps. \"Footsteps do not make noise, they make"
    BorderLine "sound. Even if it is a library, the matter is pertinent\" he"
    BorderLine "would chide to no one but himself, or so was written in the"
    BorderLine "book, and the grating sound of the wheels of a ladder, left"
    BorderLine "unhinged, slightly marking the transition of one hour to the"
    BorderLine "next. And at the clock's strike, it marked a moment... which"
    BorderLine "seemed to be momentarily mundane and only mattered to those"
    BorderLine "who held such moments with a state of significant regard. He"
    BorderLine "didn't; he had a commitment to take care of."
    BorderLine ""
    BorderLine "He went downstairs, and noticed Punbell was preoccupied with"
    BorderLine "an administrative matter. \"He had been one of our best patrons,"
    BorderLine "and sufficeth to say, it is sad to watch him lose himself..."
    BorderLine "Oh, is that right? I didn't know they were unaware... well,"
    BorderLine "some other time then, be sure to come next week.\""
    BorderBottom

    Write-Host ""
    Write-Host (Center "[1] Who is he talking to?")
    Write-Host (Center "[2] ...")
    Write-Host (Center "[3] ...")
    Write-Host ""
    Write-Host (Center "[m] Return to main menu")
    Write-Host (Center "[q] Quit")
    Write-Host ""

    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($choice) {
        '1' {}
        '2' {}
        '3' {}
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath
            exit
        }
    }

    & "$ScriptDir/page_79.ps1"
    exit
}

# =============================================================
# MAIN
# =============================================================
Show-TitlePage
Show-TextPage
