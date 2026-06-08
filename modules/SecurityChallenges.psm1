# SecurityChallenges.psm1
# Här finns spelets säkerhetsutmaningar.
# Varje funktion returnerar ett objekt med Success, Points och Feedback.

function New-ChallengeResult {
    param(
        [Parameter(Mandatory)]
        [bool]$Success,

        [Parameter(Mandatory)]
        [int]$Points,

        [Parameter(Mandatory)]
        [string]$Feedback
    )

    return [PSCustomObject]@{
        Success  = $Success
        Points   = $Points
        Feedback = $Feedback
    }
}

function Read-ChallengeChoice {
    param(
        [Parameter(Mandatory)]
        [string]$Prompt
    )

    try {
        $choice = Read-Host $Prompt

        if ($choice -notin @("1", "2", "3")) {
            Write-Host "Terminalen blinkar rött: välj 1, 2 eller 3." -ForegroundColor Yellow
            return $null
        }

        return [int]$choice
    }
    catch {
        Write-Host "Terminalen kunde inte läsa ditt svar. Försök igen." -ForegroundColor Red
        return $null
    }
}

function Invoke-PhishingChallenge {
    Write-Host ""
    Write-Host "Terminalutmaning: Inkorgen" -ForegroundColor Cyan
    Write-Host "Ett nytt mejl fyller skärmen: 'DITT KONTO STÄNGS OM 10 MINUTER'."
    Write-Host "Avsändaren liknar skolans adress, men några bokstäver är fel. En stor knapp blinkar."
    Write-Host ""
    Write-Host "1. Klicka på knappen direkt för att rädda kontot."
    Write-Host "2. Kontrollera avsändaren och gå själv till skolans riktiga inloggningssida."
    Write-Host "3. Svara på mejlet med ditt användarnamn och lösenord."

    $choice = Read-ChallengeChoice -Prompt "Välj säker åtgärd"

    if ($null -eq $choice) {
        return New-ChallengeResult -Success $false -Points 0 -Feedback "Terminalen accepterar bara alternativen 1, 2 eller 3."
    }

    if ($choice -eq 2) {
        $feedback = "Rätt. Du litade inte på länken, utan valde en kontrollerad väg till tjänsten."
        Write-Host $feedback -ForegroundColor Green
        return New-ChallengeResult -Success $true -Points 10 -Feedback $feedback
    }

    $feedback = "Farligt val. Phishing använder ofta stress och falska länkar för att stjäla inloggningar."
    Write-Host $feedback -ForegroundColor Yellow
    return New-ChallengeResult -Success $false -Points 0 -Feedback $feedback
}

function Invoke-PasswordChallenge {
    Write-Host ""
    Write-Host "Terminalutmaning: Valvlåset" -ForegroundColor Cyan
    Write-Host "Valvet visar tre möjliga lösenord. Ett svagt val startar larmet."
    Write-Host "Du behöver välja det lösenord som bäst står emot gissning och knäckning."
    Write-Host ""
    Write-Host "1. Password123"
    Write-Host "2. sommar2026"
    Write-Host "3. Vinter!Kamera-73-Skog"

    $choice = Read-ChallengeChoice -Prompt "Välj lösenord"

    if ($null -eq $choice) {
        return New-ChallengeResult -Success $false -Points 0 -Feedback "Valvet kräver ett val mellan 1 och 3."
    }

    if ($choice -eq 3) {
        $feedback = "Rätt. Längd, variation och unikhet gör lösenfrasen mycket starkare."
        Write-Host $feedback -ForegroundColor Green
        return New-ChallengeResult -Success $true -Points 10 -Feedback $feedback
    }

    $feedback = "För svagt. Vanliga ord, namn, årtal och enkla mönster är lätta att gissa."
    Write-Host $feedback -ForegroundColor Yellow
    return New-ChallengeResult -Success $false -Points 0 -Feedback $feedback
}

function Invoke-MfaChallenge {
    Write-Host ""
    Write-Host "Terminalutmaning: Andra låset" -ForegroundColor Cyan
    Write-Host "Dörren skickar en MFA-notis. Problemet är att du inte försöker logga in."
    Write-Host "Om du godkänner fel notis kan någon annan komma in."
    Write-Host ""
    Write-Host "1. Godkänn notisen för att bli av med den."
    Write-Host "2. Neka notisen och rapportera eller byt lösenord enligt rutinen."
    Write-Host "3. Stäng av MFA eftersom det stör."

    $choice = Read-ChallengeChoice -Prompt "Välj säker åtgärd"

    if ($null -eq $choice) {
        return New-ChallengeResult -Success $false -Points 0 -Feedback "MFA-låset kräver ett giltigt val."
    }

    if ($choice -eq 2) {
        $feedback = "Rätt. En oväntad MFA-notis kan betyda att någon redan har lösenordet."
        Write-Host $feedback -ForegroundColor Green
        return New-ChallengeResult -Success $true -Points 10 -Feedback $feedback
    }

    $feedback = "Fel val. Godkänn aldrig en MFA-notis som du inte själv har startat."
    Write-Host $feedback -ForegroundColor Yellow
    return New-ChallengeResult -Success $false -Points 0 -Feedback $feedback
}

function Invoke-UsbChallenge {
    Write-Host ""
    Write-Host "Terminalutmaning: Okänd enhet" -ForegroundColor Cyan
    Write-Host "USB-minnet ligger precis bredvid labbdatorn. Skärmen visar: 'Anslut enhet för analys'."
    Write-Host "Det kan vara oskyldigt, men det kan också vara en fälla."
    Write-Host ""
    Write-Host "1. Stoppa in det i datorn för att hitta ägaren."
    Write-Host "2. Lämna det till lärare eller IT-ansvarig utan att koppla in det."
    Write-Host "3. Kopiera filerna snabbt och radera sedan USB-minnet."

    $choice = Read-ChallengeChoice -Prompt "Välj säker åtgärd"

    if ($null -eq $choice) {
        return New-ChallengeResult -Success $false -Points 0 -Feedback "USB-labbet accepterar bara val 1, 2 eller 3."
    }

    if ($choice -eq 2) {
        $feedback = "Rätt. Okända USB-enheter ska inte kopplas in i en vanlig dator."
        Write-Host $feedback -ForegroundColor Green
        return New-ChallengeResult -Success $true -Points 10 -Feedback $feedback
    }

    $feedback = "Osäkert. En okänd USB-enhet kan köra skadlig kod eller lura användaren."
    Write-Host $feedback -ForegroundColor Yellow
    return New-ChallengeResult -Success $false -Points 0 -Feedback $feedback
}

function Invoke-IncidentChallenge {
    Write-Host ""
    Write-Host "Terminalutmaning: Larmcentralen" -ForegroundColor Cyan
    Write-Host "Skärmarna visar: 'Möjlig kapning av konto'. Filer saknas och konstiga meddelanden skickas."
    Write-Host "Du behöver välja första åtgärden innan skadan sprider sig."
    Write-Host ""
    Write-Host "1. Rapportera snabbt till lärare eller IT och följ skolans rutin."
    Write-Host "2. Vänta några dagar för att se om problemet försvinner."
    Write-Host "3. Lägg ut användarnamnet och problemet offentligt i en chatt."

    $choice = Read-ChallengeChoice -Prompt "Välj första åtgärd"

    if ($null -eq $choice) {
        return New-ChallengeResult -Success $false -Points 0 -Feedback "Incidentcentralen behöver ett giltigt val."
    }

    if ($choice -eq 1) {
        $feedback = "Rätt. Snabb rapportering hjälper ansvariga att begränsa skadan och säkra bevis."
        Write-Host $feedback -ForegroundColor Green
        return New-ChallengeResult -Success $true -Points 10 -Feedback $feedback
    }

    $feedback = "Inte bra. Incidenter ska rapporteras snabbt och inte delas offentligt med känslig information."
    Write-Host $feedback -ForegroundColor Yellow
    return New-ChallengeResult -Success $false -Points 0 -Feedback $feedback
}

Export-ModuleMember -Function Invoke-PhishingChallenge, Invoke-PasswordChallenge, Invoke-MfaChallenge, Invoke-UsbChallenge, Invoke-IncidentChallenge
