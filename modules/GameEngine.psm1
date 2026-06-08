# GameEngine.psm1
# Spelmotorn styr huvudmenyn, rummen och spelarens progress.

function Get-GameRooms {
    # Varje rum pekar på en egen säkerhetsutmaning i SecurityChallenges.psm1.
    return @(
        [PSCustomObject]@{
            id                = "phishing-room"
            name              = "Phishing Room"
            description       = "En vägg av skärmar visar en inkorg. En blinkande varning låser dörren bakom dig."
            clue              = "Rummet reagerar på stress, hot och misstänkta länkar."
            challengeFunction = "Invoke-PhishingChallenge"
            unlockMessage     = "Inkorgen tystnar och den första dörren glider upp."
        }
        [PSCustomObject]@{
            id                = "password-vault"
            name              = "Password Vault"
            description       = "Ett digitalt valv står i mitten av rummet. På dörren syns en lösenordsterminal."
            clue              = "Valvet släpper bara igenom långa och unika lösenord."
            challengeFunction = "Invoke-PasswordChallenge"
            unlockMessage     = "Valvets lås klickar till. En ny säkerhetsnyckel läggs till din poäng."
        }
        [PSCustomObject]@{
            id                = "mfa-door"
            name              = "MFA Door"
            description       = "Dörren framför dig har två lås. Det andra låset väntar på en MFA-bekräftelse."
            clue              = "En MFA-notis ska bara godkännas om du själv försöker logga in."
            challengeFunction = "Invoke-MfaChallenge"
            unlockMessage     = "Det andra låset lyser grönt. Dörren öppnas utan larm."
        }
        [PSCustomObject]@{
            id                = "usb-lab"
            name              = "USB Lab"
            description       = "På labbordet ligger ett okänt USB-minne bredvid en dator med röd varningslampa."
            clue              = "Allt som går att koppla in kan också vara en risk."
            challengeFunction = "Invoke-UsbChallenge"
            unlockMessage     = "Varningslampan slocknar. Labbet är säkrat."
        }
        [PSCustomObject]@{
            id                = "incident-center"
            name              = "Incident Center"
            description       = "Det sista rummet är ett kontrollcenter. Larm visar att ett konto kan vara kapat."
            clue              = "En incident blir lättare att stoppa när den rapporteras snabbt."
            challengeFunction = "Invoke-IncidentChallenge"
            unlockMessage     = "Larmet tystnar. Utgångsdörren låses upp."
        }
    )
}

function New-GameState {
    param(
        [Parameter(Mandatory)]
        [string]$PlayerName
    )

    return [PSCustomObject]@{
        playerName     = $PlayerName
        currentRoom    = 0
        score          = 0
        completedRooms = @()
        lastSaved      = ""
    }
}

function Start-SecurityEscapeRoom {
    param(
        [string]$ProjectRoot = (Split-Path -Path $PSScriptRoot -Parent)
    )

    $savePath = Join-Path -Path $ProjectRoot -ChildPath "data\savegame.json"
    $isRunning = $true

    while ($isRunning) {
        Show-Title
        Show-Message "Du är inlåst i skolans säkerhetslabb." "Gray"
        Show-Message "Lös fem rum, samla säkerhetsnycklar och hitta vägen ut." "Gray"

        Show-Menu -Options @(
            "1. Nytt spel",
            "2. Fortsätt sparat spel",
            "3. Avsluta"
        )

        $choice = Read-Host "Välj ett alternativ"

        switch ($choice) {
            "1" {
                Start-NewGame -SavePath $savePath
            }
            "2" {
                Resume-Game -SavePath $savePath
            }
            "3" {
                Show-Message "Du lämnar terminalen. Spelet avslutas." "Cyan"
                $isRunning = $false
            }
            default {
                Show-FailureMessage "Ogiltigt val. Skriv 1, 2 eller 3."
                Pause-Game
            }
        }
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

        $gameState = New-GameState -PlayerName $playerName
        Save-Game -Path $SavePath -SaveData $gameState

        Show-SuccessMessage "Terminalen känner igen dig, $playerName. Första dörren öppnas."
        Pause-Game
        Enter-Room -GameState $gameState -SavePath $SavePath
    }
    catch {
        Show-Error "Kunde inte starta ett nytt spel: $($_.Exception.Message)"
    }
}

function Resume-Game {
    param(
        [Parameter(Mandatory)]
        [string]$SavePath
    )

    try {
        $gameState = Get-GameSave -Path $SavePath

        if ([string]::IsNullOrWhiteSpace($gameState.playerName)) {
            Show-FailureMessage "Det finns inget sparat spel ännu. Starta ett nytt spel först."
            Pause-Game
            return
        }

        $rooms = Get-GameRooms
        $roomNumber = 0

        if (-not [int]::TryParse($gameState.currentRoom.ToString(), [ref]$roomNumber)) {
            Show-FailureMessage "Sparfilen innehåller ett ogiltigt rumsnummer."
            Pause-Game
            return
        }

        if ($roomNumber -lt 0 -or $roomNumber -gt $rooms.Count) {
            Show-FailureMessage "Sparfilen pekar på ett rum som inte finns."
            Pause-Game
            return
        }

        $gameState.currentRoom = $roomNumber

        Show-SuccessMessage "Sparfil hittad. Välkommen tillbaka, $($gameState.playerName)."
        Pause-Game
        Enter-Room -GameState $gameState -SavePath $SavePath
    }
    catch {
        Show-Error "Kunde inte fortsätta sparat spel: $($_.Exception.Message)"
    }
}

function Enter-Room {
    param(
        [Parameter(Mandatory)]
        [object]$GameState,

        [Parameter(Mandatory)]
        [string]$SavePath
    )

    $rooms = Get-GameRooms

    while ($GameState.currentRoom -lt $rooms.Count) {
        $room = $rooms[$GameState.currentRoom]

        Show-Title
        Show-RoomIntro -Room $room
        Show-Score -Score $GameState.score -CompletedRooms $GameState.completedRooms.Count -TotalRooms $rooms.Count

        $challenge = Get-Command -Name $room.challengeFunction -ErrorAction Stop
        $result = & $challenge.Name

        if ($result.Success) {
            Complete-Room -GameState $GameState -Room $room -ChallengeResult $result -SavePath $SavePath
        }
        else {
            Show-FailureMessage "Dörren är fortfarande låst. Försök igen när du är redo."
        }

        Pause-Game
    }

    End-Game -GameState $GameState -SavePath $SavePath
}

function Complete-Room {
    param(
        [Parameter(Mandatory)]
        [object]$GameState,

        [Parameter(Mandatory)]
        [object]$Room,

        [Parameter(Mandatory)]
        [object]$ChallengeResult,

        [Parameter(Mandatory)]
        [string]$SavePath
    )

    try {
        # ConvertFrom-Json kan ibland ge en fast array. @() gör att vi alltid kan lägga till nya värden.
        $completedRooms = @($GameState.completedRooms)

        if ($completedRooms -notcontains $Room.id) {
            $completedRooms += $Room.id
            $GameState.score += $ChallengeResult.Points
        }

        $GameState.completedRooms = $completedRooms
        $GameState.currentRoom++

        Save-Game -Path $SavePath -SaveData $GameState
        Show-SuccessMessage "$($Room.unlockMessage) Progress sparad."
    }
    catch {
        Show-Error "Kunde inte spara efter rummet: $($_.Exception.Message)"
    }
}

function End-Game {
    param(
        [Parameter(Mandatory)]
        [object]$GameState,

        [Parameter(Mandatory)]
        [string]$SavePath
    )

    try {
        Show-Title
        Show-SuccessMessage "Grattis $($GameState.playerName)! Du tog dig ut ur Security Escape Room."
        Show-Score -Score $GameState.score -CompletedRooms $GameState.completedRooms.Count -TotalRooms 5
        Show-Message "Du har visat koll på phishing, lösenord, MFA, USB-risker och incidentrapportering." "Gray"

        Save-Game -Path $SavePath -SaveData $GameState
    }
    catch {
        Show-Error "Ett fel uppstod när spelet skulle avslutas: $($_.Exception.Message)"
    }
}

Export-ModuleMember -Function Start-SecurityEscapeRoom, Start-NewGame, Resume-Game, Enter-Room, Complete-Room, End-Game
