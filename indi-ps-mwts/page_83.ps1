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
$PageNumber = 83
$AllowSkip  = $false   # ✅ NON‑SKIPPABLE

# =============================================================
# TITLE PAGE (NO SKIP)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 83 ---"
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
    SplitLine "\"You knew about the book and where" ""
    SplitLine "to find it?\"" ""
    SplitLine "\"I did, father. I didn't mean to" ""
    SplitLine "read the portions without your" ""
    SplitLine "permission. I always thought you" ""
    SplitLine "were like Rivek Thalroppe saving" ""
    SplitLine "the world, and bringing joy to" ""
    SplitLine "other families.\"" ""
    SplitLine "The patient laughed, and looked at" "[1] Blackbird singing in"
    SplitLine "Bardia with endless appreciation." "    the dead of night."
    SplitLine "\"I had always found the apparent" ""
    SplitLine "inflection of the book to be..." "[2] These broken wings,"
    SplitLine "suspiciously unintentional curiosity.\"" "    and learn to fly."
    SplitLine "\"Your supposition does hold ground" ""
    SplitLine "now, when considering our general" "[3] All your life."
    SplitLine "presence in the room.\"" ""
    SplitLine "\"Oh yes, the room. I had completely" ""
    SplitLine "forgotten about it. How are the" ""
    SplitLine "birds, my dear boy?\"" ""
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
    SplitLine "Bardia looked at the ceiling and" ""
    SplitLine "the rest of the room, finding" ""
    SplitLine "something that made him uncomfortable," ""
    SplitLine "and it manifested in the answer" ""
    SplitLine "\"Chirper. Than this room. I never" ""
    SplitLine "knew you had only the outside window" ""
    SplitLine "for company. The lack of a window" ""
    SplitLine "is quite distressing.\"" ""
    SplitLine "\"A minor inconvenience\" the patient" ""
    SplitLine "responded in a dry, and avaricious" ""
    SplitLine "tone, and winking at Bardia. They" ""
    SplitLine "looked at each other and laughed," ""
    SplitLine "considering the situation he was in." ""
    SplitLine "Bardia sat next to his bed, and" ""
    SplitLine "held his hand. And it occurred to" ""
    SplitLine "him that he was missing something." ""
    SplitLine "He asked the patient \"do you have" ""
    SplitLine "anything by which I could remember" ""
    SplitLine "you? Anything by which I may carry" ""
    SplitLine "your legacy?\" And the patient" ""
    SplitLine "informed him to discuss the matter" ""
    SplitLine "with Rinaar, at the bank. \"I am so" ""
    SplitLine "grateful for this day. Thank you," ""
    SplitLine "my son. Alas I must rest now." ""
    SplitLine "Perhaps we will continue our" ""
    SplitLine "meeting tomorrow?\"" ""
    SplitLine "" ""
    SplitBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 84, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_84.ps1"; exit }
    }
}

# =============================================================
# MAIN
# =============================================================
$result = Show-TitlePage
Show-TextPage
