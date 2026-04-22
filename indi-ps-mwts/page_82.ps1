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

function TypeWriterSlow {
    param([string]$t, [double]$delay = 0.7)
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
$PageNumber = 82
$AllowSkip  = $true   # ✅ Page 82 IS skippable

# =============================================================
# TITLE PAGE (SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 82 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.7
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
    BorderLine "\"Hello... I honestly was not expecting you to come here\" said the"
    BorderLine "patient. Bardia smiled, but lacked anything specific to share with the"
    BorderLine "patient. \"Bah, don't be so afraid, my boy. It is just a scratch?\""
    BorderLine "Bardia smirked and with an exaggerated yet low voice he exclaimed \"A"
    BorderLine "scratch? Surely a scratch does not warrant being hospitalized! A mere"
    BorderLine "tourniquet should suffice!\""
    BorderLine ""
    BorderLine "Bardia and the patient laughed at their inside joke. After they"
    BorderLine "collected themselves, the patient took note of the book which Bardia"
    BorderLine "held, and to it Bardia said \"I thought we could read it together, like"
    BorderLine "we used to back home.\" The patient smiled and agreed to the suggestion,"
    BorderLine "and Bardia sat down near to him, opened the book and read it."
    BorderLine ""
    BorderLine "\"It seems that Dave has finally found the boy.\""
    BorderLine ""
    BorderLine "\"That actually was hinted in the previous book. He... he... we concern"
    BorderLine "ourselves with how he plans on escaping.\""
    BorderLine ""
    BorderLine "\"Wait a minute. When was he kidnapped?\""
    BorderLine ""
    BorderLine "\"You didn't know? He was kidnapped during the previous book. The whole"
    BorderLine "portion in which he is writing in first person and those bleak"
    BorderLine "descriptions of life?? They were all while he had been held captive.\""
    BorderLine ""
    BorderLine "\"I don't remember those portions - \""
    BorderLine ""
    BorderLine "\"—because they were never read aloud. I read the book whenever you had"
    BorderLine "to go to take care of mom. It was one of the two things I could manage.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 83, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_83.ps1"; exit }
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
