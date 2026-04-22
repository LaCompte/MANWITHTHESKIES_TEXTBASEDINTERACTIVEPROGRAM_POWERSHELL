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

function TypeWriterSlow {
    param([string]$t, [double]$delay = 0.7)
    foreach ($c in $t.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
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
$PageNumber = 85
$AllowSkip  = $true   # ✅ Page 85 IS skippable

# =============================================================
# TITLE PAGE (SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 85 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.7
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
    BorderLine "\"You probably have something to give to her, right?\" he asked, and"
    BorderLine "Bardia stepped out from the tree where he had been observing the"
    BorderLine "proceeding. He looked at the tombstone, and the empty plot which had"
    BorderLine "been readied for someone. The garden, laid out with care and concern for"
    BorderLine "her, was abundantly nurturing flowers. Chrysanthemums, tuplis and a star"
    BorderLine "of Birtash were amongst the ones planted. Bardia sighed and placed the"
    BorderLine "single stalk of the desert rose and then requested if he may share"
    BorderLine "something with her. Taking the silence, as well as some clearing off the"
    BorderLine "fog, to be an affirmative he sat on one of the chairs provided and read"
    BorderLine "portions from a notepad:"
    BorderLine ""
    BorderLine "I remember father being constantly worried about your health and"
    BorderLine "countenance. As diligent and as loyal as he had been in life, I had"
    BorderLine "tried to be the same. In that I could show how much I cared for you. I"
    BorderLine "had disavowed my vows - I promised an abstinence of speech, until your"
    BorderLine "health improved. I realize that I had been miscalculating my actions,"
    BorderLine "inasmuch as children are prone to such approaches. It is never too late"
    BorderLine "to say you matter to me: father and you had your reasons for sheltering"
    BorderLine "me, and to that I can only say that it was for the best; but with each"
    BorderLine "passing day, with each moment, I realize that my silence had rendered me"
    BorderLine "unable to speak with you. To let you know that you were a part of my"
    BorderLine "life. You still are - the birds I count in the morning light, the"
    BorderLine "support from Punbell in matters of a literary concern, the small"
    BorderLine "kindness of Mr. Elias, all remind me of you. And in all, I hope we met"
    BorderLine "often in this place, such that the ghosts of the past are buried.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 86, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_86.ps1"; exit }
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
