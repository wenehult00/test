# Security Escape Room

Security Escape Room är ett interaktivt CLI-spel i PowerShell som vi har byggt som skolprojekt. Spelet ska lära ut grundläggande IT-säkerhet genom ett escape room-upplägg där spelaren tar sig igenom fem rum.

Vi ville att spelet skulle kännas mer som ett litet äventyr än som ett vanligt quiz. Därför har varje rum ett scenario, en ledtråd, ett säkerhetsbeslut och feedback efter spelarens val.

## Syfte

Syftet med projektet är att visa att vi kan:

- bygga ett modulärt PowerShell-projekt
- använda JSON för sparad speldata
- skapa ett interaktivt kontrollflöde i terminalen
- använda `try/catch` för felhantering
- dokumentera projektet med agila arbetssätt
- koppla spelets innehåll till IT-säkerhet och förändringsledning

## Spelets rum

Spelet består av fem rum:

1. Phishing Room
2. Password Vault
3. MFA Door
4. USB Lab
5. Incident Center

Varje rum tränar ett säkerhetsområde:

- phishing och misstänkta länkar
- starka lösenord
- MFA och oväntade inloggningsförsök
- risker med okända USB-enheter
- incidentrapportering

## Starta spelet

Öppna PowerShell i projektmappen och kör:

```powershell
.\Start-Game.ps1
```

Om PowerShell stoppar skriptet på grund av execution policy kan man tillfälligt tillåta skript i samma terminalsession:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## Projektstruktur

```text
Security Escape Room
|-- Start-Game.ps1
|-- modules
|   |-- GameEngine.psm1
|   |-- SaveSystem.psm1
|   |-- SecurityChallenges.psm1
|   `-- UI.psm1
|-- data
|   |-- questions.json
|   |-- rooms.json
|   `-- savegame.json
|-- docs
|   |-- product-vision.md
|   |-- daily-standups.md
|   |-- sprint-review.md
|   |-- sprint-retrospective.md
|   `-- change-management-adkar.md
|-- tests
|   `-- test-manual.md
`-- README.md
```

## Modulernas ansvar

`Start-Game.ps1` startar projektet, importerar moduler och fångar startfel.

`GameEngine.psm1` innehåller spelmotorn: huvudmeny, nytt spel, fortsätt spel, rum, poäng och slut.

`SecurityChallenges.psm1` innehåller de fem interaktiva säkerhetsutmaningarna.

`SaveSystem.psm1` sparar och laddar speldata från `data/savegame.json`.

`UI.psm1` visar titel, menyer, rum, poäng och feedback i terminalen.

## Sparfunktion

Spelet sparar progress i:

```text
data/savegame.json
```

Sparfilen innehåller:

- `playerName`
- `currentRoom`
- `score`
- `completedRooms`
- `lastSaved`

## GitHub Projects

Vi använde GitHub Projects som en enkel Scrum/Kanban-tavla. Vi delade upp arbetet i User Stories och Issues.

Exempel på User Stories:

- Som spelare vill jag kunna starta ett nytt spel så att jag kan börja från rum 1.
- Som spelare vill jag kunna fortsätta ett sparat spel så att jag inte tappar progress.
- Som elev vill jag få feedback efter rätt eller fel svar så att jag lär mig av spelet.
- Som utvecklare vill jag dela upp koden i moduler så att projektet blir lättare att förstå.
- Som lärare vill jag kunna se dokumentation och testplan så att projektet går att bedöma.

Exempel på kolumner:

- Backlog
- Todo
- In progress
- Review
- Done

## Status

Projektet uppfyller grundkraven för skoluppgiften: modulär kod, interaktivt CLI, JSON-sparning, felhantering och dokumentation.
