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
$PageNumber = 33
$AllowSkip  = $true   # Page 33 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 33 ---"
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
    BorderLine "`"The first Qin was said to be as quiet as the sky and as unpredictable"
    BorderLine "as the weather .Just as the fog takes up form whenever it so pleases,"
    BorderLine "the same applied to the Qin. Although he never raised his voice, the"
    BorderLine "first Qin was known to voice his anger through... Rather interesting"
    BorderLine "means. He was passing by our school one day. Some of the boys were doing"
    BorderLine "something, up to mischief and the like - as boys are wont to do, you can"
    BorderLine "imagine. The boys had decided to honk on the school horn, implying that"
    BorderLine "lunch and sport break had commenced. They were successful, but were"
    BorderLine "caught doing so by the first Qin."
    BorderLine ""
    BorderLine "`"He passed the playground quietly, and once all the boys had gone"
    BorderLine "inside, he walked to the gardener and told him something. I know because"
    BorderLine "I saw him walk to the gardener. I didn't take much notice of it back"
    BorderLine "then. The boys were walking back home when they noticed sand spread all"
    BorderLine "over the entrance of the school. Everyone followed the scrapes and found"
    BorderLine "the sandpit had been completely emptied of sand. In the sandpit,"
    BorderLine "instead, was muddy water and some sort of slime. Qin Laraiez heard about"
    BorderLine "the commotion, and took the situation into consideration."
    BorderLine ""
    BorderLine "`"The old gentleman who I had seen talk to the gardener, stepped forward,"
    BorderLine "and told everyone about the mischief committed by the three boys."
    BorderLine "Laraiez, staying calm, took note of the charges and, with mild"
    BorderLine "annoyance, had everyone leave and return home. The three boys, however,"
    BorderLine "stayed back. Laraiez had not asked them to, no one did - they stayed"
    BorderLine "back voluntarily. I don't remember the looks on their faces, or what"
    BorderLine "they specifically said, but I know they said something related to the"
    BorderLine "sandpit."
    BorderLine ""
    BorderLine "`"The next day, Laraiez called all of us over to the auditorium, and so,"
    BorderLine "we congregated there. He explained what had happened yesterday, who the"
    BorderLine "complainant was, and the reasons for his mildly annoyed response."
    BorderLine "However, he commended the three boys for taking responsibility for their"
    BorderLine "actions. And not only cleaning the sandpit, but also making sure that"
    BorderLine "'Qin Tapkul had been calmed down, informed of the lesson learnt, and"
    BorderLine "their remedy to the mischief'. We cheered the boys when they came"
    BorderLine "on-stage... I found out later about how they had achieved this feat, but"
    BorderLine "I don't remember it now, maybe once we reach the school I'll show you"
    BorderLine "how they did it. Sounds good?`""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 34, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_34.ps1"; exit }
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
