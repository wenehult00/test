# SaveSystem.psm1
# Den här modulen sparar, laddar och återställer spelets progress i JSON.

function Get-DefaultSavePath {
    # PSScriptRoot är modules-mappen. Projektroten ligger en nivå upp.
    $projectRoot = Split-Path -Path $PSScriptRoot -Parent
    return Join-Path -Path $projectRoot -ChildPath "data\savegame.json"
}

function New-DefaultSaveData {
    # Ett nytt spel börjar i första rummet med 0 poäng.
    return [PSCustomObject]@{
        playerName     = ""
        currentRoom    = 0
        score          = 0
        completedRooms = @()
        lastSaved      = ""
    }
}

function Test-SaveFileExists {
    param(
        [string]$Path = (Get-DefaultSavePath)
    )

    try {
        return Test-Path -Path $Path -PathType Leaf -ErrorAction Stop
    }
    catch {
        Write-Host "Kunde inte kontrollera sparfilen: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Save-Game {
    param(
        [Parameter(Mandatory)]
        [object]$SaveData,

        [string]$Path = (Get-DefaultSavePath)
    )

    try {
        $folder = Split-Path -Path $Path -Parent

        if (-not (Test-Path -Path $folder -PathType Container)) {
            New-Item -Path $folder -ItemType Directory -Force -ErrorAction Stop | Out-Null
        }

        $SaveData.lastSaved = (Get-Date).ToString("s")
        $json = $SaveData | ConvertTo-Json -Depth 10 -ErrorAction Stop

        Set-Content -Path $Path -Value $json -Encoding UTF8 -ErrorAction Stop
    }
    catch [System.UnauthorizedAccessException] {
        throw "Saknar behörighet att skriva till sparfilen '$Path'. Kontrollera filrättigheter."
    }
    catch {
        throw "Kunde inte spara spelet till '$Path'. $($_.Exception.Message)"
    }
}

function Load-Game {
    param(
        [string]$Path = (Get-DefaultSavePath)
    )

    try {
        if (-not (Test-SaveFileExists -Path $Path)) {
            throw "Sparfilen saknas: $Path"
        }

        $json = Get-Content -Path $Path -Raw -ErrorAction Stop

        if ([string]::IsNullOrWhiteSpace($json)) {
            throw "Sparfilen är tom: $Path"
        }

        return $json | ConvertFrom-Json -ErrorAction Stop
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        throw "Sparfilen kunde inte hittas: $Path"
    }
    catch [System.UnauthorizedAccessException] {
        throw "Saknar behörighet att läsa sparfilen '$Path'. Kontrollera filrättigheter."
    }
    catch [System.ArgumentException] {
        throw "Sparfilen innehåller trasig JSON. Återställ sparfilen eller kontrollera syntaxen i '$Path'."
    }
    catch {
        throw "Kunde inte ladda sparfilen. $($_.Exception.Message)"
    }
}

function Reset-SaveGame {
    param(
        [string]$Path = (Get-DefaultSavePath)
    )

    try {
        $defaultSave = New-DefaultSaveData
        Save-Game -SaveData $defaultSave -Path $Path
        return $defaultSave
    }
    catch {
        throw "Kunde inte återställa sparfilen. $($_.Exception.Message)"
    }
}

# Alias behåller stöd för tidigare kod i projektet.
Set-Alias -Name Get-GameSave -Value Load-Game
Set-Alias -Name Reset-GameSave -Value Reset-SaveGame

Export-ModuleMember -Function Save-Game, Load-Game, Test-SaveFileExists, Reset-SaveGame -Alias Get-GameSave, Reset-GameSave
