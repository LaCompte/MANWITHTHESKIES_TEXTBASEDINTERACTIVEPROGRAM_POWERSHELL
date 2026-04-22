#!/usr/bin/env pwsh

# ─────────────────────────────────────────────────────────────
# COLORS (Black Text on Cream Background)
# ─────────────────────────────────────────────────────────────
$BLACK = "`e[38;2;0;0;0m"
$LIGHTISHBLUE = "`e[38;2;0;200;255m"   # Matches your Bash light-blue tone
$RESET = "`e[0m"

# ─────────────────────────────────────────────────────────────
# FULL SCREEN CREAM BACKGROUND (RGB 255,253,208)
# ─────────────────────────────────────────────────────────────
function FillCreamBackground {
    $rows = $Host.UI.RawUI.WindowSize.Height
    $cols = $Host.UI.RawUI.WindowSize.Width

    $cream = "`e[48;2;255;253;208m`e[38;2;0;0;0m"  # Cream background + black text
    $reset = "`e[0m"

    for ($i = 0; $i -lt $rows; $i++) {
        Write-Host ($cream + (" " * $cols) + $reset)
    }

    # Move cursor to top-left
    Write-Host "`e[H"
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
# FADE-IN (Dim → Normal → Bold)
# ─────────────────────────────────────────────────────────────
function FadeIn {
    param(
        [string]$text,
        [string]$color
    )

    # Dim
    Write-Host "`e[2m$color$text$RESET"
    Start-Sleep -Seconds 2
    Write-Host "`e[H"  # move cursor up
    Write-Host "`e[0m$color$text$RESET"
    Start-Sleep -Seconds 1
    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

# ─────────────────────────────────────────────────────────────
# CENTER TEXT
# ─────────────────────────────────────────────────────────────
function Center {
    param([string]$text)

    $width = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

# ─────────────────────────────────────────────────────────────
# MAIN MENU
# ─────────────────────────────────────────────────────────────

# Paths
$ScriptDir = Split-Path -Parent $PSCommandPath
$IndiDir   = "$ScriptDir/indi-ps-mwts"

while ($true) {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $title = Center "Man with the Skies"
    Write-Host $LIGHTISHBLUE -NoNewline
    TypeWriter $title 0.04
    Write-Host $RESET

    $underline = Center "______________________"
    FadeIn $underline $BLACK

    Write-Host ""
    Write-Host ""

    Write-Host (Center "You ever heard about the Man With the Skies?:")
    Write-Host ""
    Write-Host (Center "[1]  No, I have not")
    Write-Host (Center "[2]  ... I have heard about him...")
    Write-Host (Center "[a]  Additional Content")
    Write-Host ""
    Write-Host (Center "[q]  Quit")
    Write-Host ""

    # Read one key silently
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
        '1' {
            & "$IndiDir/page_01.ps1"
            exit
        }
        '2' {
            & "$IndiDir/chapter_select.ps1"
            exit
        }
        'a' {
            & "$IndiDir/additional_content.ps1"
            exit
        }
    
        'q' { exit }
        'Q' { exit }
        default { }
    }
}
