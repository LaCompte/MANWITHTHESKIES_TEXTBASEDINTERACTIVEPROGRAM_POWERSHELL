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

    for ($i=0; $i -lt $rows; $i++) {
        Write-Host ($cream + (" " * $cols) + $RESET)
    }
    Write-Host "`e[H"
}

# =============================================================
# UI HELPERS
# =============================================================
function Center {
    param([string]$text)
    $width = $Host.UI.RawUI.WindowSize.Width
    $pad   = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
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
    Start-Sleep -Seconds 2
    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep -Seconds 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

function BorderTop    { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom { Write-Host "|-------------------------------------------------------------------------------------/" }
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
# PAGE PROPERTIES
# =============================================================
$PageNumber = 43
$AllowSkip  = $true   # Page 43 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 43 ---"
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

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
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
    BorderLine "`"Curious what a small menial task could do to a town`" he thought to"
    BorderLine "himself, as he looked at the map. It was the last page on the directory,"
    BorderLine "marked by the bookmark which had an ornate design and a fine handwriting"
    BorderLine "from someone who had not been very careful about things in general."
    BorderLine ""
    BorderLine "He noted some of the locations on his notepad, and the directions on how"
    BorderLine "to reach them. He left the telephone booth, and made his way from the"
    BorderLine "entrance of the Birtash tents towards the street marked `"Niner schemes`"."
    BorderLine "The lack of any view of the Niner Hotel from any visual point of the map"
    BorderLine "did not phase him. From there, he took a right, then straight till he"
    BorderLine "found a crossroad; walking straight seemed to lead to an avenue that he"
    BorderLine "could recall, but not completely; to the left were an assortment of"
    BorderLine "buildings, in series, which seemed to be on fire yet did not spread, nor"
    BorderLine "did they seem to be phased by this happening; on his right was a road"
    BorderLine "heading downwards. He headed right, and followed the road."
    BorderLine ""
    BorderLine "He whistled to himself as he made his way downwards. The smell of bread"
    BorderLine "and fresh fried eggs accompanies by a variety of fruits, some more"
    BorderLine "fragrant than others. There didn't seem to be many people outside. He"
    BorderLine "continued his way, finding the change from two sides covered by"
    BorderLine "buildings, to one side having buildings with an overarching view of the"
    BorderLine "beach."
    BorderLine ""
    BorderLine "He continued to walk forward in the direction of a staircase which led"
    BorderLine "downward to the beach. He took the stairs, took off his shoes and felt"
    BorderLine "the sand touch his feet."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 44, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_44.ps1"; exit }
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
