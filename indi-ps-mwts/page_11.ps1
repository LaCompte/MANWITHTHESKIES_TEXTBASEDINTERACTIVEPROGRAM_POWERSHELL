#!/usr/bin/env pwsh

# =============================================================
# COLORS + BACKGROUND
# =============================================================
$BLACK = "`e[38;2;0;0;0m"
$BLUE  = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

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
# UI HELPERS
# =============================================================
function Center {
    param([string]$text)
    $width = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)
    foreach ($c in $text.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

function FadeIn {
    param([string]$text, [string]$color)
    Write-Host "`e[2m$color$text$RESET"
    Start-Sleep -Seconds 2
    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep -Seconds 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

# Borders
function SplitTop     { Write-Host "|---------------------------------------------||-------------------------\" }
function SplitBottom  { Write-Host "|---------------------------------------------||-------------------------/" }
function SplitLine {
    param([string]$left, [string]$right)
    Write-Host ("| {0,-45} ||  {1,-25} |" -f $left, $right)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 11
$AllowSkip  = $false   # ✅ NON-SKIPPABLE

# =============================================================
# TITLE PAGE — NO SKIP
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 11 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host ""
    Write-Host (Center "Press any key to begin")
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    # No skip option — ignore 's'
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { return }
    }
}

# =============================================================
# TEXT PAGE WITH CHOICES
# =============================================================
function Show-TextPage {

    # FIRST HALF
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He squinted for a while, as his path" ""
    SplitLine "became somewhat blurry. The beach and" ""
    SplitLine "the sound of the waves however, marked" ""
    SplitLine "his being in the right direction." ""
    SplitLine "They were neither loud nor were they" ""
    SplitLine "in any way dimming. It was a curving," ""
    SplitLine "flat, vague road which led somewhere." ""
    SplitLine "He felt he was making progress, since" ""
    SplitLine "he could now feel the scent - \"smell" ""
    SplitLine "is as much a sense as every other.\"" ""
    SplitLine "of sandwiches being served. They had" ""
    SplitLine "the air of home to them. Even though" ""
    SplitLine "these sandwiches were home baked and" ""
    SplitLine "cooked since it was a picnic. \"Food" ""
    SplitLine "for thought\" he thought to himself," ""
    SplitLine "finding that the path started making" ""
    SplitLine "an upward trajectory." ""
    SplitLine "" ""
    SplitLine "There was a sound of a bell slowly" "[1] The bell. Familiar."
    SplitLine "resonating from a distance. The sound" ""
    SplitLine "of laughter, arguments, as well as" "[2] He follows it."
    SplitLine "mischief could be faintly heard from" "    He is not sure why."
    SplitLine "the background as well. He kept" ""
    SplitLine "walking, finding the draft had left" "[3] He walks toward it."
    SplitLine "allowing him to open his jacket again." "    It is simply there."
    SplitLine "" ""
    SplitBottom

    # Choice Input
    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($choice) {
        '1' { }  
        '2' { }
        '3' { }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            # Loop back to the same page for invalid input
            & $PSCommandPath
            exit
        }
    }

    # SECOND HALF
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He moved in the direction of the sound." ""
    SplitLine "The road came to a stop, with a wall" ""
    SplitLine "blocking a forward path. He looked" ""
    SplitLine "left and right. He decided to move" ""
    SplitLine "left. He kept going straight. He took" ""
    SplitLine "the turning when the wall turned. He" ""
    SplitLine "found a back-gate which he observed" ""
    SplitLine "carefully. He retraced his steps and" ""
    SplitLine "walked in the opposite direction. He" ""
    SplitLine "took the turn after some time. He was" ""
    SplitLine "greeted by the sight of a grand" ""
    SplitLine "entrance. The gate was open, with a" ""
    SplitLine "cemented path leading to the school." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 12, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_12.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
