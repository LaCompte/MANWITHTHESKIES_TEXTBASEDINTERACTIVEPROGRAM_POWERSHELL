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
$PageNumber = 77
$AllowSkip  = $true   # ✅ Page 77 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 77 ---"
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
    BorderLine "\"Could we go to the bank first?\" asked Bardia, and was promptly given a"
    BorderLine "curt response \"No.\" Bardia looked at him, somewhat miffed at the answer."
    BorderLine "He bent his knees, and told Bardia while keeping eye contact \"The bank"
    BorderLine "is closed. If it makes you feel any better, we could go to meet Punbell."
    BorderLine "It has been a while, plus he and the school are nearby\". Bardia promptly"
    BorderLine "said no by shaking his head with significant energy, although he knew"
    BorderLine "that Bardia was only using enough to prevent injury to himself."
    BorderLine ""
    BorderLine "He noted the response and decided to follow the beaten path; it should"
    BorderLine "lead to a place of respite, sooner or later. There were a few, very"
    BorderLine "disturbing thoughts which came to mind as a result of his idea of"
    BorderLine "visiting Punbell first. He brushed them aside as a by-product of"
    BorderLine "lethargy and decided to take some rest on one of the benches. Bardia"
    BorderLine "asked if he was hungry, to which he responded in the negative. Bardia"
    BorderLine "ate from the snacks that he had packed alongside and looked around. It"
    BorderLine "was a quiet view, and yet it did not seem to be all as quiet as it"
    BorderLine "should be."
    BorderLine ""
    BorderLine "\"It is nature's way\" he thought, as he let the situation soak in. The"
    BorderLine "sound of squirrels, frogs, ducks, pigeons, and occasional badgers was"
    BorderLine "sufficient to keep the imagination of any person flow vibrant. It was a"
    BorderLine "calming scene, and his thoughts wondered off again onto another series"
    BorderLine "of thoughts. He seemed to be in a distant place, yet very familiar faces"
    BorderLine "roamed around. Just as he was about to push deeper into such a thought,"
    BorderLine "he was shook awake from his slumber and asked by Bardia: \"you having the"
    BorderLine "last one, or may I?\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 78, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_78.ps1"; exit }
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

