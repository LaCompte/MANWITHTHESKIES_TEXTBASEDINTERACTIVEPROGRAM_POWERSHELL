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
$PageNumber = 27
$AllowSkip  = $true   # Page 27 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 27 ---"
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
    BorderLine "He decided to walk further in the opposite direction, noticing that a"
    BorderLine "few more shops had opened up in that direction. The road seemed a little"
    BorderLine "bit on the wider side: there was a grander thoroughfare. The shops had"
    BorderLine "more space and even had a deeper number of gullies between them. He"
    BorderLine "could hear lots of chants and joyous music but it felt distant. `"Let it"
    BorderLine "go; they could have fun, that isn't why I'm here`" he emphasized in his"
    BorderLine "mind, slowly and steadily walking along the grid of the shops; he took a"
    BorderLine "right from one of the stores and continued to walk straight until he saw"
    BorderLine "a turning marked `"To the Birtash tents`". He went the opposite direction."
    BorderLine ""
    BorderLine "He found a house which had been perfectly fenced, had a vibrant green"
    BorderLine "garden., with a few garden-gnomes in various shapes. One of them looked"
    BorderLine "like someone who was an old harbinger of news, albeit withered by age"
    BorderLine "and the ways of nature. There seemed to be a lack of flowers on the"
    BorderLine "small mound at one of the edges of the fence. He could hear muffled"
    BorderLine "sounds from inside the house. He walked in the direction of the fences,"
    BorderLine "which turned and lead him to the entrance of the house. The roof was a"
    BorderLine "foggy gray color, with a blue door accented by a number of stars which"
    BorderLine "formed a frame around it. The walls were a mix of the two colors. There"
    BorderLine "was a small window to his right, which was curtained. He could not see"
    BorderLine "inside the house."
    BorderLine ""
    BorderLine "He first considered ringing the bell, but then he asked himself which"
    BorderLine "was more appropriate. There was a button on the top left border of the"
    BorderLine "door, and a knocker at the center of the door's design. `"Stick to old"
    BorderLine "faithful first, then try other options`" he advised himself."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 28, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_28.ps1"; exit }
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
