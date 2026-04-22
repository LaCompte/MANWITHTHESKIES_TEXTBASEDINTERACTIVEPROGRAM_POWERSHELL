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

# SPLIT BORDERS
function SplitTop    { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom { Write-Host "|---------------------------------------------||--------------------------------/" }
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
$PageNumber = 71
$AllowSkip  = $false   # NON-SKIPPABLE — choice page

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 71 ---"
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

    # FIRST SPLIT BLOCK
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He closed his eyes. The sound of" ""
    SplitLine "the waves was prominent, but calming." ""
    SplitLine "It was the only sound that could be" ""
    SplitLine "heard. That was fine: there was" ""
    SplitLine "nothing that came to mind as he" ""
    SplitLine "thought about many things. Some" ""
    SplitLine "seemed to be more specific than" ""
    SplitLine "others." ""
    SplitLine "" ""
    SplitLine "He thought about his time in the" ""
    SplitLine "library. He could only remember the" ""
    SplitLine "moments when his parents would drop" ""
    SplitLine "him, or when they would pick him" ""
    SplitLine "when he was done with work. He kept" ""
    SplitLine "on pondering, wondering why he" ""
    SplitLine "couldn't remember his home, or what" ""
    SplitLine "happened afterwards to warrant the" ""
    SplitLine "letters from both Punbell and his" ""
    SplitLine "father. He still had the invitation" ""
    SplitLine "from Punbell, something which" ""
    SplitLine "Laraiez advised on and provided" ""
    SplitLine "his support. He thought of Elias" ""
    SplitLine "and wondered when was the last time" ""
    SplitLine "he met the shopkeeper. All the" ""
    SplitLine "memories were from either when he" ""
    SplitLine "was young, or when he came back." "[1] Accept the invite."
    SplitLine "`"What happened in the middle?`" he" "[2] Find the truth."
    SplitLine "asked himself." "[3] The truth. Be free."
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

    # SECOND SPLIT BLOCK
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "It was more of an afterthought. He" ""
    SplitLine "continued to ponder upon the matter," ""
    SplitLine "and wound up being awoken by Bardia" ""
    SplitLine "`"I think it is getting late, we" ""
    SplitLine "should go`" Bardia requested him." ""
    SplitLine "" ""
    SplitLine "He got up and folded both mats," ""
    SplitLine "after having the sand removed. Both" ""
    SplitLine "of them got to the entrance of the" ""
    SplitLine "beach, wore their shoes, and walked" ""
    SplitLine "to the road. `"Do you have a place" ""
    SplitLine "in mind?`" Bardia asked him. To" ""
    SplitLine "which he nodded, and walked silently." ""
    SplitLine "They continued to walk until they" ""
    SplitLine "reached a crossroad. Instead of" ""
    SplitLine "taking any turn, he continued to" ""
    SplitLine "walk straight until he reached a" ""
    SplitLine "place marked `"The Short Straw`". `"It" ""
    SplitLine "is quite a shortcut`" he thought and" ""
    SplitLine "made his way through the building" ""
    SplitLine "to the marketplace. He walked over" ""
    SplitLine "to Elias." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 72, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_72.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
