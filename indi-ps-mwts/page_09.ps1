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
$PageNumber = 9
$AllowSkip  = $true   # Page 09 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 09 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host ""
    Write-Host (Center "Press any key to begin")

    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

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
    BorderLine "An elderly gentleman sat at the checkout point of the shop. He was"
    BorderLine "facing the door, focusing his energies in cleaning a cup; Elias, it"
    BorderLine "seemed, kept a variety of items with him. the cupboards had an"
    BorderLine "assortment of porcelain table-sets, a set of books whose titles were"
    BorderLine "obscured by the height at which they were placed; there were also some"
    BorderLine "dolls placed on the top shelves, some of which had brief descriptions"
    BorderLine "provided as notes stringed onto them. Perhaps he had ben noting one of"
    BorderLine "the dolls very carefully, as after some time Elias asked him:"
    BorderLine ""
    BorderLine "`"Have you ever been to the Birtash?`""
    BorderLine ""
    BorderLine "Elias took a sip from the cup of tea he had made. He nodded."
    BorderLine ""
    BorderLine "`"That was a long time back, seems like an age past by.`""
    BorderLine ""
    BorderLine "Elias got up from his stool and stepped out of the checkout. He took out"
    BorderLine "a stick which had a hook grafted onto one end. He took out some of the"
    BorderLine "objects from the shelves, and after some time would return them to their"
    BorderLine "place."
    BorderLine ""
    BorderLine "`"Yes, quite a collection, but still has a long way to go before I can"
    BorderLine "call it a complete collection.`""
    BorderLine ""
    BorderLine "Elias sighed and shook his head."
    BorderLine ""
    BorderLine "`"There is... are... so many places to go, before I can be fully"
    BorderLine "conclusive with what I have. I do wonder though... why are you so"
    BorderLine "interested in it?`""
    BorderLine ""
    BorderLine "Elias took a sip from his tea and had a Yivelis alongside."
    BorderLine ""
    BorderLine "He nodded and opened one of his drawers. `"Why not start from there? See"
    BorderLine "what the Qin has to say.`" said Elias."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 10, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_10.ps1"; exit }
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
