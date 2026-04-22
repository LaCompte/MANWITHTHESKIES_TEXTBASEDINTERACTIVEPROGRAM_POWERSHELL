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
    $pad  = [Math]::Max(0, [Math]::Floor(($cols - $t.Length) / 2))
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
function BorderLine    {
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
$PageNumber = 75
$AllowSkip  = $true   # ✅ Page 75 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 75 ---"
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
    BorderLine "Elias looked at the street, lost in thought. Elias seemed to have"
    BorderLine "something in mind, and after finishing his tea, Elias took out a"
    BorderLine "notebook... and then went to his office from where Elias took out a"
    BorderLine "collections dossier. Elias requested Bardia to take a look, and pointed"
    BorderLine "at a specific page on the dossier. Bardia was fascinated and observed"
    BorderLine "the image for a significant duration. He saw Elias and Bardia in this"
    BorderLine "state and wondered if there was something that was related to any ideas"
    BorderLine "which Bardia had. But he didn't say anything, letting Bardia have the"
    BorderLine "moment."
    BorderLine ""
    BorderLine "After some time, Elias asked Bardia \"Have you been to the Birtash?\" The"
    BorderLine "question was in a very curious, albeit understated tone. Bardia turned"
    BorderLine "and looked at Elias, completely clueless about how to respond back to"
    BorderLine "it. Elias nodded, as if the question had been answered. Elias turned"
    BorderLine "from Bardia to him, and told him \"There's a very funny little"
    BorderLine "arrangement set to happen at Samson Square. You've probably been to the"
    BorderLine "Birtash... Why not give it a look?\""
    BorderLine ""
    BorderLine "He looked at Elias and answered \"Never heard about any such arrangements"
    BorderLine "at Samson. We just came from there.\""
    BorderLine ""
    BorderLine "\"Why did Samson call a circle, a square?\" Bardia interrupted Elias and"
    BorderLine "him. Elias turned to Bardia and responded: \"It is a century old joke."
    BorderLine "The people who remember it are long since dead. Everyone else just roll"
    BorderLine "with it.\" Bardia nodded, somewhat satisfied at the answer, yet not"
    BorderLine "exactly sure what to make of it. He noted the puzzled look on Bardia's"
    BorderLine "face and asked Elias: \"You know anyone who could give any informed"
    BorderLine "stories on Samson? Apart from Punbell?\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 76, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_76.ps1"; exit }
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
