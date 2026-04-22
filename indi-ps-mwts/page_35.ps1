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

    for ($i=0; $i -lt $rows; $i++){
        Write-Host ($cream + (" " * $cols) + $RESET)
    }

    Write-Host "`e[H"
}

# =============================================================
# HELPERS
# =============================================================
function Center {
    param([string]$text)
    $cols = $Host.UI.RawUI.WindowSize.Width
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (" " * $pad) + $text
}

function TypeWriter {
    param([string]$text, [double]$delay = 0.02)
    foreach ($ch in $text.ToCharArray()){
        Write-Host -NoNewline $ch
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
}

function FadeIn {
    param([string]$text, [string]$color)

    Write-Host "`e[2m$color$text$RESET"
    Start-Sleep 2

    Write-Host "`e[H"
    Write-Host "$color$text$RESET"
    Start-Sleep 1

    Write-Host "`e[H"
    Write-Host "`e[1m$color$text$RESET"
    Write-Host ""
}

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine    {
    param([string]$line)
    Write-Host ("| " + ("{0,-83}" -f $line) + " |")
}

# =============================================================
# PATHS
# =============================================================
$ScriptDir  = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 35
$AllowSkip  = $true   # ✅ Page 35 IS skippable

# =============================================================
# TITLE PAGE
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground

    Write-Host ""
    Write-Host ""

    $header = Center "--- Page 35 ---"
    Write-Host -NoNewline $BLUE
    TypeWriter $header 0.02
    Write-Host $RESET    

    $line = Center "______________________"
    FadeIn $line $BLACK    

    Write-Host ""
    Write-Host (Center "Press any key to begin")
    if ($AllowSkip) {
        Write-Host (Center "To skip the title and go directly to the text, press [s]")
    }
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

    switch($key) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        's' { if ($AllowSkip) { return "skip"} }
        default { return }
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
    BorderLine "\"I never liked insects. They're terrible little things.\" He commented."
    BorderLine ""
    BorderLine "\"Indeed, yet a world without insects is barren, devoid of sustained"
    BorderLine "life\" retorted Laraiez."
    BorderLine ""
    BorderLine "\"These places are notably peaceful, and people there are alive - they"
    BorderLine "have more charisma.\""
    BorderLine ""
    BorderLine "\"Depends on how you define charisma. Are they charming as a result of"
    BorderLine "their environment, or are they charming, despite being in an environment"
    BorderLine "they know is not sustainable?\""
    BorderLine ""
    BorderLine "\"Or they are charming even though they made their environment"
    BorderLine "sustainable for themselves?\""
    BorderLine ""
    BorderLine "Laraiez pondered on this point, and asked him \"You would honestly prefer"
    BorderLine "living in a desert than in agricultural lands, simply because you hate"
    BorderLine "insects?\""
    BorderLine ""
    BorderLine "He thought about Laraiez' question, and kept quiet. He looked at the"
    BorderLine "close upstairs. \"That is an interesting question.\""
    BorderLine ""
    BorderLine "\"Possibly not as interesting as the answer.\""
    BorderLine ""
    BorderLine "He nodded at what Laraiez retorted towards. He shook his head, and"
    BorderLine "looked at Laraiez, saying \"Maybe not... Is there anything about Bardia I"
    BorderLine "should know?\""
    BorderLine ""
    BorderLine "Laraiez threw some breadcrumbs at the ants, humming to himself. He"
    BorderLine "pushed up his glasses, and nodded to something. Laraiez looked at him,"
    BorderLine "and asked, \"What would you say about him?\""
    BorderLine ""
    BorderLine "\"He's not comfortable with the Birtash, and is quiet. But is a good kid."
    BorderLine "Clearly he is a bit shy, with words I mean.\""
    BorderLine ""
    BorderLine "\"Well, yes and no. Yes, he is shy with words and is quiet, but no, if he"
    BorderLine "is a good kid, then he shouldn't cause so much worry as he does.\""
    BorderLine "Laraiez clarified, his analysis being firm yet sincere. Laraiez got up"
    BorderLine "from the bench, scraped the breadcrumbs from his hands, and told him"
    BorderLine "\"You should be present in the office when I call Bardia over. I'm sure"
    BorderLine "he would appreciate the support.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 36, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    
    switch($next){
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_36.ps1"; exit }
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
