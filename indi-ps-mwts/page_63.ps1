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
$PageNumber = 63
$AllowSkip  = $true   # ✅ Page 63 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 63 ---"
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
    BorderLine "He had something in mind. He noticed that the number of birds were"
    BorderLine "frantic, even arguing with the squirrels over matters which were"
    BorderLine "significant to the birds and the squirrels, but of the trivial concerns"
    BorderLine "to outsiders. It did leave an impression, nevertheless. The thought of"
    BorderLine "surviving by one's wits even when circumstances felt unfavorable, was"
    BorderLine "ambitious albeit inevitable. He thought so, whilst watching the"
    BorderLine "squirrels make their stockpile for the change of seasons."
    BorderLine ""
    BorderLine "  \"A change of seasons is always welcome... To remember how fragile time"
    BorderLine "  is; to remind us of how, like crimson sunlight, to imagine what we"
    BorderLine "  might find is boundless joy, yet also endless melancholy.\""
    BorderLine ""
    BorderLine "That was a quote which resonated with him. \"Who had actually said those"
    BorderLine "lines was less relevant than why. I should look up the book where it was"
    BorderLine "said\" he thought to himself as he got up from the couch and looked at"
    BorderLine "the library."
    BorderLine ""
    BorderLine "There was a closet a bit further away from the couch, but it was"
    BorderLine "nevertheless a fascinating closet. Some of the books in this closet -"
    BorderLine "and it was a closet, not a library - were from a bygone era. To him they"
    BorderLine "were a bygone era; some mentioned great kings who stood and watched"
    BorderLine "their triumphs fade before their very eyes; some mentioned numerous"
    BorderLine "causes which were made possible by the deeds of both men and women..."
    BorderLine "Something the wicked would attempt to attain by conquest but fail, other"
    BorderLine "things the crooked would attempt by treachery but fail."
    BorderLine ""
    BorderLine "The rest of the books were on birds. They were not specifically on the"
    BorderLine "study of birds, rather the cultural context associated with birds - how"
    BorderLine "birds influenced the way society works."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 64, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_64.ps1"; exit }
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
