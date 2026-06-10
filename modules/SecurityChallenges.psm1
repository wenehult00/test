# SecurityChallenges.psm1
# Här finns ransomware-frågorna och quizlogiken.

function Get-RansomwareQuestions {
    return @(
        [PSCustomObject]@{
            Number      = 1
            Question    = "Vad är ransomware?"
            Options     = @(
                "A. Ett program som förbättrar datorns prestanda",
                "B. Skadlig kod som krypterar filer och kräver lösensumma",
                "C. Ett vanligt antivirusprogram"
            )
            Correct     = "B"
            CorrectText = "Rätt. Ransomware låser eller krypterar filer och försöker pressa offret på pengar."
            WrongText   = "Fel. Ransomware är skadlig kod som krypterar filer och kräver lösensumma."
        }
        [PSCustomObject]@{
            Number      = 2
            Question    = "Vad är det bästa första steget om du misstänker ransomware?"
            Options     = @(
                "A. Koppla bort datorn från nätverket och kontakta IT",
                "B. Betala lösensumman direkt",
                "C. Starta om datorn flera gånger"
            )
            Correct     = "A"
            CorrectText = "Rätt. Att koppla bort datorn kan bromsa spridning, och IT kan hjälpa till på rätt sätt."
            WrongText   = "Fel. Första steget är att isolera datorn från nätverket och kontakta IT eller ansvarig vuxen."
        }
        [PSCustomObject]@{
            Number      = 3
            Question    = "Vilket skydd minskar risken att förlora data vid ransomware?"
            Options     = @(
                "A. Regelbundna säkerhetskopior",
                "B. Att använda samma lösenord överallt",
                "C. Att ignorera säkerhetsuppdateringar"
            )
            Correct     = "A"
            CorrectText = "Rätt. Säkerhetskopior gör det möjligt att återställa filer utan att betala angriparen."
            WrongText   = "Fel. Regelbundna säkerhetskopior är ett av de viktigaste skydden mot dataförlust."
        }
        [PSCustomObject]@{
            Number      = 4
            Question    = "Hur sprids ransomware ofta?"
            Options     = @(
                "A. Genom phishingmejl och skadliga bilagor",
                "B. Genom att skärmen är för ljus",
                "C. Genom att datorn är avstängd"
            )
            Correct     = "A"
            CorrectText = "Rätt. Phishingmejl, falska länkar och skadliga bilagor är vanliga vägar in."
            WrongText   = "Fel. Ransomware sprids ofta via phishingmejl, skadliga bilagor och osäkra länkar."
        }
        [PSCustomObject]@{
            Number      = 5
            Question    = "Varför bör man vara försiktig med okända bilagor?"
            Options     = @(
                "A. De kan innehålla skadlig kod",
                "B. De gör alltid datorn snabbare",
                "C. De uppdaterar automatiskt antivirus"
            )
            Correct     = "A"
            CorrectText = "Rätt. Okända bilagor kan innehålla skadlig kod och ska kontrolleras innan de öppnas."
            WrongText   = "Fel. Okända bilagor kan innehålla skadlig kod, även om mejlet ser trovärdigt ut."
        }
    )
}

function Read-RansomwareChoice {
    param(
        [Parameter(Mandatory)]
        [string]$Prompt
    )

    try {
        $choice = Read-Host $Prompt

        if ([string]::IsNullOrWhiteSpace($choice)) {
            return $null
        }

        $choice = $choice.Trim().ToUpper()

        switch ($choice) {
            "1" { return "A" }
            "2" { return "B" }
            "3" { return "C" }
            "A" { return "A" }
            "B" { return "B" }
            "C" { return "C" }
            default { return $null }
        }
    }
    catch {
        Write-Host "Terminalen kunde inte läsa ditt svar. Försök igen." -ForegroundColor Red
        return $null
    }
}

function Invoke-RansomwareQuiz {
    param(
        [Parameter(Mandatory)]
        [object]$GameState
    )

    $questions = Get-RansomwareQuestions

    foreach ($question in $questions) {
        Invoke-RansomwareQuestion -Question $question -GameState $GameState -TotalQuestions $questions.Count
        $GameState.completedQuestions++
    }

    return [PSCustomObject]@{
        Success            = $true
        CompletedQuestions = $GameState.completedQuestions
        WrongAnswers       = $GameState.wrongAnswers
        PenaltySeconds     = $GameState.penaltySeconds
    }
}

function Invoke-RansomwareQuestion {
    param(
        [Parameter(Mandatory)]
        [object]$Question,

        [Parameter(Mandatory)]
        [object]$GameState,

        [Parameter(Mandatory)]
        [int]$TotalQuestions
    )

    $answeredCorrectly = $false

    while (-not $answeredCorrectly) {
        try {
            $currentTime = Get-CurrentRansomwareTime -GameState $GameState
            Show-QuestionHeader -QuestionNumber $Question.Number -TotalQuestions $TotalQuestions -PenaltySeconds $currentTime.PenaltySeconds
            Show-CurrentTimer -TotalSeconds $currentTime.TotalSeconds -WrongAnswers $currentTime.WrongAnswers -PenaltySeconds $currentTime.PenaltySeconds
        }
        catch {
            Show-QuestionHeader -QuestionNumber $Question.Number -TotalQuestions $TotalQuestions -PenaltySeconds $GameState.penaltySeconds
            Show-Error "Kunde inte visa aktuell tid: $($_.Exception.Message)"
        }

        Write-Host $Question.Question -ForegroundColor White
        Write-Host ""

        foreach ($option in $Question.Options) {
            Write-Host $option -ForegroundColor Gray
        }

        Write-Host ""
        $choice = Read-RansomwareChoice -Prompt "Ditt svar (A, B eller C)"

        if ($null -eq $choice) {
            Show-FailureMessage "Ogiltig input. Skriv A, B eller C."
            continue
        }

        if ($choice -eq $Question.Correct) {
            Show-CorrectAnswerMessage -Message $Question.CorrectText
            $answeredCorrectly = $true
        }
        else {
            Add-TimePenalty -GameState $GameState -Seconds 10
            Show-WrongAnswerMessage -Message $Question.WrongText -PenaltySeconds 10
        }
    }
}

Export-ModuleMember -Function Invoke-RansomwareQuiz, Invoke-RansomwareQuestion
