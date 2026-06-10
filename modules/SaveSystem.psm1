# SaveSystem.psm1
# Den här modulen sparar, laddar och återställer spelets resultat i JSON.

function Get-DefaultSavePath {
    # PSScriptRoot är modules-mappen. Projektroten ligger en nivå upp.
    $projectRoot = Split-Path -Path $PSScriptRoot -Parent
    return Join-Path -Path $projectRoot -ChildPath "data\savegame.json"
}

function Get-DefaultScoreboardPath {
    # Scoreboard sparar flera färdiga resultat, ett objekt per spelomgång.
    $projectRoot = Split-Path -Path $PSScriptRoot -Parent
    return Join-Path -Path $projectRoot -ChildPath "data\scoreboard.json"
}

function New-DefaultSaveData {
    # Ett tomt resultat innan spelaren har klarat ransomware-provet.
    return [PSCustomObject]@{
        playerName         = ""
        startTime          = $null
        endTime            = $null
        actualSeconds      = 0
        wrongAnswers       = 0
        penaltySeconds     = 0
        totalSeconds       = 0
        completedQuestions = 0
        lastSaved          = ""
    }
}

function Initialize-Scoreboard {
    param(
        [string]$Path = (Get-DefaultScoreboardPath)
    )

    try {
        $folder = Split-Path -Path $Path -Parent

        if (-not (Test-Path -Path $folder -PathType Container)) {
            New-Item -Path $folder -ItemType Directory -Force -ErrorAction Stop | Out-Null
        }

        if (-not (Test-Path -Path $Path -PathType Leaf)) {
            Set-Content -Path $Path -Value "[]" -Encoding UTF8 -ErrorAction Stop
        }

        $json = Get-Content -Path $Path -Raw -ErrorAction Stop

        if ([string]::IsNullOrWhiteSpace($json)) {
            Set-Content -Path $Path -Value "[]" -Encoding UTF8 -ErrorAction Stop
        }

        return $Path
    }
    catch {
        throw "Kunde inte skapa scoreboard '$Path'. $($_.Exception.Message)"
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

function Load-Scoreboard {
    param(
        [string]$Path = (Get-DefaultScoreboardPath)
    )

    try {
        Initialize-Scoreboard -Path $Path | Out-Null

        $json = Get-Content -Path $Path -Raw -ErrorAction Stop

        if ([string]::IsNullOrWhiteSpace($json)) {
            return @()
        }

        $scoreboard = $json | ConvertFrom-Json -ErrorAction Stop

        if ($null -eq $scoreboard) {
            return @()
        }

        return @($scoreboard)
    }
    catch {
        Write-Host "Scoreboard kunde inte läsas. En ny tom scoreboard skapas." -ForegroundColor Yellow
        try {
            Set-Content -Path $Path -Value "[]" -Encoding UTF8 -ErrorAction Stop
            return @()
        }
        catch {
            throw "Kunde inte återställa scoreboard '$Path'. $($_.Exception.Message)"
        }
    }
}

function Save-ScoreboardResult {
    param(
        [Parameter(Mandatory)]
        [object]$GameState,

        [string]$Path = (Get-DefaultScoreboardPath)
    )

    try {
        $scoreboard = @(Load-Scoreboard -Path $Path)

        $result = [PSCustomObject]@{
            playerName        = [string]$GameState.playerName
            completedAt       = (Get-Date).ToString("s")
            actualTimeSeconds = [int]$GameState.actualSeconds
            wrongAnswers      = [int]$GameState.wrongAnswers
            penaltySeconds    = [int]$GameState.penaltySeconds
            totalTimeSeconds  = [int]$GameState.totalSeconds
        }

        $scoreboard += $result
        $json = ConvertTo-Json -InputObject $scoreboard -Depth 10 -ErrorAction Stop

        Set-Content -Path $Path -Value $json -Encoding UTF8 -ErrorAction Stop
        return $result
    }
    catch {
        throw "Kunde inte spara resultatet i scoreboard. $($_.Exception.Message)"
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

Export-ModuleMember -Function Save-Game, Load-Game, Test-SaveFileExists, Reset-SaveGame, Initialize-Scoreboard, Load-Scoreboard, Save-ScoreboardResult -Alias Get-GameSave, Reset-GameSave
