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
$PageNumber = 87
$AllowSkip  = $true   # ✅ Page 87 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 87 ---"
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
    BorderLine "Bardia was pulled from the elevator and taken along with another friend"
    BorderLine "to a gathering of people. There was plenty of music, \"street musicians"
    BorderLine "probably from the Birtash making a living\" commented one of the"
    BorderLine "gentlemen. Bardia noticed the snarky tone in which the comment had been"
    BorderLine "made, and said \"They must be good if someone lifted them from the"
    BorderLine "Birtash. If we had done that in the age of the King's, I'm sure somebody"
    BorderLine "would have to grind the axe\" Most of the gentlemen laughed at the"
    BorderLine "profundity of this point of fact, and discussed on those topics."
    BorderLine ""
    BorderLine "\"I'm sure Lady Tabatha must be around. She had an inkling about these"
    BorderLine "pollinating populations\" thought Bardia, as he made his way around the"
    BorderLine "crowd. One of the ladies spotted Bardia and responded by holding his"
    BorderLine "hand and exclaiming 'I am so glad you came. Bardia, have you met Lady"
    BorderLine "Tabitha?' to which Bardia responded, \"I may have seen some of your work"
    BorderLine "in the Birtash. Beautiful arrangements, honestly\" and they shared some"
    BorderLine "polite comments, a quip, and a comment about the lighting. Bardia"
    BorderLine "continued to walk through the crowd and mingled with most of them."
    BorderLine ""
    BorderLine "And near the stroke of midnight, a troupe of performers came who marked"
    BorderLine "the conclusion of Birtash. It was applauded, appreciated, and acclaimed"
    BorderLine "in spirit and form. However, one by one, the crowd started to make its"
    BorderLine "way home. Those who had been residing in the hotel stayed just a while"
    BorderLine "longer until, when all outsiders had left, they too returned to their"
    BorderLine "rooms. \"What a party. Homeiz' father would be proud\" exclaimed one"
    BorderLine "participant."
    BorderLine ""
    BorderLine "\"I don't believe that Homeiz had anything to do with these arrangements\""
    BorderLine "thought Bardia, walking between guests towards the delicacies section."
    BorderLine "He had already made his movement from the entrance of the party which"
    BorderLine "only stood out because of a plaque having the words \"one celebration of"
    BorderLine "twenty years - an anniversary dinner\" and as you walked forward, with"
    BorderLine "the columns on either side marking the depth of the hall, you noticed a"
    BorderLine "raised platform where Bardia had an empty seat reserved for him, from"
    BorderLine "which he would have a raised view of the guests."
    BorderLine ""
    BorderLine "\"Homeiz would have come here if given the opportunity\" he thought to"
    BorderLine "himself, wondering at the absence of a familiar face. He was facing the"
    BorderLine "delicacies table, where an assortment of condiments, salads, and a stew"
    BorderLine "made from sheep and hens were available for the guests. Most of them"
    BorderLine "relished the stew while seated on one of the many seats and round"
    BorderLine "tables, often with friends but sometimes alone. Elias was on one such"
    BorderLine "seat, busying himself with Yiveliz and a cup of tea. As Bardia walked"
    BorderLine "over to him, Elias smiled and spoke nonchalantly \"I seem to be in limbo:"
    BorderLine "this tea did not taste as it does now\" he decided to avoid drinking"
    BorderLine "further and looking at the crowd, merely spoke \"they are gathering"
    BorderLine "forward to hear an arrangement. I suppose we should as well\" and all"
    BorderLine "made their way to the stage."
    BorderLine ""
    BorderLine "Except Bardia. Bardia merely walked and bid his leave as he made his way"
    BorderLine "out of the hotel. He made his way to his car, with coffee in his hand."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 89, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_89.ps1"; exit }
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
