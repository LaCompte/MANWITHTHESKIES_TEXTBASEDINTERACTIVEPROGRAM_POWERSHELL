#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK = "`e[38;2;0;0;0m"
$BLUE  = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width
    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"

    for ($i = 0; $i -lt $rows; $i++) {
        Write-Host ($cream + (' ' * $cols) + $RESET)
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
    return (' ' * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)
    foreach ($c in $text.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
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
# PAGE SETTINGS
# =============================================================
$PageNumber = 21
$AllowSkip  = $true   # ✅ Page 21 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 21 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
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
    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        's' { if ($AllowSkip) { return "skip" } }
        default { return "continue" }
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
    BorderLine "He was overwhelmed by the site. The sight of so much paper bound into a"
    BorderLine "cover and then put into towers and towers of classified and categorized"
    BorderLine "columns, each numbered as a tower. The sheer volume alone would have"
    BorderLine "made a lesser man run away. Punbell, walking in his typical determined"
    BorderLine "yet mildly indifferent manner - a clipboard with lists was held by him"
    BorderLine "on his left arm, quietly noting each tower block and the books in each"
    BorderLine "one - gestured him to come forward. Using gestures he asked - in what"
    BorderLine "could best be described as earnest professionalism - which of the books"
    BorderLine "were present in the block. After listening to Punbell, he got up the"
    BorderLine "ladder next to the tower and read aloud each book title to Punbell,"
    BorderLine "starting from the rightmost corner at the topmost shelf, through to the"
    BorderLine "leftmost corner at the bottom shelf."
    BorderLine ""
    BorderLine "He noted that each tower, although numbered, had a pattern. He used this"
    BorderLine "pattern as he made his rounds with Punbell, helping in categorizing each"
    BorderLine "book. The ones which were not present in the library were noted and he"
    BorderLine "would then schedule a visit to them. Punbell - however- decided against"
    BorderLine "sending him, making him continue the same set of steps as he was trained"
    BorderLine "to do by Punbell."
    BorderLine ""
    BorderLine "Even though he was surrounded by an assortment of books, he did not"
    BorderLine "actually take time out to pick a book and read it. He, however, had"
    BorderLine "noticed people taking time to read through tomes without a care for"
    BorderLine "time. He found Punbell sitting at his desk, working through his map and"
    BorderLine "the list he had. He sat down in front of him, placed Elias' offering on"
    BorderLine "the table, and quietly waited."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 22, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k2) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_22.ps1"; exit }
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
