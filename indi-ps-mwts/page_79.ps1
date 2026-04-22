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
$PageNumber = 79
$AllowSkip  = $true   # ✅ Page 79 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 79 ---"
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
    BorderLine "He took the staircase and went down to the beach, from where he"
    BorderLine "continued straight past the guard post - \"how can you guard the endless"
    BorderLine "bounds of water, when it does not guarantee guarding you?\" - he walked"
    BorderLine "onward. He found himself facing a parking lot. Heading upward - he took"
    BorderLine "the staircase to get to the parking lot - he walked and was amusing"
    BorderLine "himself with a memory."
    BorderLine ""
    BorderLine "\"There is something for you\" to which an item was handed. He remembered"
    BorderLine "reading this line somewhere in a book. It was the beginning of a very"
    BorderLine "fascinating mystery short story - amongst the few things which seemed to"
    BorderLine "have held his attention, apart from Rivek Thalroppe. Yet, among the"
    BorderLine "numerous times he had read these books, he never knew the author. Quite"
    BorderLine "literally, he did not know the author: he recollected the stories where"
    BorderLine "the perpetrator of the act was always any person lurking where the crime"
    BorderLine "had been committed, always a person faced by circumstances towards the"
    BorderLine "act, and the person who caught the perpetrator was an honest, upright,"
    BorderLine "well groomed officer of the law. And yet he did not know the name of the"
    BorderLine "author."
    BorderLine ""
    BorderLine "He remembered when, near the end of a library shift, he had noticed"
    BorderLine "Punbell having a cup of tea. \"Something on your mind?\" he asked blandly."
    BorderLine "After taking up and finishing half the tea, Punbell responded in a"
    BorderLine "bored, monstrous voice \"The gentleman in question never bothered writing"
    BorderLine "his name. if it was a woman she would have used a pseudonym, or a nom du"
    BorderLine "plume.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 80, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_80.ps1"; exit }
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
