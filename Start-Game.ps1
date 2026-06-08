# Security Escape Room
# Detta är projektets startfil.
# Kör spelet från projektmappen med kommandot: .\Start-Game.ps1

try {
    # $PSScriptRoot pekar på mappen där Start-Game.ps1 ligger.
    # Det gör att spelet kan hitta modulerna även om sökvägen ser olika ut på olika datorer.
    $modulesPath = Join-Path -Path $PSScriptRoot -ChildPath "modules"

    # Importera spelets moduler.
    Import-Module (Join-Path -Path $modulesPath -ChildPath "UI.psm1") -Force -ErrorAction Stop
    Import-Module (Join-Path -Path $modulesPath -ChildPath "SaveSystem.psm1") -Force -ErrorAction Stop
    Import-Module (Join-Path -Path $modulesPath -ChildPath "SecurityChallenges.psm1") -Force -ErrorAction Stop
    Import-Module (Join-Path -Path $modulesPath -ChildPath "GameEngine.psm1") -Force -ErrorAction Stop

    # Starta spelets huvudfunktion.
    Start-SecurityEscapeRoom -ProjectRoot $PSScriptRoot
}
catch {
    Write-Host ""
    Write-Host "Spelet kunde inte startas." -ForegroundColor Red
    Write-Host "Felmeddelande: $($_.Exception.Message)" -ForegroundColor DarkRed
    Write-Host "Kontrollera att alla filer finns i rätt mappar och försök igen." -ForegroundColor Yellow
}
