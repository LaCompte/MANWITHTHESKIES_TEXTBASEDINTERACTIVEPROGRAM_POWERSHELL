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
$PageNumber = 81
$AllowSkip  = $true   # ✅ Page 81 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 81 ---"
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
    BorderLine "Bardia appreciated the book in the palms of his hands. \"I believe we"
    BorderLine "have to go somewhere, wouldn't you agree?\" he asked Bardia, to which"
    BorderLine "Bardia noted a crowd of pedestrians who had worn the same cap, passing"
    BorderLine "by - they seemed to be interested in the going-ons of the city, as"
    BorderLine "tourists tend to do. Most of them had questions, regarding the Rivek"
    BorderLine "Thalroppe celebrations, and the Birtash, and the streets upon which they"
    BorderLine "were walking. Bardia found himself facing a street lamp, a pedestrian"
    BorderLine "crossing, and a traffic light."
    BorderLine ""
    BorderLine "He held Bardia's hand. Bardia was nervous, scared, doubtful, and even to"
    BorderLine "a certain extent he was not willing to cross that pedestrian crossing."
    BorderLine "\"Better to face the music now, than to forcefully remove noise later.\""
    BorderLine "He spoke aloud. Bardia, taking a deep breath, looked at the traffic"
    BorderLine "light, and when it turned green, crossed the road. Bardia was heading to"
    BorderLine "the hospital, with the book that he had just a few moments back been"
    BorderLine "gifted. He looked at Bardia, and noticed that an emotion marked out the"
    BorderLine "state of mind he was in: dread. \"One must always be willing to face"
    BorderLine "one's mortality. You can't do anything to alter that. What you can do is"
    BorderLine "make the process easier by retelling the good that happened, and the"
    BorderLine "good that men do\" he advised Bardia, who was waiting outside in a lobby,"
    BorderLine "staring at a door."
    BorderLine ""
    BorderLine "A nurse came out of the room and beckoned Bardia inside. Bardia walked"
    BorderLine "in and was greeted by the patient: a stately, yet pale, gentleman whose"
    BorderLine "age had left his countenance bereft of joy; yet the moment he saw Bardia,"
    BorderLine "he smiled, and requested the visitor to come near."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 82, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_82.ps1"; exit }
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
