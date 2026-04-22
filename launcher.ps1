Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

$ScriptDir = Split-Path -Parent $PSCommandPath
if (-not $ScriptDir) { $ScriptDir = $PSScriptRoot }

# Set console background colour to cream
$Host.UI.RawUI.BackgroundColor = "Yellow"
$Host.UI.RawUI.ForegroundColor = "Black"
Clear-Host

& "$ScriptDir\main_menu.ps1"
