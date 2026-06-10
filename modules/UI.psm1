# UI.psm1
# Funktioner för att visa text, menyer och ransomware-tema i terminalen.

function Format-GameTime {
    param(
        [Parameter(Mandatory)]
        [int]$Seconds
    )

    $minutes = [Math]::Floor($Seconds / 60)
    $remainingSeconds = $Seconds % 60
    return "$minutes minuter och $remainingSeconds sekunder"
}

function Format-ClockTime {
    param(
        [Parameter(Mandatory)]
        [int]$Seconds
    )

    $minutes = [int][Math]::Floor($Seconds / 60)
    $remainingSeconds = [int]($Seconds % 60)
    return "{0:D2}:{1:D2}" -f $minutes, $remainingSeconds
}

function Show-Title {
    try {
        Clear-Host
    }
    catch {
        Write-Host ""
    }

    Write-Host "==================================================" -ForegroundColor DarkRed
    Write-Host "            RANSOMWARE ESCAPE ROOM" -ForegroundColor Red
    Write-Host "==================================================" -ForegroundColor DarkRed
    Write-Host "Svara rätt. Stoppa attacken. Rädda filerna." -ForegroundColor Gray
    Write-Host ""
}

function Show-RansomwareIntro {
    Show-Title
    Write-Host "Ett varningsfönster blinkar i terminalen." -ForegroundColor Yellow
    Write-Host "Alla filer är markerade som krypterade." -ForegroundColor Yellow
    Write-Host "För att återställa systemet måste du klara 5 frågor om ransomware." -ForegroundColor White
    Write-Host "Målet är att bli klar så snabbt som möjligt." -ForegroundColor Gray
}

function Show-HackerMessage {
    param(
        [Parameter(Mandatory)]
        [string]$PlayerName
    )

    Show-Title
    Write-Host "+---------------- HACKER-MEDDELANDE ----------------+" -ForegroundColor DarkRed
    Write-Host "| Hej $PlayerName." -ForegroundColor Red
    Write-Host "| Dina filer har blivit krypterade." -ForegroundColor Red
    Write-Host "| Systemet är låst tills du visar att du kan stoppa attacken." -ForegroundColor Red
    Write-Host "| Fem frågor. Varje fel svar lägger till 10 sekunder." -ForegroundColor Yellow
    Write-Host "| Klara provet, så återställs systemet." -ForegroundColor Green
    Write-Host "+---------------------------------------------------+" -ForegroundColor DarkRed
    Write-Host ""
}

function Show-Menu {
    param(
        [Parameter(Mandatory)]
        [string[]]$Options
    )

    Write-Host ""
    Write-Host "+---------------- HUVUDMENY ----------------+" -ForegroundColor DarkRed

    foreach ($option in $Options) {
        Write-Host "| $option" -ForegroundColor White
    }

    Write-Host "+-------------------------------------------+" -ForegroundColor DarkRed
    Write-Host ""
}

function Show-QuestionHeader {
    param(
        [Parameter(Mandatory)]
        [int]$QuestionNumber,

        [Parameter(Mandatory)]
        [int]$TotalQuestions,

        [int]$PenaltySeconds = 0
    )

    Write-Host ""
    Write-Host "---------------- FRÅGA $QuestionNumber AV $TotalQuestions ----------------" -ForegroundColor Cyan
    Write-Host "Tidstillägg hittills: +$PenaltySeconds sekunder" -ForegroundColor Yellow
    Write-Host ""
}

function Show-CurrentTimer {
    param(
        [Parameter(Mandatory)]
        [int]$TotalSeconds,

        [Parameter(Mandatory)]
        [int]$WrongAnswers,

        [Parameter(Mandatory)]
        [int]$PenaltySeconds
    )

    try {
        Write-Host "+---------------- TID ----------------+" -ForegroundColor DarkCyan
        Write-Host "| Tid just nu: $(Format-ClockTime -Seconds $TotalSeconds)" -ForegroundColor Cyan
        Write-Host "| Fel: $WrongAnswers" -ForegroundColor Yellow
        Write-Host "| Tidstillägg: $PenaltySeconds sekunder" -ForegroundColor Yellow
        Write-Host "+-------------------------------------+" -ForegroundColor DarkCyan
        Write-Host ""
    }
    catch {
        Write-Host "Kunde inte visa timern." -ForegroundColor Red
    }
}

function Show-WrongAnswerMessage {
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [int]$PenaltySeconds = 10
    )

    Write-Host ""
    Write-Host "[FEL SVAR] $Message" -ForegroundColor Yellow
    Write-Host "Tidstillägg: +$PenaltySeconds sekunder. Försök med samma fråga igen." -ForegroundColor Red
    Write-Host ""
}

function Show-CorrectAnswerMessage {
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )

    Write-Host ""
    Write-Host "[RÄTT SVAR] $Message" -ForegroundColor Green
    Write-Host "Nästa lås öppnas." -ForegroundColor Green
    Write-Host ""
}

function Show-HackerVictoryMessage {
    param(
        [Parameter(Mandatory)]
        [string]$PlayerName
    )

    Show-Title
    Write-Host "+---------------- HACKER-MEDDELANDE ----------------+" -ForegroundColor DarkRed
    Write-Host "| ...signal återställd..." -ForegroundColor DarkGray
    Write-Host "| Bra jobbat, $PlayerName." -ForegroundColor Red
    Write-Host "| Du klarade mina tester." -ForegroundColor Red
    Write-Host "| Jag släpper dina filer." -ForegroundColor Yellow
    Write-Host "| Kom ihåg: säkerhetskopior, uppdateringar och försiktighet räddar data." -ForegroundColor Green
    Write-Host "+---------------------------------------------------+" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "Dekrypterar filer..." -ForegroundColor Cyan
    Write-Host "[#####---------------] 25%" -ForegroundColor DarkCyan
    Write-Host "[##########----------] 50%" -ForegroundColor DarkCyan
    Write-Host "[###############-----] 75%" -ForegroundColor DarkCyan
    Write-Host "[####################] 100%" -ForegroundColor Green
    Write-Host "Dekryptering klar." -ForegroundColor Green
    Write-Host ""
}

function Show-RansomwareSuccessEnding {
    param(
        [Parameter(Mandatory)]
        [object]$GameState
    )

    Write-Host "==================================================" -ForegroundColor DarkRed
    Write-Host "            RANSOMWARE ESCAPE ROOM" -ForegroundColor Red
    Write-Host "==================================================" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "##################################################" -ForegroundColor Green
    Write-Host "#                                                #" -ForegroundColor Green
    Write-Host "#        BRA JOBBAT! DU KLARADE DET!             #" -ForegroundColor Green
    Write-Host "#                                                #" -ForegroundColor Green
    Write-Host "##################################################" -ForegroundColor Green
    Write-Host ""
    Write-Host "Systemet är återställt." -ForegroundColor Cyan
    Write-Host "Dina filer är dekrypterade." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "---------------- SLUTRESULTAT ----------------" -ForegroundColor DarkCyan
    Write-Host "Spelare: $($GameState.playerName)" -ForegroundColor White
    Write-Host "Faktisk tid: $(Format-GameTime -Seconds $GameState.actualSeconds)" -ForegroundColor Gray
    Write-Host "Antal fel: $($GameState.wrongAnswers)" -ForegroundColor Yellow
    Write-Host "Tidstillägg: +$(Format-GameTime -Seconds $GameState.penaltySeconds)" -ForegroundColor Yellow
    Write-Host "Sluttid: $(Format-GameTime -Seconds $GameState.totalSeconds)" -ForegroundColor Green
    Write-Host "----------------------------------------------" -ForegroundColor DarkCyan
    Write-Host ""
}

function Show-Scoreboard {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [object[]]$Results
    )

    Show-Title
    Write-Host "================ SCOREBOARD ================" -ForegroundColor DarkCyan
    Write-Host ""

    if ($Results.Count -eq 0) {
        Write-Host "Inga resultat finns ännu." -ForegroundColor Yellow
        Write-Host ""
        return
    }

    Write-Host ("{0,-5} {1,-16} {2,-8} {3,-5} {4,-12} {5,-19}" -f "#", "Spelare", "Sluttid", "Fel", "Tillägg", "Sparad")
    Write-Host ("{0,-5} {1,-16} {2,-8} {3,-5} {4,-12} {5,-19}" -f "---", "-------", "-------", "---", "-------", "------") -ForegroundColor DarkGray

    $place = 1

    foreach ($result in $Results) {
        $name = [string]$result.playerName

        if ($name.Length -gt 15) {
            $name = $name.Substring(0, 15)
        }

        $totalTime = Format-ClockTime -Seconds ([int]$result.totalTimeSeconds)
        $penaltyText = "$([int]$result.penaltySeconds)s"

        Write-Host ("{0,-5} {1,-16} {2,-8} {3,-5} {4,-12} {5,-19}" -f $place, $name, $totalTime, $result.wrongAnswers, $penaltyText, $result.completedAt) -ForegroundColor White
        $place++
    }

    Write-Host ""
    Write-Host "Snabbast total sluttid ligger överst." -ForegroundColor Gray
    Write-Host ""
}

function Show-SuccessMessage {
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )

    Write-Host ""
    Write-Host "[OK] $Message" -ForegroundColor Green
    Write-Host ""
}

function Show-FailureMessage {
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )

    Write-Host ""
    Write-Host "[VARNING] $Message" -ForegroundColor Yellow
    Write-Host ""
}

function Pause-Game {
    Read-Host "Tryck Enter för att fortsätta" | Out-Null
}

function Wait-ForReturnToMenu {
    Read-Host "Tryck Enter för att återgå till huvudmenyn..." | Out-Null
}

function Show-Message {
    param(
        [Parameter(Mandatory)]
        [string]$Text,

        [string]$Color = "White"
    )

    Write-Host $Text -ForegroundColor $Color
}

function Show-Error {
    param(
        [Parameter(Mandatory)]
        [string]$Text
    )

    Write-Host "Fel: $Text" -ForegroundColor Red
}

Export-ModuleMember -Function Show-Title, Show-RansomwareIntro, Show-HackerMessage, Show-HackerVictoryMessage, Show-Menu, Show-QuestionHeader, Show-CurrentTimer, Show-WrongAnswerMessage, Show-CorrectAnswerMessage, Show-RansomwareSuccessEnding, Show-Scoreboard, Show-SuccessMessage, Show-FailureMessage, Pause-Game, Wait-ForReturnToMenu, Show-Message, Show-Error
