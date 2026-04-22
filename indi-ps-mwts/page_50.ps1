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
    for ($i=0; $i -lt $rows; $i++){
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
    foreach($c in $t.ToCharArray()){
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
$PageNumber = 50
$AllowSkip  = $true   # ✅ Page 50 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 50 ---"
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
    switch($k){
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
    BorderLine "Bardia was in a confused state after the conclusion of the story. He"
    BorderLine "looked at Bardia and after waiting some time, informed Bardia \"You can"
    BorderLine "ask me questions regarding Rivek if you want. Seems to me like you don't"
    BorderLine "agree with most of what has been shared.\""
    BorderLine ""
    BorderLine "Bardia, realizing that he could stay quiet no longer, asked him: \"Rivek"
    BorderLine "traveled all the way back to hand over a personal letter? Even though he"
    BorderLine "had informed the eagle that the people wanted to thank the director and"
    BorderLine "the team themselves?\" He nodded at Bardia, and responded \"Yes, that is"
    BorderLine "exactly what he did and exactly what the director was given.\" Bardia"
    BorderLine "looked at the waves in wonder. He quietly looked at the waves and the"
    BorderLine "water with Bardia, busy with his own thoughts and perspectives. Bardia"
    BorderLine "broke the quiet and asked another question: \"Did Rivek have big wings?\""
    BorderLine "He looked at Bardia, puzzled, and answered \"Yes, Rivek had big wings."
    BorderLine "Why do you ask?\" Bardia then responded \"I don't think it makes sense for"
    BorderLine "a stork to have large wings, when the director is an eagle. Eagles are"
    BorderLine "huge...!\" Bardia stretched out his hands to the furthest extent that he"
    BorderLine "could manage, in order to convey the weight of his point."
    BorderLine ""
    BorderLine "He laughed at Bardia's point. It was more of a chuckle rather than a"
    BorderLine "laugh. He looked at Bardia and asked him \"Have you ever seen a stork"
    BorderLine "before?\" To which Bardia just gave a blank stare. He looked at Bardia"
    BorderLine "and wondered if he was being genuine, or was avoiding the answer to the"
    BorderLine "question. Bardia responded. \"I have, yes.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 51, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch($next){
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_51.ps1"; exit }
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
