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
$PageNumber = 54
$AllowSkip  = $true   # ✅ Page 54 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 54 ---"
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
    BorderLine "He took out his notebook and shared a name, inquiring if any information"
    BorderLine "was available on him. The manager pondered, and asked him to wait. He"
    BorderLine "sat down in the main hall. This acted as a lounge from where everyone"
    BorderLine "concerned would be called and made to act their part. He noticed that"
    BorderLine "the roof had a lavish painting - it was not isolated, rather it seemed"
    BorderLine "to be spread out to the whole hall, as each portion was in continuation"
    BorderLine "of the key point. He took note of it and decided to walk in the hallway,"
    BorderLine "to finish the painting."
    BorderLine ""
    BorderLine "There was a stork clearly visible among the numerous birds and it"
    BorderLine "carried a sack on its beak - \"Dave I gather\" he commented. The stork was"
    BorderLine "passing through numerous hurdles, which had been presented beat for beat"
    BorderLine "in the painting. What caught his eye was a portion of the painting where"
    BorderLine "the eagle handed a memento to Dave, in the presence of numerous"
    BorderLine "dignitaries, after which a snapshot of Dave looking at his boss walking"
    BorderLine "to the light, was followed up with Dave being the leader of the company."
    BorderLine "From what was portrayed, it seemed that he had been quite successful. A"
    BorderLine "thought came to his mind, and with it he looked at the reprint he had"
    BorderLine "bought. It was fascinating that there was no mention of it in the roof"
    BorderLine "mural."
    BorderLine ""
    BorderLine "He was still in the lounge, waiting. He decided to open a newspaper,"
    BorderLine "reading through the section marked \"The secret suspicious section\". It"
    BorderLine "kept him busy for some time, giving him a few tid-bits which seemed new"
    BorderLine "yet somewhat dubious by reference. He put the newspaper down, and took"
    BorderLine "out his notepad. \"I'll get Bardia his ice cream, soon as I am done here\""
    BorderLine "he thought to himself, and put the notepad back."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 55, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_55.ps1"; exit }
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
