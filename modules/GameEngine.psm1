# GameEngine.psm1
# Spelmotorn styr huvudmeny, timer, tidstillägg och slutresultat.

function New-RansomwareGameState {
    param(
        [Parameter(Mandatory)]
        [string]$PlayerName
    )

    return [PSCustomObject]@{
        playerName         = $PlayerName
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

function Start-SecurityEscapeRoom {
    param(
        [string]$ProjectRoot = (Split-Path -Path $PSScriptRoot -Parent)
    )

    # Wrappern behålls eftersom Start-Game.ps1 och äldre instruktioner kan använda namnet.
    Start-RansomwareEscapeRoom -ProjectRoot $ProjectRoot
}

function Start-RansomwareEscapeRoom {
    param(
        [string]$ProjectRoot = (Split-Path -Path $PSScriptRoot -Parent)
    )

    $savePath = Join-Path -Path $ProjectRoot -ChildPath "data\savegame.json"
    $isRunning = $true

    while ($isRunning) {
        Show-RansomwareIntro

        Show-Menu -Options @(
            "1. Nytt spel",
            "2. Visa scoreboard",
            "3. Avsluta"
        )

        $choice = Read-Host "Välj ett alternativ"

        switch ($choice) {
            "1" {
                Start-NewGame -SavePath $savePath
            }
            "2" {
                Show-ScoreboardMenu
            }
            "3" {
                Show-Message "Du stänger terminalen. Håll dig säker där ute." "Cyan"
                $isRunning = $false
            }
            default {
                Show-FailureMessage "Ogiltigt val. Skriv 1, 2 eller 3."
                Pause-Game
            }
        }
    }
}

function Show-ScoreboardMenu {
    try {
        $results = @(Load-Scoreboard | Sort-Object -Property @{ Expression = { [int]$_.totalTimeSeconds } }, @{ Expression = { [int]$_.wrongAnswers } })
        Show-Scoreboard -Results $results
        Pause-Game
    }
    catch {
        Show-Error "Kunde inte visa scoreboard: $($_.Exception.Message)"
        Pause-Game
    }
}

function Start-NewGame {
    param(
        [Parameter(Mandatory)]
        [string]$SavePath
    )

    try {
        $playerName = Read-Host "Skriv ditt namn"

        if ([string]::IsNullOrWhiteSpace($playerName)) {
            $playerName = "Elev"
        }

        $gameState = New-RansomwareGameState -PlayerName $playerName
        Save-Game -Path $SavePath -SaveData $gameState

        Show-HackerMessage -PlayerName $playerName
        Pause-Game

        $gameState.startTime = Start-RansomwareTimer
        Invoke-RansomwareQuiz -GameState $gameState | Out-Null
        Stop-RansomwareTimer -GameState $gameState
        Show-FinalResult -GameState $gameState -SavePath $SavePath
    }
    catch {
        Show-Error "Kunde inte starta ransomware-spelet: $($_.Exception.Message)"
    }
}

function Start-RansomwareTimer {
    return Get-Date
}

function Stop-RansomwareTimer {
    param(
        [Parameter(Mandatory)]
        [object]$GameState
    )

    $GameState.endTime = Get-Date
    $elapsed = New-TimeSpan -Start $GameState.startTime -End $GameState.endTime
    $GameState.actualSeconds = [int][Math]::Round($elapsed.TotalSeconds)
    $GameState.totalSeconds = $GameState.actualSeconds + $GameState.penaltySeconds
}

function Get-CurrentRansomwareTime {
    param(
        [Parameter(Mandatory)]
        [object]$GameState
    )

    try {
        if ($null -eq $GameState.startTime) {
            return [PSCustomObject]@{
                ActualSeconds  = 0
                PenaltySeconds = [int]$GameState.penaltySeconds
                TotalSeconds   = [int]$GameState.penaltySeconds
                WrongAnswers   = [int]$GameState.wrongAnswers
            }
        }

        $elapsed = New-TimeSpan -Start $GameState.startTime -End (Get-Date)
        $actualSeconds = [int][Math]::Round($elapsed.TotalSeconds)
        $penaltySeconds = [int]$GameState.penaltySeconds

        return [PSCustomObject]@{
            ActualSeconds  = $actualSeconds
            PenaltySeconds = $penaltySeconds
            TotalSeconds   = $actualSeconds + $penaltySeconds
            WrongAnswers   = [int]$GameState.wrongAnswers
        }
    }
    catch {
        Show-Error "Kunde inte räkna ut aktuell tid: $($_.Exception.Message)"
        return [PSCustomObject]@{
            ActualSeconds  = 0
            PenaltySeconds = [int]$GameState.penaltySeconds
            TotalSeconds   = [int]$GameState.penaltySeconds
            WrongAnswers   = [int]$GameState.wrongAnswers
        }
    }
}

function Add-TimePenalty {
    param(
        [Parameter(Mandatory)]
        [object]$GameState,

        [int]$Seconds = 10
    )

    $GameState.wrongAnswers++
    $GameState.penaltySeconds += $Seconds
}

function Show-FinalResult {
    param(
        [Parameter(Mandatory)]
        [object]$GameState,

        [Parameter(Mandatory)]
        [string]$SavePath
    )

    try {
        Save-Game -Path $SavePath -SaveData $GameState
        Save-ScoreboardResult -GameState $GameState | Out-Null
        Show-HackerVictoryMessage -PlayerName $GameState.playerName
        Show-RansomwareSuccessEnding -GameState $GameState
        Wait-ForReturnToMenu
    }
    catch {
        Show-Error "Spelet är klart, men resultatet kunde inte sparas: $($_.Exception.Message)"
        Wait-ForReturnToMenu
    }
}

Export-ModuleMember -Function Start-SecurityEscapeRoom, Start-RansomwareEscapeRoom, Show-ScoreboardMenu, Start-NewGame, Start-RansomwareTimer, Stop-RansomwareTimer, Get-CurrentRansomwareTime, Add-TimePenalty, Show-FinalResult
