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
$PageNumber = 53
$AllowSkip  = $true   # ✅ Page 53 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 53 ---"
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
    BorderLine "He walked from the shop to the main street, where another shop caught"
    BorderLine "his eye. He entered it, and found that there were plenty of paintings on"
    BorderLine "the shelves, albeit reprints in various sizes. He asked around for a"
    BorderLine "stork reprint, which was duly provided."
    BorderLine ""
    BorderLine "With the stork reprint in hand, he made his way towards the road heading"
    BorderLine "towards the crossroad. He headed upwards, and walked past the Niner"
    BorderLine "Hotel. He noticed a couple walking around the vicinity of the hotel"
    BorderLine "premise, but were less fascinated by what the hotel had to offer and"
    BorderLine "were searching for something. The woman asked, or implied that she was"
    BorderLine "asking, a series of questions to the man - questions which were not"
    BorderLine "audible. He turned his gaze away from the couple and continued walking"
    BorderLine "forward."
    BorderLine ""
    BorderLine "He noted another avenue as he made his way at the end of the road - \"an"
    BorderLine "avenue turning towards another avenue, how original\" he thought to"
    BorderLine "himself - and took note of the general affluence and well-maintained"
    BorderLine "class of the place he was walking towards. He also noted that some of"
    BorderLine "the roads on the avenue were owned by fairly decent, yet mostly rich,"
    BorderLine "individuals. The thought running in his mind at that point, as he made"
    BorderLine "his way to the bank, was \"did I give Bardia the ice-cream box I bought"
    BorderLine "from the Birtash?\""
    BorderLine ""
    BorderLine "He asked at the reception if they knew where the manager was going to be"
    BorderLine "sitting. The lady responded by informing him of where the manager was"
    BorderLine "sitting, where he would be busy in case he was not sitting in his"
    BorderLine "office, and what time he will be busy with lunch. After sharing all"
    BorderLine "these findings and these facts, she politely guided him towards a seat."
    BorderLine "He sat down and waited. He took out his notepad and reviewed some notes"
    BorderLine "he had made in the duration he waited. The manager arrived and shook his"
    BorderLine "hand."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 54, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_54.ps1"; exit }
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
