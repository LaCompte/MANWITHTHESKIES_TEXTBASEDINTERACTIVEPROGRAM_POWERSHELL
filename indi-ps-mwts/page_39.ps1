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
$PageNumber = 39
$AllowSkip  = $true   # Page 39 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 39 ---"
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
    BorderLine "He took out some food and placed it on the table, and along-with"
    BorderLine "provided safe cutlery - a spoon - to eat the requisite meal. He took out"
    BorderLine "a paper from the small ornament that had a stockpile of papers in it,"
    BorderLine "and wrote something on it. He placed the paper on the entrance drawer,"
    BorderLine "and put the keys, too, next to it. He noticed Bardia coming downstairs."
    BorderLine "`"Your parents will be heading home soon. I put the keys of the house on"
    BorderLine "the drawer. Paper has something meant for your parents. Food is on the"
    BorderLine "table .Soon as I leave, you go on ahead and get something sweet in you.`""
    BorderLine "Bardia nodded at what he said, opened the door, and asked for the keys."
    BorderLine "He nodded at what Bardia expected, obliged the needful, and left the"
    BorderLine "house."
    BorderLine ""
    BorderLine "He thought about what to do next, and decided to head in the direction"
    BorderLine "of the Birtash tents. So, he turned right from the house, and walked"
    BorderLine "straight. He continued straight for a significant duration. He knew he"
    BorderLine "was making progress, since he could hear the sound of carnival music"
    BorderLine "being part of a precession, and it was growing louder and more clear. He"
    BorderLine "hummed alongside, although he still could not see any sign of a"
    BorderLine "procession or a carnival passing through the streets."
    BorderLine ""
    BorderLine "He nevertheless, found the sign which lead into the tents themselves. `"I"
    BorderLine "think they were intentionally hoping to mislead audiences and also"
    BorderLine "anyone interested in the Birtash`" he sarcastically commented. The tents"
    BorderLine "had numerous enclosures, each opening for a specific trade. They were"
    BorderLine "not tents as much as they were marquees, which had things that they"
    BorderLine "would trade for specific reasons and means. It was a quiet place, with a"
    BorderLine "small number of people focused in specific tents."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 40, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_40.ps1"; exit }
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
