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
    $pad = [Math]::Max(0, [Math]::Floor(($width - $text.Length) / 2))
    return (' ' * $pad) + $t
}

function TypeWriterSlow {
    param([string]$t, [double]$delay = 0.6)
    foreach ($c in $t.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds ($delay * 1000)
    }
    Write-Host ""
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

function BorderTop     { Write-Host "|-------------------------------------------------------------------------------------\" }
function BorderBottom  { Write-Host "|-------------------------------------------------------------------------------------/" }
function BorderLine    { param([string]$t) ; Write-Host ("| " + ("{0,-83}" -f $t) + " |") }

# =============================================================
# PATHS
# =============================================================
$ScriptDir   = Split-Path -Parent $PSCommandPath
$ProjectRoot = Split-Path -Parent $ScriptDir

# =============================================================
# CONFIG
# =============================================================
$PageNumber = 58
$AllowSkip  = $true   # ✅ Page 58 IS skippable

# =============================================================
# TITLE PAGE (SLOW TYPEWRITER)
# =============================================================
function Show-TitlePage {

    Clear-Host
    FillCreamBackground
    Write-Host ""
    Write-Host ""

    $title = Center "--- Page 58 ---"
    Write-Host -NoNewline $BLUE
    TypeWriterSlow $title 0.6
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
    BorderLine "One of the letters was from Punbell, something which neither took him by"
    BorderLine "surprise, nor did it seem to be something he had prior knowledge about."
    BorderLine "He decided that , as the sole proprietor and legal owner of the deposit"
    BorderLine "box, he will make a copy of the letter and read it - it might as well be"
    BorderLine "over and done with. He opened the letter and perused its contents."
    BorderLine ""
    BorderLine "\"I heard the rustling of the last autumn leaves, calmly guiding"
    BorderLine "blackbirds to hail and proceed with the procession. For every footstep"
    BorderLine "came tears from the sky; for every prayer was the ash and dust returned"
    BorderLine "to its rightful owner. Yet on whose behalf it was done, was nowhere to"
    BorderLine "be seen."
    BorderLine ""
    BorderLine "\"It is only sorrow which is described, my son. Yet what of anxiety? What"
    BorderLine "of fear, if the world you know so acutely, so profoundly, that you could"
    BorderLine "breathe every moment without a second thought... If such a world ceases"
    BorderLine "to be, then what will the world be like? What of hope, my son - the"
    BorderLine "challenge of rising up to the occasion could either be a traumatizing"
    BorderLine "one, or an invigorating one. I see all of these in you. I see, in your"
    BorderLine "quiet demeanor, in your calm consideration of where you are and where"
    BorderLine "you will yourself be... I see, and I believe it to be true, a human"
    BorderLine "being truly realized."
    BorderLine ""
    BorderLine "\"Heed my advice, do not weep as the blackbirds fly away; 'do not let the"
    BorderLine "procession of the Birtash be spoilt by despair; for he made his choice"
    BorderLine "to go gently into that good night.' I fondly remember that you loved"
    BorderLine "that quote. I believe that it was from \"Sermons of the Mirtash\", a"
    BorderLine "history book with gorgeous illustrations which you would look at for"
    BorderLine "hours on end. You simply never got enough of it. And when you went to"
    BorderLine "the Birtash and saw all the processions, you were all those emotions:"
    BorderLine "overwhelmed with joy, grief, ecstasy, sorrow, anxiety, hope, anger,"
    BorderLine "excitement... You were alive, and it made me happy to see you grow."
    BorderLine ""
    BorderLine "\"My son, I love you. And if circumstances had been different I would"
    BorderLine "have tried my hardest to be there for you in your time of need. But alas"
    BorderLine "my son, I must apologize. The blackbirds call out my name... I must walk"
    BorderLine "into the good night, and acknowledge the tears. It is time... I hope, I"
    BorderLine "pray,that when we meet again, it will be in happier circumstances.\""
    BorderLine ""
    BorderLine ""
    BorderBottom

    Write-Host ""
    Write-Host (Center "Continue to Page 59, press any key")
    Write-Host ""
    Write-Host (Center "To go back to the main menu, press [m]")
    Write-Host (Center "To quit, press [q]")
    Write-Host ""

    $next = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    switch ($next) {
        'm' { & "$ProjectRoot/main_menu.ps1"; exit }
        'q' { exit }
        default { & "$ScriptDir/page_59.ps1"; exit }
    }
}

# =============================================================
# MAIN
# =============================================================
$result = Show-TitlePage
if ($result -ne "skip") {
    Start-Sleep -Milliseconds 300
}
Show-TextPage
