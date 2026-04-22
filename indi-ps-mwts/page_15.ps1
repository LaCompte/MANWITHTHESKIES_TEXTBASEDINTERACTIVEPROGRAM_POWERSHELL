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
        Write-Host ($cream + (" " * $cols) + $RESET)
    }
    Write-Host "`e[H"
}

# =============================================================
# UI HELPERS
# =============================================================
function Center {
    param([string]$text)
    $width = $Host.UI.RawUI.WindowSize.Width
    $pad   = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
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

function SplitTop    { Write-Host "|---------------------------------------------||--------------------------------\" }
function SplitBottom { Write-Host "|---------------------------------------------||--------------------------------/" }
function SplitLine {
    param([string]$left, [string]$right)
    Write-Host ("| {0,-45} ||  {1,-29} |" -f $left, $right)
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 15
$AllowSkip  = $false   # NON-SKIPPABLE — choice page

# =============================================================
# TITLE PAGE — NO SKIP
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 15 ---"
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

    # FIRST SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He walked into the hallway, noting" ""
    SplitLine "the various sounds being made as he" ""
    SplitLine "walked in the direction of his locker." ""
    SplitLine "He just knew that sounds were being" ""
    SplitLine "made, and then just carried forward" ""
    SplitLine "to his purpose. `"Would it make sense" ""
    SplitLine "for water to be made the way it is?`"" ""
    SplitLine "he asked himself, as he opened his" ""
    SplitLine "locker and put his things inside." ""
    SplitLine "He walked downstairs to the entrance" ""
    SplitLine "and waited on one of the seats." ""
    SplitLine "His father had informed him that he" ""
    SplitLine "will be picked up some time before" ""
    SplitLine "lunch. He waited, neither eager nor" ""
    SplitLine "worried, neither fearful nor ecstatic." ""
    SplitLine "He simply thought of it as one more" ""
    SplitLine "activity to mark the end of the day." ""
    SplitLine "" ""
    SplitLine "The child observed what was around" "[1] Not the school, no."
    SplitLine "him, as he sat on the seat, waiting" "[2] The time. Not once."
    SplitLine "for his father..." "[3] The day. Not once."
    SplitLine "" ""
    SplitBottom

    # CHOICE INPUT
    $choice = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($choice) {
        '1' { }
        '2' { }
        '3' { }
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default {
            & $PSCommandPath
            exit
        }
    }

    # SECOND SECTION
    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    SplitTop
    SplitLine "He had been looking carefully at the" ""
    SplitLine "project, once more wondering about" ""
    SplitLine "it. He left the room and took the" ""
    SplitLine "flight of stairs downwards. When he" ""
    SplitLine "reached the ground floor he walked" ""
    SplitLine "right and kept going straight. There" ""
    SplitLine "were a few labs to his left and right," ""
    SplitLine "where people would have been working," ""
    SplitLine "yet it seemed as if only students" ""
    SplitLine "were busy inside. He kept continuing" ""
    SplitLine "straight, and took little heed of" ""
    SplitLine "the noisy library, and the quiet room" ""
    SplitLine "marked `"debate club`". After a walk" ""
    SplitLine "which seemed like an eternity but" ""
    SplitLine "was practically a simple stroll, he" ""
    SplitLine "saw the office of the Qin. He knocked" ""
    SplitLine "on the door, and waited." ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 16, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_16.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
Show-TitlePage
Show-TextPage
