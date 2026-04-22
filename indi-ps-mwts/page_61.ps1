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
$PageNumber = 61
$AllowSkip  = $true   # ✅ Page 61 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 61 ---"
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
    BorderLine "He looked around at the avenue, thinking about something. It consumed"
    BorderLine "his thoughts for a brief duration. He decided to walk, and he took pace."
    BorderLine "The sound of trees - leave rustling alongside scurrying about too and"
    BorderLine "fro, seemed like an appreciative welcome compared to the silent,"
    BorderLine "calming, quiet contemplation which was the case with the bank. But he"
    BorderLine "did not give it much thought. \"It is the rustling of leaves. It is other"
    BorderLine "sounds which nature makes\" he commented on the matter in his mind. His"
    BorderLine "response was whistling a song that came to his mind after much silence."
    BorderLine ""
    BorderLine "He continued to walk, noting that the fog had become thicker as he kept"
    BorderLine "walking forward. The sound of footsteps did leave him disconcerted and"
    BorderLine "slightly perturbed. It was not as if the place was unknown - he had"
    BorderLine "walked around the locality on a sufficient number of occasions to be"
    BorderLine "anything but scared. It wasn't even that he had concerns about the fear"
    BorderLine "of something menacing which would bring any dread... The fog was"
    BorderLine "disconcerting, he felt that, but it was not imposing discomfort. What he"
    BorderLine "made out of it was an unknown dread, and that is why he decided to"
    BorderLine "proceed with caution, yet not lend it much thought. His actions proved"
    BorderLine "to be effective - the fog became less intimidating and was much more"
    BorderLine "indifferent. He wondered why he was at the beach, but shrugged it aside."
    BorderLine "He took to the beaten path until he reached the stairs leading up to"
    BorderLine "Punbell. He took out the envelope from Punbell and saw it a second time,"
    BorderLine "carefully."
    BorderLine ""
    BorderLine "He decided to head to Bardia and share his findings. \"Punbell would"
    BorderLine "appreciate the gesture anyway\" he thought as he took the stairs from the"
    BorderLine "beach to the library heading in the direction of the Birtash tents. He"
    BorderLine "intended to visit the school later."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 62, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_62.ps1"; exit }
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
