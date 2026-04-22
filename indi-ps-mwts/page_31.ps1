#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK = "`e[38;2;0;0;0m"
$BLUE  = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

function FillCreamBackground {
    $rows  = $Host.UI.RawUI.WindowSize.Height
    $cols  = $Host.UI.RawUI.WindowSize.Width
    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"

    for ($i=0; $i -lt $rows; $i++){
        Write-Host ($cream + (" " * $cols) + $RESET)
    }

    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$text)

    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))

    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)

    foreach ($ch in $text.ToCharArray()) {
        Write-Host -NoNewline $ch
        Start-Sleep -Milliseconds ($delay*1000)
    }
    Write-Host ""
}

function FadeIn {
    param([string]$text, [string]$color)

    Write-Host "`e[2m$color$text$RESET"
    Start-Sleep 2

    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep 1

    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine    {
    param([string]$t)
    Write-Host ("| " + ("{0,-83}" -f $t) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE CONFIG
# =============================================================
$PageNumber = 31
$AllowSkip  = $true   # ✅ Page 31 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 31 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

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

    switch($k) {
        'm' { & "$ProjectRoot/main_menu.ps1" ; exit }
        'q' { exit }
        's' { if ($AllowSkip) { return "skip"} }
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
    BorderLine "He looked at Bardia and, bending one knee and looking at him with"
    BorderLine "earnest sincerity, said \"I'll ask your parents if they could bring"
    BorderLine "something sweet on their way home.\" Bardia looked at him, understanding"
    BorderLine "what he meant to say. Bardia took one of the utensils and pointed at the"
    BorderLine "bowl. He refilled Bardia's bowl, and handed it back. Whilst Bardia"
    BorderLine "enjoyed the feast, he walked out of the dining room cum kitchen, took"
    BorderLine "out his notepad and read through his notes. It was clear about some of"
    BorderLine "the details, and how to work on them. He put his notepad back, and"
    BorderLine "looked at the drawer at the entrance of the house."
    BorderLine ""
    BorderLine "An envelope was placed on the surface of the drawer. It was addressed to"
    BorderLine "Bardia, and had not yet been opened. He went to the dining room and"
    BorderLine "asked Bardia, \"Don't you want to check your letter.\" Bardia avoided his"
    BorderLine "gaze, playing around with his food in a distracted haze. He sat o one of"
    BorderLine "the seats, near enough to Bardia to be visible - fully - whilst not"
    BorderLine "being so imposing. \"If it is okay with you, would you like me to share"
    BorderLine "what is in the letter.?\" He asked Bardia. Bardia nodded to himself for a"
    BorderLine "minute, and then showed his agreement. He opened the letter and read it."
    BorderLine ""
    BorderLine "A quiet held in the room. Bardia did not ask questions, nor did he show"
    BorderLine "any nervousness either. He looked at the letter, and occasionally gazed"
    BorderLine "in Bardia's general direction. He closed the letter and put it back into"
    BorderLine "the envelope. \"It was instructions from your parents. They want to meet"
    BorderLine "up with us at some place. The address was provided, so I was clearing up"
    BorderLine "where it was. We would leave in some time. I'll wait for you to get"
    BorderLine "ready.\" He told Bardia, and sat down on the sofa waiting for an"
    BorderLine "affirmation."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 32, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch($next) {
        'm' { & "$ProjectRoot/main_menu.ps1" ; exit }
        'q' { exit }
        default { & "$ScriptDir/page_32.ps1" ; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
$result = Show-TitlePage
if ($result -ne "skip") {
    Start-Sleep -Milliseconds 300
}
Show-TextPage
