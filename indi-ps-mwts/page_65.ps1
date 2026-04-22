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
function BorderLine    { param([string]$t) ; Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 65
$AllowSkip  = $true   # ✅ Page 65 IS skippable

# =============================================================
# TITLE PAGE (SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 65 ---"
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
    BorderLine "  \"Nearly thirty years have past since Rivek Thalroppe had made his"
    BorderLine "  flight. Dave had grown older, which goes without saying; One of Dave's"
    BorderLine "  eyes was dying out on him, so Dave was partially blind; Dave could fly"
    BorderLine "  but only for short durations since his body was not able to withstand"
    BorderLine "  hard weather; and one of Dave's legs had to be amputated, because"
    BorderLine "  surgery was not able to bind the bones together. Even with all these"
    BorderLine "  factors, Dave kept strong. Dave smiled, provided lectures, and gave"
    BorderLine "  practical guidance and tips to new recruits... When they came. For"
    BorderLine "  nearly thirty years since Dave's flight, the number of recruits had"
    BorderLine "  actually decreased. There weren't that many deliveries. Their services"
    BorderLine "  were utilized a quarter of the time annually, rather than every"
    BorderLine "  quarter of the month per month. Even so, cancellations were much more"
    BorderLine "  common, and accounted for a significant bunch of the income. It simply"
    BorderLine "  was not feasible."
    BorderLine ""
    BorderLine "  \"Thalroppe looked at the pictures in his office. He wondered if there"
    BorderLine "  was any way he could do one more order. Dave had been discussing it"
    BorderLine "  with the board. Whilst Dave's suggestion had been respected and had"
    BorderLine "  helped keep the company afloat, both knew that there had been concerns"
    BorderLine "  to be considered."
    BorderLine ""
    BorderLine "  \"Dave had shown fervent dedication to this cause; if anything, he"
    BorderLine "  would use the legend built from his legacy as a platform to train new"
    BorderLine "  recruits, spread the network further, make sure that a feedback loop"
    BorderLine "  was in place... He used his own fame to expand an institution, because"
    BorderLine "  he believed in the cause. Eagle saw all this effort, and also took"
    BorderLine "  note that Dave did everything by the books. Here began the first of"
    BorderLine "  many interactions between Dave and Eagle. Now, nearly thirty years"
    BorderLine "  later, a letter in hand and with a different tenor, Dave requested the"
    BorderLine "  board to let him finish his service by completing one final delivery."
    BorderLine ""
    BorderLine "  \"The board reviewed the details. The client had been the first to test"
    BorderLine "  Dave's mettle. Since then, a lot had happened which was important"
    BorderLine "  (subjectively speaking). He requested Dave to take the order, because"
    BorderLine "  he knew only Dave could be entrusted with it. The board read through"
    BorderLine "  the directions but were wondering if Dave could pinpoint the actual"
    BorderLine "  location on the map. Dave did as he was asked, and after pointing the"
    BorderLine "  location, the board understood why Dave wanted it to be his final"
    BorderLine "  delivery. They told Dave: 'He gave you two weeks; we'll let you know"
    BorderLine "  well in advance'"
    BorderLine ""
    BorderLine "  \"Four days later, an official letter published on a red page, and"
    BorderLine "  signed by all present in the board in golden ink, gave Dave the"
    BorderLine "  answer: 'He is allowed to make the delivery. May the winds be in his"
    BorderLine "  favor, and by his side' to which Dave, nodding prepared for this final"
    BorderLine "  journey.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 66, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_66.ps1"; exit }
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
