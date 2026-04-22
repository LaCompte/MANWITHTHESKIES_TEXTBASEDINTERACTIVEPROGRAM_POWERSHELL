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
$PageNumber = 42
$AllowSkip  = $true   # Page 42 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 42 ---"
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
    BorderLine "He acknowledged what had been spoken, but had no opinions about it. He"
    BorderLine "couldn't give it much thought. The commotion of something being cooked"
    BorderLine "distracted him. Something specific which he had eaten before, yet could"
    BorderLine "not specifically put into words. So instead, he decided to follow the"
    BorderLine "scent, and where it would lead him. He passed by the tent calling an"
    BorderLine "assortment of sweets. And as he walked, he felt the scent growing in"
    BorderLine "intensity and its general quality. He found it."
    BorderLine ""
    BorderLine "`"Hello good lad. What will be your pleasure... I see, a good choice."
    BorderLine "Would you like... No? Very well then. Mostly everyone I've known had it"
    BorderLine "differently... Yes, quite right. There is no true way of eating this"
    BorderLine "dish... You like it from what I gather, should I... Eh, you would like"
    BorderLine "one more? I'm sure he would like it very much. Thank you... Stay"
    BorderLine "blessed...`""
    BorderLine ""
    BorderLine "He kept thinking to himself as he looked around some more at the Birtash"
    BorderLine "tents. He wondered if there were more attractions available in the"
    BorderLine "vicinity. So he walked around and found himself a telephone booth. All"
    BorderLine "that was found inside - could be found inside, all the same - was the"
    BorderLine "telephone, a page with specific numbers and whom to address, and a"
    BorderLine "directory with numerous colored pages: red for `"hospitals and almanac`";"
    BorderLine "yellow for `"services`"; white for `"Lost`"; gray for `"Numbers`"; green for"
    BorderLine "`"Arts`"; pink for `"Nothing related to women unless it's a funny story or"
    BorderLine "a lady shop`"; and black for `"All the above, in that order`"; brown for"
    BorderLine "`"general numbers`", silver were `"restaurants`", cyan for `"hotels`", and"
    BorderLine "maroon for `"every other place on the map which matters`"."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 43, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_43.ps1"; exit }
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
