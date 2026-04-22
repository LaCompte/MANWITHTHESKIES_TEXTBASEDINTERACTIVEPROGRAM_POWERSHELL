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
        Write-Host -NoNewLine $c
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
$PageNumber = 92
$AllowSkip  = $false   # ✅ NON‑SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 92 ---"
    Write-Host -NoNewLine $BLUE
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
    BorderLine "\"Truth be told, it was not a very enlightening piece. Or anything"
    BorderLine "to boast about\" commented Bardia, as he wrapped the paper and"
    BorderLine "placed it in his pocket. He noticed that the couple and their son"
    BorderLine "and their family were slowly making their way to where the sounds"
    BorderLine "were being played. Bardia was about to get up when he noticed a"
    BorderLine "child sitting by himself on the bench just a little while ahead"
    BorderLine "from him. The child was sitting by himself and did not seem like"
    BorderLine "there was anything accompanying him. Bardia got up and was"
    BorderLine "thinking about the child. He stopped, and walked to him."
    BorderLine ""
    BorderLine "Bardia smiled, and asked \"Good day, young man. How are you?\""
    BorderLine "\"I am quite well, sir\""
    BorderLine "\"Are you waiting for someone?\""
    BorderLine "\"No, just looking at the clouds and the fields.\""
    BorderLine "\"I see. Well, if it isn't a problem, may I join you in looking"
    BorderLine "at these fields? They have quite a story to tell.\""
    BorderLine "\"I suppose, sir, you may.\""
    BorderLine ""
    BorderLine "Bardia sat next to the child and they looked at the field and"
    BorderLine "the clouds together. The changing moods seemed to be reflected"
    BorderLine "up above and noticing these, Bardia asked the child \"Are you"
    BorderLine "familiar with the Man with the Skies?\" the child, confused,"
    BorderLine "asked \"The Man with the Skies?\""
    BorderLine "Bardia pondered on this for a moment, and with an approving nod,"
    BorderLine "and a smile showing enlightenment and responded \"It is a"
    BorderLine "fascinating story, and might even catch your interest.\""
    BorderBottom

    Write-Host ""
    Write-Host (Center "[1] Man with the Skies.")
    Write-Host (Center "[2] ...")
    Write-Host (Center "[3] I am him.")
    Write-Host ""
    Write-Host (Center "[a] Additional Content")
    Write-Host (Center "[m] Return to main menu")
    Write-Host (Center "[q] Quit")
    Write-Host ""

    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($choice) {
        '1' { & "$ProjectRoot/additional_content.ps1"; exit }
        '2' { & "$ProjectRoot/additional_content.ps1"; exit }
        '3' { & "$ProjectRoot/additional_content.ps1"; exit }
        'a' { & "$ProjectRoot/additional_content.ps1"; exit }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath
            exit
        }
    }
}

# =============================================================
# MAIN
# =============================================================
Show-TitlePage
Show-TextPage
