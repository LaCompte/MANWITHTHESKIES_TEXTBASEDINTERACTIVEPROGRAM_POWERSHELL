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
$PageNumber = 55
$AllowSkip  = $false   # ✅ NON‑SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 55 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
    Write-Host $RESET

    FadeIn (Center "______________________") $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    # NO SKIP ALLOWED
    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
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
    BorderLine "He looked around the hall, as the manager requested him to wait. It was"
    BorderLine "related to inviting the concerned individual whom had been intimated"
    BorderLine "about the case. Counting the time spent, a fine gentleman arrived and"
    BorderLine "introduced himself."
    BorderLine ""
    BorderLine "\"Hello, my name is Rinaar. How may I be of assistance?\""
    BorderLine ""
    BorderLine "\"I had a deposit in the bank some time back. It was under the following"
    BorderLine "details.\""
    BorderLine ""
    BorderLine "The details were perused by Rinaar. There were a few questions asked"
    BorderLine "here and there, but mostly it was an easily followed set of inquiries."
    BorderLine "Rinaar took leave for some time to confirm these details, and left him"
    BorderLine "at the reception area of the back."
    BorderLine ""
    BorderLine "\"How can Mr. Bez enter such a secure building?\" He inquired as he saw a"
    BorderLine "set of open doors, acting as less a barrier and more a form of courtesy"
    BorderLine "for the general public. Having said that, he wondered why he was the"
    BorderLine "only person inside the building: most of the tellers seemed to be"
    BorderLine "preoccupied with matters that were important - assumably - but did not"
    BorderLine "concern with the public directly. He took the newspaper and read through"
    BorderLine "it again. He had noted something in his notepad when Rinaar returned."
    BorderLine ""
    BorderLine "\"Yes, sir. All information checked out. I could have someone bring the"
    BorderLine "files and deposits here to you directly -\""
    BorderLine ""
    BorderLine "\"I would prefer looking at the contents at source, Rinaar. If it is all"
    BorderLine "right with the bank.\""
    BorderLine ""
    BorderLine "\"Of course, sir. Follow me please.\""
    BorderLine ""
    BorderLine "Rinaar led him through an assortment of halls and chambers, until they"
    BorderLine "reached an elevator. Rinaar called the elevator which was somewhere on"
    BorderLine "the twentieth floor. Rinaar noticed him whistling a tune to a song."
    BorderLine "Rinaar kept his eyes on the elevator, softly tapping his shoes to the"
    BorderLine "beat of the tune. The transition from a whistled tune to the actual"
    BorderLine "music from the song that played in the elevator did not phase either"
    BorderLine "Rinaar, him, or the people exiting the elevator."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 56, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_56.ps1"; exit }
    }
}

# =============================================================
# MAIN
# =============================================================
Show-TitlePage
Show-TextPage
