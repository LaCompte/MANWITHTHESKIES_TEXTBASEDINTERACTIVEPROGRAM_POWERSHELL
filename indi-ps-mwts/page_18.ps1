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

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$t)
    Write-Host ("| " + ("{0,-83}" -f $t) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE SETTINGS
# =============================================================
$PageNumber = 18
$AllowSkip  = $true     # ✅ Page 18 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 18 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
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
    BorderLine "  \"He whistled a song as he made his walk in a general direction. Most"
    BorderLine "  of his walk seemed to be pedestrian, with a noticeable increase in the"
    BorderLine "  fog as he made his walk onward. \"Whistle me a lullaby\" he hummed and"
    BorderLine "  whistled, as he made his way onwards. He couldn't clearly distinguish"
    BorderLine "  what lay ahead of him, and as he walked forward the trekking distance"
    BorderLine "  covered became consumed\""
    BorderLine ""
    BorderLine "\"I'll find out where I read that segment from\" he noted to himself"
    BorderLine "quietly as he made his way from the school back to the road. Much like"
    BorderLine "the section, he noticed that the fog had increased in thickness,"
    BorderLine "although it was noticeably more quiet. The family who had been at the"
    BorderLine "beach seemed to have gone in another place. Or not. The sound of the"
    BorderLine "water gave a very calming feeling as it struck the sand. He remembered"
    BorderLine "as he walked, something which he had thought of and considered whilst at"
    BorderLine "the school. He found after some time, that he was near to the pavement"
    BorderLine "leading to Elias' shop. He entered the shop."
    BorderLine ""
    BorderLine "\"You look like a century old joke being sold to a clueless child\""
    BorderLine "commented Elias, as he cleaned some cups. He had an opened box near the"
    BorderLine "counter. After placing the cup on one of the shelves, he took out one of"
    BorderLine "the dolls from the opened box, and observed it very meticulously. \"Are"
    BorderLine "you thinking what I am thinking\" Elias asked him, whilst turning the"
    BorderLine "doll too and fro. Elias did not need to get a response - neither in"
    BorderLine "words, nor in gesture. \"So I am the only one thinking it\" said Elias,"
    BorderLine "and put the doll in a box and hid it under his counter."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 19, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k2) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_19.ps1"; exit }
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
