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

    for ($i = 0; $i -lt $rows; $i++) {
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
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
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

function BorderTop { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine {
    param([string]$text)
    Write-Host ("| " + ("{0,-83}" -f $text) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir  = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# Page settings
$PageNumber = 3
$AllowSkip = $true   # Page 03 allows skipping title

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 03 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
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

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
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
    BorderLine "he sat on the bed, taking in the view. He had brought with him his"
    BorderLine "briefcase, a backpack and a box handed to him by the hotel, by the"
    BorderLine "bellboy some time back, and had placed it on the suitcase table. He took"
    BorderLine "the box from the suitcase table and tossed it on the bed. He had not"
    BorderLine "given it much thought, nor had he unpacked his things yet. His"
    BorderLine "disposition, his demeanor, his thoughts, were calm. \"Plenty of time to"
    BorderLine "use, and yet no time at all\" was written on the caption of one of the"
    BorderLine "paintings hanging in the room. It was just above the study-table, on"
    BorderLine "which was placed a vanilla colored envelope, an empty set of paper"
    BorderLine "sheets, a pencil, a bowl with complimentary erasers, another bowl with"
    BorderLine "complementary sharpeners, a laminated paper on which was, in bold,"
    BorderLine "written."
    BorderLine ""
    BorderLine "\"ERASERS AND SHARPNERS WILL BE PROVIDED UPON REQUEST: CONSERVE WATER."
    BorderLine "YOU SPILL IT, WE BILL IT!\""
    BorderLine ""
    BorderLine "\"Why bill the water when there is a lake nearby?\" he thought, as he got"
    BorderLine "up to check the drawers of the study desk. He found a notepad with the"
    BorderLine "same number as the serial code on the box. the telephone was placed by"
    BorderLine "his bedside; a brief conversation ensued, after which he put the notepad"
    BorderLine "in his pocket. His jacket already had a pen in it; just in case he also"
    BorderLine "took a pencil, some erasers, and a sharpener. He opened his briefcase"
    BorderLine "and put a few articles on the bed. These included a map, which he"
    BorderLine "crumbled and put in the trash bin; a few flyers, which he discarded; a"
    BorderLine "mini review which had been littered with red ink, from which he kept the"
    BorderLine "third page and discarded the other five."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 4, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch ($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_04.ps1"; exit }
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
