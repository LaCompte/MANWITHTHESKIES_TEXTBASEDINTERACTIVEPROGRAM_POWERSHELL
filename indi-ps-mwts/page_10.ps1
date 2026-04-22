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
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)
    foreach ($ch in $text.ToCharArray()) {
        Write-Host -NoNewline $ch
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

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$t)
    Write-Host ("| " + ("{0,-83}" -f $t) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# PAGE PROPERTIES
# =============================================================
$PageNumber = 10
$AllowSkip  = $true     # ✅ Page 10 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 10 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
    Write-Host $RESET

    $line = Center "______________________"
    FadeIn $line $BLACK

    Write-Host ""
    Write-Host ""
    Write-Host (Center "Press any key to begin")

    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($k) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        's' { if ($AllowSkip) { return "skip" } }
        default { return "continue" }
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
    BorderLine "He nodded and turned around to leave. \"Happy to be of service\" said"
    BorderLine "Elias, to the sound of the door being opened."
    BorderLine ""
    BorderLine "the fellow looked at the complimentary flowers being offered, noting how"
    BorderLine "they seemed vibrant even in the fog. \"They do catch one's attention\" he"
    BorderLine "noted. He looked at the shop which was a neighbor to Elias, and"
    BorderLine "remembered that it had a paper on the window. He read through all of it;"
    BorderLine "it was a document of some level of importance. After finishing reading,"
    BorderLine "he thought of something and walked out into the main road. Most of the"
    BorderLine "area was as he had left it, although it was noticeably more ambient, the"
    BorderLine "sound of the floorboards creaking, the soft tapping on the windows, and"
    BorderLine "a sound of a music box in the distance were the only sounds which gave"
    BorderLine "him company."
    BorderLine ""
    BorderLine "He whistled to himself, noting that as he headed in the direction of the"
    BorderLine "school, the music box became more noticeable. \"The owner has good"
    BorderLine "taste\". he thought to himself. He could see the boundaries of the"
    BorderLine "institution from where he was standing. On the left there was presumably"
    BorderLine "an empty space, as there was not much to see for quite a distance. As he"
    BorderLine "looked right onward. There were a series of significant buildings,"
    BorderLine "although they could not be identified as to what role they played. He"
    BorderLine "kept looking, and the sound of boys playing games was very faintly"
    BorderLine "audible. the sound of the music box had become noticeably quiet."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 11, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $k2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($k2) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_11.ps1"; exit }
    }
}

# =============================================================
# MAIN EXECUTION
# =============================================================
$result = Show-TitlePage
if ($result -ne "skip") {
    Start-Sleep -Milliseconds 300
}
Show-TextPage
