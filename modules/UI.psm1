# UI.psm1
# Funktioner för att visa text och menyer i terminalen.

function Show-Title {
    try {
        Clear-Host
    }
    catch {
        Write-Host ""
    }

    Write-Host "==================================================" -ForegroundColor DarkCyan
    Write-Host "              SECURITY ESCAPE ROOM" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor DarkCyan
    Write-Host "Samla säkerhetsnycklar. Lås upp rummen. Ta dig ut." -ForegroundColor Gray
    Write-Host ""
}

function Show-Menu {
    param(
        [Parameter(Mandatory)]
        [string[]]$Options
    )

    Write-Host ""
    Write-Host "+---------------- HUVUDMENY ----------------+" -ForegroundColor DarkCyan

    foreach ($option in $Options) {
        Write-Host "| $option" -ForegroundColor White
    }

    Write-Host "+-------------------------------------------+" -ForegroundColor DarkCyan
    Write-Host ""
}

function Show-RoomIntro {
    param(
        [Parameter(Mandatory)]
        [object]$Room
    )

    Write-Host ""
    Write-Host "+------------------ RUM --------------------+" -ForegroundColor DarkGray
    Write-Host "| $($Room.name)" -ForegroundColor Cyan
    Write-Host "+-------------------------------------------+" -ForegroundColor DarkGray
    Write-Host $Room.description -ForegroundColor White

    if ($Room.clue) {
        Write-Host ""
        Write-Host "Ledtråd: $($Room.clue)" -ForegroundColor Yellow
    }

    Write-Host ""
}

function Show-SuccessMessage {
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )

    Write-Host ""
    Write-Host "[UPPLÅST] $Message" -ForegroundColor Green
    Write-Host ""
}

function Show-FailureMessage {
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )

    Write-Host ""
    Write-Host "[LÅST] $Message" -ForegroundColor Yellow
    Write-Host ""
}

function Show-Score {
    param(
        [Parameter(Mandatory)]
        [int]$Score,

        [int]$CompletedRooms = 0,

        [int]$TotalRooms = 5
    )

    Write-Host "+---------------- STATUS -------------------+" -ForegroundColor DarkMagenta
    Write-Host "| Säkerhetsnycklar: $Score poäng" -ForegroundColor Magenta
    Write-Host "| Avklarade rum: $CompletedRooms av $TotalRooms" -ForegroundColor Magenta
    Write-Host "+-------------------------------------------+" -ForegroundColor DarkMagenta
    Write-Host ""
}

function Pause-Game {
    Read-Host "Tryck Enter för att fortsätta" | Out-Null
}

# Små kompatibilitetsfunktioner för äldre delar av projektet.
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

function Show-Room {
    param(
        [Parameter(Mandatory)]
        [object]$Room
    )

    Show-RoomIntro -Room $Room
}

Export-ModuleMember -Function Show-Title, Show-Menu, Show-RoomIntro, Show-SuccessMessage, Show-FailureMessage, Show-Score, Pause-Game, Show-Message, Show-Error, Show-Room
