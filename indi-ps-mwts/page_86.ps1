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

function TypeWriterSlow {
    param([string]$t, [double]$delay = 0.9)
    foreach ($c in $t.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
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
$PageNumber = 86
$AllowSkip  = $true   # ✅ Page 86 IS skippable

# =============================================================
# TITLE PAGE (VERY SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 86 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.9
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
    BorderLine "Bardia looked at the letter, moved and slightly tearful. A hand was"
    BorderLine "placed on his shoulder, and told Bardia \"Let it go. I'm sure she would"
    BorderLine "understand\" he looked at the changing fog, which engulfed the graveyard,"
    BorderLine "and consumed it. The sound of the wind had become strong and with it had"
    BorderLine "a moment of doubt first come. Then it passed. He looked at the rose, and"
    BorderLine "nodded \"I hope you find closure, knowing the truth\" he thought to"
    BorderLine "himself as he walked to the gate of the cemetery."
    BorderLine ""
    BorderLine "He simply decided to walk until a direction would make itself known."
    BorderLine "\"After all, everyone seems to be directed somewhere\" he quipped, taking"
    BorderLine "interest on the change of dresses. He took the turning from Colonial"
    BorderLine "point through to the Niner Hotel."
    BorderLine ""
    BorderLine "He rang the bell at the reception and was responded by a gracious \"May I"
    BorderLine "help you?\" by Homeiz. \"Why yes, she had a message for you. A moment"
    BorderLine "please\" and while Homeiz searched, the sound of music would be heard."
    BorderLine "\"A package was delivered to your room. I'm sure you will know what it"
    BorderLine "means since it is marked\" answered Homeiz. He smiled at Homeiz and"
    BorderLine "acknowledged what was said."
    BorderLine ""
    BorderLine "In his room, he looked at the package. But did not open it. He read"
    BorderLine "through the letter on the desk, and wondered, smiling at the small"
    BorderLine "gathering near the lake. He changed his clothes and wrote a note. A call"
    BorderLine "was made to which he responded in a positive tone. He closed the phone"
    BorderLine "and opened the door."
    BorderLine ""
    BorderLine "Upon the opening of the elevator, the man answered \"Bardia, my boy!\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 87, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_87.ps1"; exit }
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
