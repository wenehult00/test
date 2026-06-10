# Daily Standups

Det här är våra reflektioner från arbetet. Vi skriver som en elevgrupp och använder standup-frågorna: Vad gjorde vi? Vad ska vi göra? Finns det hinder?

## Standup 1: Projektstart

Gjort:

- Vi bestämde idén Ransomware Escape Room.
- Vi skapade grundstrukturen med `Start-Game.ps1`, `modules`, `data`, `docs` och `tests`.
- Vi pratade om vilka säkerhetsområden spelet skulle ta upp.

Plan:

- Bygga spelmotorn.
- Skapa en huvudmeny.
- Göra första versionen av utmaningarna.

Hinder:

- Vi behövde hålla nivån lagom enkel så att alla i gruppen kunde förstå PowerShell-koden.

## Standup 2: Spelmotor och sparning

Gjort:

- Vi byggde `GameEngine.psm1`.
- Vi lade till nytt spel, visa scoreboard och avsluta.
- Vi skapade `SaveSystem.psm1` för JSON-sparning.

Plan:

- Koppla ihop spelmotorn med ransomware-frågorna.
- Testa att slutresultatet sparas.

Hinder:

- Vi behövde bestämma vilka fält sparfilen skulle ha för tid, fel och tidstillägg.

## Standup 3: Säkerhetsutmaningar

Gjort:

- Vi skapade fem ransomware-frågor.
- Varje fråga fick tre svarsalternativ.
- Fel svar fick feedback och +10 sekunders tidstillägg.

Plan:

- Göra feedbacken tydligare.
- Få spelet att kännas som ett ransomware-scenario, inte bara ett vanligt quiz.

Hinder:

- Det var lätt att skriva för långa texter. Vi fick korta ner så spelet fortfarande känns snabbt i terminalen.

## Standup 4: UI och upplevelse

Gjort:

- Vi förbättrade rubriker, meny och slutskärm.
- Vi lade till hacker-meddelande, färger och tydliga linjer i terminalen.
- Vi visade faktisk tid, antal fel, tidstillägg och total sluttid.
- Vi lade till en scoreboard så flera spelare kan jämföra sluttider.

Plan:

- Testa hela spelet från start till slut.
- Skriva klart dokumentationen.

Hinder:

- Vi behövde kontrollera att UI-förbättringarna inte gjorde koden för komplicerad.

## Standup 5: Test och dokumentation

Gjort:

- Vi testade huvudflödet.
- Vi kontrollerade att spelet kan startas från `Start-Game.ps1`.
- Vi skrev dokumentation för produktvision, sprint review, retrospective, ADKAR och manuell testning utifrån ransomware-temat.

Plan:

- Redovisa projektet.
- Visa hur GitHub Projects användes med User Stories och Issues.

Hinder:

- Inga större hinder kvar, men vi skulle gärna lägga till automatiska tester om vi hade mer tid.
