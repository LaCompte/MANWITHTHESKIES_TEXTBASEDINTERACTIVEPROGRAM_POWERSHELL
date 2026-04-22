#!/usr/bin/env pwsh

# ─────────────────────────────────────────────────────────────
# COLORS (Black Text on Cream Background)
# ─────────────────────────────────────────────────────────────
$BLACK = "`e[38;2;0;0;0m"
$LIGHTISHBLUE = "`e[38;2;0;200;255m"
$RESET = "`e[0m"

# ─────────────────────────────────────────────────────────────
# FULL SCREEN CREAM BACKGROUND (RGB 255,253,208)
# ─────────────────────────────────────────────────────────────
function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width

    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"
    $reset = "`e[0m"

    for ($i = 0; $i -lt $rows; $i++) {
        Write-Host ($cream + (" " * $cols) + $reset)
    }

    Write-Host "`e[H"   # reset cursor to top-left
}

# ─────────────────────────────────────────────────────────────
# TYPEWRITER
# ─────────────────────────────────────────────────────────────
function TypeWriter {
    param(
        [string]$text,
        [double]$delay = 0.02
    )

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline "$char"
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

# ─────────────────────────────────────────────────────────────
# FADE-IN
# ─────────────────────────────────────────────────────────────
function FadeIn {
    param([string]$text)
    Write-Host "`e[2m$BLACK$text$RESET"
}

# ─────────────────────────────────────────────────────────────
# CENTERING
# ─────────────────────────────────────────────────────────────
function Center {
    param([string]$text)
    $width = 70
    $pad = [Math]::Floor(($width - $text.Length) / 2)
    return (" " * $pad) + $text
}

function CenterGrey {
    param([string]$text)
    $width = 70
    $pad = [Math]::Floor(($width - $text.Length) / 2)
    Write-Host "$BLACK$(" " * $pad)$text$RESET"
}

# ─────────────────────────────────────────────────────────────
# PATHS
# ─────────────────────────────────────────────────────────────
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# ─────────────────────────────────────────────────────────────
# PAGE LIST (Columns)
# ─────────────────────────────────────────────────────────────
$col1 = @( 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23)
$col2 = @(24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46)
$col3 = @(47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69)
$col4 = @(70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 89, 90, 91, 92)

# ─────────────────────────────────────────────────────────────
# SHOW MENU
# ─────────────────────────────────────────────────────────────
function ShowMenu {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    Write-Host -NoNewline $LIGHTISHBLUE
    TypeWriter (Center "Pages") 0.04
    Write-Host $RESET

    Write-Host ""
    FadeIn (Center "______________________")
    Write-Host ""
    Write-Host ""

    for ($i = 0; $i -lt 23; $i++) {

        $c1 = $col1[$i]
        $c2 = $col2[$i]
        $c3 = $col3[$i]
        $c4 = $col4[$i]

        $c1d = if ($c1) { "{0:D2}" -f $c1 } else { "  " }
        $c2d = if ($c2) { "{0:D2}" -f $c2 } else { "  " }
        $c3d = if ($c3) { "{0:D2}" -f $c3 } else { "  " }
        $c4d = if ($c4) { "{0:D2}" -f $c4 } else { "  " }

        Write-Host "$BLACK          $c1d          $c2d          $c3d          $c4d$RESET"
    }

    Write-Host ""
    Write-Host ""
    CenterGrey "[m]  Main menu    [q]  Quit"
    Write-Host ""

    Write-Host "$BLACK          Enter a page number and press Return: $RESET" -NoNewline
}

# ─────────────────────────────────────────────────────────────
# PAGE VALIDATION
# ─────────────────────────────────────────────────────────────
function IsValidPage {
    param([string]$n)
    if ($n -match '^\d+$') {
        $num = [int]$n
        if ($num -ge 1 -and $num -le 92 -and $num -ne 88) {
            return $true
        }
    }
    return $false
}

# ─────────────────────────────────────────────────────────────
# MAIN LOOP
# ─────────────────────────────────────────────────────────────
while ($true) {

    ShowMenu
    $input = Read-Host
    $input = $input -replace '\s+', ''

    switch ($input) {

        'm' { Clear-Host; FillCreamBackground; & "$ProjectRoot/main_menu.ps1"; exit }
        'M' { Clear-Host; FillCreamBackground; & "$ProjectRoot/main_menu.ps1"; exit }

        'q' { exit }
        'Q' { exit }

        default {

            if (IsValidPage $input) {

                $padded = "{0:D2}" -f [int]$input
                $target = "$ScriptDir/page_${padded}.ps1"

                if (Test-Path $target) {
                    & $target
                    exit
                }
                else {
                    Clear-Host
                    FillCreamBackground
                    Write-Host ""
                    CenterGrey "Page $padded could not be loaded."
                    CenterGrey "Press any key to return."
                    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
                }
            }
        }
    }
}
