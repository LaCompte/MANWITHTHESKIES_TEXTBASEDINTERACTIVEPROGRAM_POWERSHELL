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
$PageNumber = 59
$AllowSkip  = $true   # ✅ Page 59 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 59 ---"
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
    BorderLine "He finished reading the letter, and looked at the reference sheet"
    BorderLine "associated with it. He made some notes, and put the letter and its"
    BorderLine "relevant documents back into their folder. He took out another set of"
    BorderLine "files and read them. There were details which he took note of, but did"
    BorderLine "not give much attention. \"Mr. Bez had too much free time. It was"
    BorderLine "inevitable that he had to go\" he deduced, introspecting the picture. He"
    BorderLine "had noticed a flyer was amongst the files; he looked at it, and took"
    BorderLine "note of the fine writing that had been provided on one side of the"
    BorderLine "document. \"I think it is time that I visit the flower-shop. It would"
    BorderLine "make her happy\" he noted, putting the flyer in his pocket. He filed some"
    BorderLine "documents highlighting this action."
    BorderLine ""
    BorderLine "A few more documents were perused as he made his points known... To his"
    BorderLine "notepad. One highlight which had caught his attention was a letter from"
    BorderLine "Punbell. It was brief, barely a letter in content. It felt like a memo"
    BorderLine "to him, although that was wrestling with pedantries. What had made it"
    BorderLine "catch his attention was the following paragraph\""
    BorderLine ""
    BorderLine "  \"I consider myself a lonely man. My solace is found only in books. My"
    BorderLine "  comfort in the library is matched by my apprehension of people."
    BorderLine "  Nevertheless, I consider myself still possessing a glimmer of"
    BorderLine "  humanity. When the blackbirds sang at the break of dawn. I chose to"
    BorderLine "  offer you a place amongst my friends, of my own volition. A choice for"
    BorderLine "  me, but an invitation extended, and open, to you. Whenever you seek to"
    BorderLine "  consider it and inevitably accept it, you know where to find me.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 60, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_60.ps1"; exit }
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
