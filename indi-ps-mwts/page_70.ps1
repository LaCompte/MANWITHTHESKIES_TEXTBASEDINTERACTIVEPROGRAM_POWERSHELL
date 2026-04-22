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

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine    { param([string]$t) ; Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 70
$AllowSkip  = $true   # ✅ Page 70 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 70 ---"
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
    BorderLine "Bardia, Laraiez, and he sat down and talked for some time, then he and"
    BorderLine "Bardia bid Laraiez goodbye as they left the office."
    BorderLine ""
    BorderLine "\"Punbell invited you to something?\" Bardia asked him. He nodded."
    BorderLine ""
    BorderLine "\"Do you plan on going?\" Bardia inquired, to which he looked at Bardia"
    BorderLine "and said \"I don't know.\" Bardia and he headed out from school and left"
    BorderLine "the premise."
    BorderLine ""
    BorderLine "\"How did school go?\""
    BorderLine ""
    BorderLine "\"It was interesting.\""
    BorderLine ""
    BorderLine "\"Oh? Anything I should know about?\" He asked Bardia. Bardia spoke and"
    BorderLine "was heard. They continued to talk until they reached the beach, from"
    BorderLine "where Bardia took off his bag. He picked up Bardia's bag and made sure"
    BorderLine "that it was properly closed in the locker. He headed to the beach."
    BorderLine ""
    BorderLine "The sound of the waves calmed any doubts in Bardia's mind, and both"
    BorderLine "Bardia and he simply made the most with the moment. Both Bardia and he"
    BorderLine "had mats placed on the sand, learning from the experience they both had."
    BorderLine "Whilst the waves made their argument, the fog changed and plotted and"
    BorderLine "schemed... At least that was what the clouds seemed to indicate. There"
    BorderLine "seemed to be a thought in his mind as he heard the waves."
    BorderLine ""
    BorderLine "\"I remember seeing a couple here in the vicinity. You happened across"
    BorderLine "them by any chance?\""
    BorderLine ""
    BorderLine "\"When? I haven't seen or heard of any such thing.\""
    BorderLine ""
    BorderLine "\"When... Is a unique question to ask.\""
    BorderLine ""
    BorderLine "\"I mean, when did you last see them? If I know the time, I can respond"
    BorderLine "accordingly.\" He wondered at Bardia's answer, and stayed quiet for some"
    BorderLine "time. He then responded by \"It was quite some time ago, I suppose; they"
    BorderLine "probably have left by now, never mind.\" Bardia shrugged at the answer"
    BorderLine "and lay back on the mat."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 71, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_71.ps1"; exit }
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
