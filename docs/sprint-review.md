# Sprint Review

## Sprintmål

Vårt sprintmål var att skapa ett fungerande PowerShell CLI-spel som lär ut IT-säkerhet genom ett escape room-upplägg.

## Vad vi levererade

- Startfil: `Start-Game.ps1`
- Spelmotor: `modules/GameEngine.psm1`
- Sparsystem: `modules/SaveSystem.psm1`
- Säkerhetsutmaningar: `modules/SecurityChallenges.psm1`
- Terminal-UI: `modules/UI.psm1`
- Sparfil i JSON: `data/savegame.json`
- Dokumentation i `docs`
- Manuell testplan i `tests/test-manual.md`

## Funktioner som fungerar

- Spelaren kan välja nytt spel.
- Spelaren kan fortsätta ett sparat spel.
- Spelet har fem rum.
- Varje rum har ett säkerhetsscenario.
- Rätt svar ger poäng och låser upp nästa rum.
- Fel svar ger feedback och spelaren får försöka igen.
- Progress sparas i JSON efter varje avklarat rum.
- Spelet visar tydlig poäng och antal avklarade rum.

## Demo

Vid demo visar vi:

1. Starta spelet med `.\Start-Game.ps1`.
2. Välj `1. Nytt spel`.
3. Skriv spelarnamn.
4. Lös Phishing Room.
5. Visa att poängen ökar.
6. Avsluta eller fortsätt tills alla fem rum är klara.
7. Öppna `data/savegame.json` och visa att progress sparas.

## GitHub Projects

Vi använde GitHub Projects för att dela upp arbetet i mindre delar. Varje större funktion blev en Issue eller User Story.

Exempel:

- Skapa huvudmeny
- Skapa sparsystem med JSON
- Skapa phishing-utmaning
- Skapa UI-funktioner
- Skriva manuell testplan
- Skriva ADKAR-dokumentation

Vi flyttade korten mellan Backlog, Todo, In progress, Review och Done. Det hjälpte oss att se vad som var kvar och undvika att alla jobbade på samma sak.

## Feedback från sprint review

Det som fungerade bra:

- Spelet gick att spela från start till slut.
- Terminalen blev tydligare efter UI-förbättringarna.
- Säkerhetsinnehållet blev lätt att förstå.

Det som kan förbättras:

- Fler rum kan läggas till.
- Frågorna kan slumpas.
- Spelet kan få svårighetsgrader.
- Automatiska Pester-tester kan läggas till senare.
