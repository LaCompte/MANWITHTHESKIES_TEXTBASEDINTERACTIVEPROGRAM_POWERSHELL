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

# SPLIT BORDERS
function SplitTop     { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom  { Write-Host "|---------------------------------------------||--------------------------------/" }
function SplitLine {
    param([string]$L, [string]$R)
    Write-Host ("| {0,-43} ||  {1,-29} |" -f $L, $R)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 60
$AllowSkip  = $false   # ✅ NON‑SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 60 ---"
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

    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { return }
    }
}

# =============================================================
# TEXT PAGE — CHOICE PAGE
# =============================================================
function Show-TextPage {

    #
    # FIRST SPLIT BLOCK
    #
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He looked at the invitation. The" ""
    SplitLine "envelope had not been opened. It" ""
    SplitLine "still gave a scent of fresh postal" ""
    SplitLine "stamps and vanilla envelope glue." ""
    SplitLine "After turning it to and fro," ""
    SplitLine "observing it and noting a few" ""
    SplitLine "details, without opening the" ""
    SplitLine "envelope, he decided to put it in" ""
    SplitLine "the inner lining of his jacket." ""
    SplitLine "He filled in the necessary documents" ""
    SplitLine "that came alongside." ""
    SplitLine "" ""
    SplitLine "He looked further at the documents" ""
    SplitLine "that were remaining. They were" ""
    SplitLine "important but at that particular" ""
    SplitLine "moment they were not especially" ""
    SplitLine "necessary." ""
    SplitLine "" ""
    SplitLine "\"If a man must pick his past, they" ""
    SplitLine "pick the moments which led to" ""
    SplitLine "growth. Even if those moments were" "[1] This is done."
    SplitLine "enough to leave scars, they fuel" "[2] This is fine."
    SplitLine "growth.\"" "[3] This is the way."
    SplitLine "" ""
    SplitBottom

    #
    # CHOICE INPUT
    #
    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($choice) {
        '1' {}
        '2' {}
        '3' {}
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath
            exit
        }
    }

    #
    # SECOND SPLIT BLOCK
    #
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He put the remainder of the" ""
    SplitLine "documents back into the box, making" ""
    SplitLine "sure that all relevant signatures" ""
    SplitLine "and confirmations had been made." ""
    SplitLine "He got up from his seat and walked" ""
    SplitLine "towards the intercom. He pressed" ""
    SplitLine "the button. A series of voices and" ""
    SplitLine "some clangs later, he heard the" ""
    SplitLine "door open. Rinaar stepped in." ""
    SplitLine "" ""
    SplitLine "\"Were you able to fully peruse your" ""
    SplitLine "documents?\"" ""
    SplitLine "\"Yes. I mentioned which documents" ""
    SplitLine "have been taken into account, and" ""
    SplitLine "which have been instructed for" ""
    SplitLine "bank purposes.\"" ""
    SplitLine "\"It seems quite a lot of documents" ""
    SplitLine "to entrust to a bank.\"" ""
    SplitLine "\"A simple interest of memories" ""
    SplitLine "carries a significant weight. With" ""
    SplitLine "time, the profit outweighs the" ""
    SplitLine "burden.\"" ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 61, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_61.ps1"; exit }
    }
}

# =============================================================
# MAIN
# =============================================================
Show-TitlePage
Show-TextPage
