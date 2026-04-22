#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK  = "`e[38;2;0;0;0m"
$BLUE   = "`e[38;2;0;200;255m"
$RESET  = "`e[0m"

function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width    
    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"
    
    for ($i=0; $i -lt $rows; $i++) {
        Write-Host ($cream + (' ' * $cols) + $RESET)
    }
    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$text)
    $w = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $text
}

function TypeWriter {
    param([string]$t, [double]$delay = 0.02)
    foreach($c in $t.ToCharArray()) {
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

# BORDER HELPERS
function SplitTop     { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom  { Write-Host "|---------------------------------------------||--------------------------------/" }
function SplitLine {
    param($l, $r)
    Write-Host ("| {0,-43} ||  {1,-29} |" -f $l, $r)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE SETTINGS
# =============================================================
$PageNumber = 40
$AllowSkip  = $false   # ✅ Non‑skippable

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $t = Center "--- Page 40 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $t 0.02
    Write-Host $RESET
    
    $line = Center "______________________"
    FadeIn $line $BLACK
    
    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""
    
    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    
    switch($k){
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
    SplitLine "He decided to take a stroll around" ""
    SplitLine "the tents. So far, the tents had" ""
    SplitLine "the usual things he was expecting:" ""
    SplitLine "one tent was selling lizard tails;" ""
    SplitLine "one tent had a rotating circle," ""
    SplitLine "with various colors, and a big bull" ""
    SplitLine "eye in the center; one tent was" ""
    SplitLine "selling books on how to sell books;" ""
    SplitLine "his personal favorite was a tent in" ""
    SplitLine "which was written, at the entrance" ""
    SplitLine "of the door, a specific set of" ""
    SplitLine "numbers and a time set - they" ""
    SplitLine "charged for putting someone inside" ""
    SplitLine "the tent, and leaving them there" ""
    SplitLine "until someone paid to have them" ""
    SplitLine "taken out from the tent. \"Some" ""
    SplitLine "would call it ransom, others call" ""
    SplitLine "it a deposit. We make money\" was" ""
    SplitLine "the slogan of the tent." ""
    SplitLine "" ""
    SplitLine "At the center of the Birtash tents" ""
    SplitLine "were numerous stalls, where some" ""
    SplitLine "people were busy with a lot of" ""
    SplitLine "people, while the rest of the tents" ""
    SplitLine "were having heated discussions about" ""
    SplitLine "what both stall and tents were" ""
    SplitLine "doing. He went over to one stall," ""
    SplitLine "shuddered, and walked over to the" ""
    SplitLine "next stall. It was selling an" ""
    SplitLine "assortment of Yivelis, soup, and a" ""
    SplitLine "grilled beef-box. The sign said" "[1] Where is everybody?"
    SplitLine "\"Hot Rind available here. Wait till" "[2] Free food, anyone?"
    SplitLine "evening to get a free sample!\"" "[3] What is that noise?"
    SplitLine "" ""
    SplitBottom

    # CHOICE INPUT
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
    SplitLine "He walked over to the gathered" ""
    SplitLine "crowd. He could hear someone" ""
    SplitLine "speaking loudly, yet not very clear" ""
    SplitLine "from where he stood. He walked" ""
    SplitLine "forward to the person, and found" ""
    SplitLine "that the person was a performer." ""
    SplitLine "He stood quiet, and listened to" ""
    SplitLine "the performer's work." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 41, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    
    switch($next){
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_41.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
