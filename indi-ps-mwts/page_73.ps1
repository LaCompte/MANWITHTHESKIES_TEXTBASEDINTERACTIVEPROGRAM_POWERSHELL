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

function BorderTop    { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom { Write-Host "|-------------------------------------------------------------------------------------/" }
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
# CONFIG
# =============================================================
$PageNumber = 73
$AllowSkip  = $true   # Page 73 is skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 73 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $title 0.02
    Write-Host $RESET

    FadeIn (Center "______________________") $BLACK

    Write-Host ""
    Write-Host (Center "Press any key to begin")

    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }

    Write-Host ""
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
    BorderLine "Elias went to the checkout counter and made a cup of tea. `"Would you"
    BorderLine "like some?`" Elias asked Bardia. Bardia gave a look of wonder, and he"
    BorderLine "patted Bardia on the shoulder, nodding. He showed two fingers to answer"
    BorderLine "for himself and Bardia. Elias put the water in the kettle, and prepared"
    BorderLine "the cups accordingly. He took the cup from Elias and handed it to Bardia."
    BorderLine "Bardia looked at the saucer for a prolonged duration, fascinating by the"
    BorderLine "design and the picture in it."
    BorderLine ""
    BorderLine "Elias took note of this observation. `"You have never been to the"
    BorderLine "Birtash, have you?`" Elias asked Bardia. Bardia looked at him, wondered"
    BorderLine "at the question, and responded with a shaking head. Elias drank his tea"
    BorderLine "in silence, and would occasionally glance at Bardia. There was a"
    BorderLine "shopkeeper curiosity in his eyes as he wondered about the response"
    BorderLine "Bardia had provided. Elias hummed, put the cup down, and went to the"
    BorderLine "back of the room. Elias came back with a plate of Yiveliz. Bardia,"
    BorderLine "clearly ecstatic and excited, but trying to keep his calm composed self,"
    BorderLine "smiled at seeing the Yiveliz. Bardia noticed that Elias was not looking"
    BorderLine "and, thinking it was an opportunity, decided to take a Yiveliz. Elias"
    BorderLine "hid his smile behind his cup."
    BorderLine ""
    BorderLine "When Bardia completely finished the Yiveliz, Elias asked Bardia: `"Have"
    BorderLine "you ever been to the Birtash?`" Bardia looked at Elias and answered the"
    BorderLine "question. Elias sighed and commented: `"That was a long time back... really"
    BorderLine "does seem like an age has passed by`". He nodded at Elias' comment, and"
    BorderLine "looked at Bardia. Bardia was completely clueless about the implication"
    BorderLine "of the comment, but nodded more out of sympathy and to remain a part of"
    BorderLine "the conversation."
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 74, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_74.ps1"; exit }
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
