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
$PageNumber = 67
$AllowSkip  = $true   # ✅ Page 67 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 67 ---"
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
    BorderLine "After what seemed like an eternity, but really was just ten minutes, he"
    BorderLine "came and said \"In case you are still hungry, or want to wash the milk"
    BorderLine "down\", offering the meal of eggs, beef, rice, and potatoes."
    BorderLine ""
    BorderLine "Bardia looked at the meal then at him, and returned the gaze back to the"
    BorderLine "meal, wondering at what had been provided. After a few minutes, Bardia"
    BorderLine "asked \"How do you eat this?\" In a tone that was less angry, or curious,"
    BorderLine "or sarcastic, more a state of wondrous awe. He returned with a fork and"
    BorderLine "knife, and taught Bardia what the meal was, how it was cooked, and what"
    BorderLine "were the ingredients in addition to the core ingredients. Bardia took a"
    BorderLine "bite, then another one, and continued doing so until he had finished all"
    BorderLine "of it."
    BorderLine ""
    BorderLine "\"How do you feel?\" He asked Bardia whilst picking up the dishes. \"Happy!"
    BorderLine "As happy as can be. That was amazing! Thank you!\" Said Bardia and hugged"
    BorderLine "him. He was taken aback by the action, and only responded back with a"
    BorderLine "light tap on Bardia's shoulders."
    BorderLine ""
    BorderLine "As Bardia went upstairs, he asked Bardia a few questions. The fog had"
    BorderLine "started to slowly and steadily become opaque. The scent of something"
    BorderLine "also marked its presence in the house. Both Bardia and he decided to get"
    BorderLine "ready, and head to the school. Whilst waiting for Bardia, he decided to"
    BorderLine "turn on the radio. He noticed it lying in a corner, on one of the ledges"
    BorderLine "adjacent to the window: he was wondering if it worked. The initial"
    BorderLine "crackling followed by the slow clearing voice was evidence, sufficient"
    BorderLine "to prove the correct answer."
    BorderLine ""
    BorderLine "\"Chance of light rain, followed by a chill, and snow forecasted in the"
    BorderLine "morning... Noted\" he said, and then turned it off. Both Bardia and he"
    BorderLine "left the house, with Bardia locking the door. Bardia walked hand in hand"
    BorderLine "with him to the open. He made sure that they both of them had umbrellas,"
    BorderLine "and had kept them up."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 68, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_68.ps1"; exit }
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
