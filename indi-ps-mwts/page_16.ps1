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
$PageNumber = 16
$AllowSkip  = $true   # Page 16 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 16 ---"
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
    BorderLine "`"Before your father will arrive, I was hoping that you and I could have"
    BorderLine "a discussion about a matter of grave concern.`" Laraiez said, hoping to"
    BorderLine "proceed without interruption while at the same time indulging in tea"
    BorderLine "dipped Yivelis. Both of these wishes were granted. Whilst the discussion"
    BorderLine "was proceeding, he looked out of the window and observed the view. The"
    BorderLine "sound of leaves rustling, the wind blowing, and the distant flowing of"
    BorderLine "water from a distance. He thought to himself if Laraiez could hear that"
    BorderLine "water flowing, but kept quiet as Laraiez was busy with his lecture."
    BorderLine ""
    BorderLine "Laraiez had lowered his glasses and asked him `"I heard that you had"
    BorderLine "wanted to avoid playing sports in order to spend more time at the"
    BorderLine "library. Is that true?`" To this, Laraiez was given a positive response."
    BorderLine "Laraiez asked a few more questions, and was promptly answered. There had"
    BorderLine "been a debate on some of the answers between Laraiez and him, but these"
    BorderLine "were purely to determine the dedication of his decision. He had stayed"
    BorderLine "in school after school-hours as he had been asked by Laraiez for this"
    BorderLine "discussion. Laraiez nodded when he was informed about the application"
    BorderLine "that had also been submitted."
    BorderLine ""
    BorderLine "When his father arrived, Laraiez had the gentleman seated outside his"
    BorderLine "office and then, with his son, came to greet the person. they had some"
    BorderLine "small talk regarding how children will always do as they please."
    BorderLine ""
    BorderLine "`"I'll inform Punbell about your son. he would appreciate the help`" said"
    BorderLine "Laraiez. he was taken aback not so much by the Qin giving permission,"
    BorderLine "but by his father; his father shook hands with Laraiez, immeasurably"
    BorderLine "proud of his son being given such an opportunity. they shared one more"
    BorderLine "greeting and then departed."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 17, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_17.ps1"; exit }
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
