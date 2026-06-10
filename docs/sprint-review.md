# Sprint Review

## Sprintmål

Vårt sprintmål var att skapa ett fungerande PowerShell CLI-spel som lär ut ransomware-säkerhet genom ett escape room-upplägg.

## Vad vi levererade

- Startfil: `Start-Game.ps1`
- Spelmotor: `modules/GameEngine.psm1`
- Sparsystem: `modules/SaveSystem.psm1`
- Säkerhetsutmaningar: `modules/SecurityChallenges.psm1`
- Terminal-UI: `modules/UI.psm1`
- Sparfil i JSON: `data/savegame.json`
- Scoreboard i JSON: `data/scoreboard.json`
- Dokumentation i `docs`
- Manuell testplan i `tests/test-manual.md`

## Funktioner som fungerar

- Spelaren kan starta ett nytt ransomware-prov.
- Spelaren kan visa scoreboard från huvudmenyn.
- Spelet har fem ransomware-frågor.
- Varje fråga har tre svarsalternativ.
- Rätt svar öppnar nästa steg.
- Fel svar ger feedback, +10 sekunders tidstillägg och samma fråga igen.
- Spelet visar aktuell tid under quizet.
- Spelet mäter faktisk tid och räknar fram total sluttid.
- Flera resultat sparas i JSON och sorteras efter snabbaste totaltid.

## Demo

Vid demo visar vi:

1. Starta spelet med `.\Start-Game.ps1`.
2. Välj `1. Nytt spel`.
3. Skriv spelarnamn.
4. Visa hacker-meddelandet.
5. Svara på en fråga fel och visa +10 sekunders tidstillägg.
6. Svara rätt och fortsätt tills alla fem frågor är klara.
7. Visa slutskärmen och öppna `data/scoreboard.json` för att visa att resultatet sparas.
8. Välj `2. Visa scoreboard` och visa sorteringen.

## GitHub Projects

Vi använde GitHub Projects för att dela upp arbetet i mindre delar. Varje större funktion blev en Issue eller User Story.

Exempel:

- Skapa huvudmeny
- Skapa sparsystem med JSON
- Skapa scoreboard för flera spelare
- Skapa ransomware-frågor
- Skapa timer och tidstillägg
- Skapa UI-funktioner
- Skriva manuell testplan
- Skriva ADKAR-dokumentation

Vi flyttade korten mellan Backlog, Todo, In progress, Review och Done. Det hjälpte oss att se vad som var kvar och undvika att alla jobbade på samma sak.

## Feedback från sprint review

Det som fungerade bra:

- Spelet gick att spela från start till slut.
- Hacker-meddelandet gjorde temat tydligt direkt.
- Slutskärmen visade resultatet på ett tydligt sätt.
- Säkerhetsinnehållet blev konkret och lätt att förstå.

Det som kan förbättras:

- Frågorna kan slumpas.
- Spelet kan få svårighetsgrader.
- En topplista kan läggas till.
- Automatiska Pester-tester kan läggas till senare.
