#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK  = "`e[38;2;0;0;0m"
$BLUE   = "`e[38;2;0;200;255m"
$RESET  = "`e[0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width

    $cream ="`e[48;2;255;253;208m`e[38;2;0;0;0m"

    for ($i = 0; $i -lt $rows; $i++){
        Write-Host ($cream + (" " * $cols) + $RESET)
    }

    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$t)
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
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

# RECTANGLE BORDERS
function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine    { param([string]$t) ; Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir


# =============================================================
# PAGE SETTINGS
# =============================================================
$PageNumber = 46
$AllowSkip  = $true   # ✅ Page 46 IS skippable


# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 46 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $ln = Center "______________________"
    FadeIn $ln $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")

    if ($AllowSkip){
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1" ; exit }
        'q' { exit }
        's' { if ($AllowSkip){ return "skip"} }
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
    BorderLine "\"You ever heard about the stork and the way that it had to struggle to"
    BorderLine "get its delivery across?\" He asked Bardia, to which he was provided a"
    BorderLine "negative answer. He answered by smiling and then told the tale about the"
    BorderLine "stork."
    BorderLine ""
    BorderLine "\"There used to be a time that the children of the world had to be"
    BorderLine "delivered to their relevant houses. Quite a complex bureaucracy was"
    BorderLine "involved. Bureaucracy is a heavy word, I would say it was a big bunch of"
    BorderLine "annoyed pigeons who hated traveling further than was absolutely"
    BorderLine "necessary. So they decided to hire new birds to make those deliveries."
    BorderLine "To this day, these deliveries are done by storks."
    BorderLine ""
    BorderLine "\"A stork came to the pigeons saying that he saw their advertisement for"
    BorderLine "a delivery bird who would be willing to travel long distances to get the"
    BorderLine "package to its location. The pigeons looked at this fine gentle-bird,"
    BorderLine "and wondered what he actually had in mind when he applied for the post."
    BorderLine "So they asked it a few questions. He knew his way around the world. He"
    BorderLine "certainly knew his geography, trigonometry, and airship physics. He had"
    BorderLine "a witty way with words, and loved pedantries. But most importantly, he"
    BorderLine "was determined to get the job, and was willing to prove his worth for"
    BorderLine "it. The pigeons were, and still are, a very devious and cowardly bunch"
    BorderLine "of creatures. So they decided to give the stork a shot. They hired him"
    BorderLine "on a temporary assignment."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 47, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($next){
        'm' { & "$ProjectRoot/main_menu.ps1" ; exit }
        'q' { exit }
        default { & "$ScriptDir/page_47.ps1" ; exit }
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
