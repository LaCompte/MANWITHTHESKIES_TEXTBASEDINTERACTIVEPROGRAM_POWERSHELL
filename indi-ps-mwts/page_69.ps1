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
$PageNumber = 69
$AllowSkip  = $true   # ✅ Page 69 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 69 ---"
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
    BorderLine "They reached the crossroads. They headed up, and took the turning"
    BorderLine "towards the school. He looked at Bardia, wondering at the silence and"
    BorderLine "the general distracted gaze. He stopped thinking about it once they"
    BorderLine "reached the school entrance. Bardia went to his classroom, Laraiez"
    BorderLine "greeted Bardia, and gestured him to wait. Laraiez looked at him, and"
    BorderLine "took him to the Qin's office once Bardia entered the classroom."
    BorderLine ""
    BorderLine "\"It has been a while since you last visited.\""
    BorderLine ""
    BorderLine "\"Has it been a while since I caused problems?\""
    BorderLine ""
    BorderLine "\"Well that is true. Punbell had mentioned that you had been quite busy"
    BorderLine "in the library... Were doing quite a good job too.\""
    BorderLine ""
    BorderLine "\"It is routine, I suppose. Make hay whilst the sun shines. Or when you"
    BorderLine "have time.:"
    BorderLine ""
    BorderLine ":Time: the one thing everybody wants, yet nobody has. So, what is it you"
    BorderLine "bid me this time?\""
    BorderLine ""
    BorderLine "\"It... Is much more than a bid... I would say that it is a favor.\""
    BorderLine ""
    BorderLine "\"A... Favor?\""
    BorderLine ""
    BorderLine "\"It is a personal matter. And requires a delicate, sensitive eye to"
    BorderLine "resolve. I would have approached anyone else. You were the ideal person"
    BorderLine "to approach.\""
    BorderLine ""
    BorderLine "\"I see... So what you are seeking is advice, not a favor.\""
    BorderLine ""
    BorderLine "\"If you seek to look at it that way... It is about Punbell.\""
    BorderLine ""
    BorderLine "\"... A kind gesture from Punbell. Shame you are not taking it up.\""
    BorderLine ""
    BorderLine "\"I suppose... Although considering we are talking about Punbell.\""
    BorderLine ""
    BorderLine "\"Very well... If that is how you wish it to be, I will let Punbell"
    BorderLine "know.\""
    BorderLine ""
    BorderLine "\"... What about Bardia?\" \"... Very well, no harm in talking about it.\""
    BorderLine ""
    BorderLine "\"Bardia! Please, come in!\" Said Laraiez as Bardia entered and sat down."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 70, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_70.ps1"; exit }
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
