# Daily Standups

Det här är våra reflektioner från arbetet. Vi skriver som en elevgrupp och använder standup-frågorna: Vad gjorde vi? Vad ska vi göra? Finns det hinder?

## Standup 1: Projektstart

Gjort:

- Vi bestämde idén Security Escape Room.
- Vi skapade grundstrukturen med `Start-Game.ps1`, `modules`, `data`, `docs` och `tests`.
- Vi pratade om vilka säkerhetsområden spelet skulle ta upp.

Plan:

- Bygga spelmotorn.
- Skapa en huvudmeny.
- Göra första versionen av rummen.

Hinder:

- Vi behövde hålla nivån lagom enkel så att alla i gruppen kunde förstå PowerShell-koden.

## Standup 2: Spelmotor och sparning

Gjort:

- Vi byggde `GameEngine.psm1`.
- Vi lade till nytt spel, fortsätt sparat spel och avsluta.
- Vi skapade `SaveSystem.psm1` för JSON-sparning.

Plan:

- Koppla ihop rummen med säkerhetsutmaningar.
- Testa att progress sparas efter varje rum.

Hinder:

- Vi behövde vara konsekventa med hur `currentRoom` sparas. Till slut valde vi ett nummer som visar vilket rum spelaren är på.

## Standup 3: Säkerhetsutmaningar

Gjort:

- Vi skapade fem säkerhetsutmaningar:
  - phishing
  - lösenord
  - MFA
  - USB
  - incidenthantering

Plan:

- Göra feedbacken tydligare.
- Få spelet att kännas mindre som quiz och mer som escape room.

Hinder:

- Det var lätt att skriva för långa texter. Vi fick korta ner så spelet fortfarande känns snabbt i terminalen.

## Standup 4: UI och upplevelse

Gjort:

- Vi förbättrade rubriker, menyer och poängvisning.
- Vi lade till tydligare meddelanden som `[UPPLÅST]` och `[LÅST]`.
- Vi gjorde rumsbeskrivningarna mer stämningsfulla.

Plan:

- Testa hela spelet från start till slut.
- Skriva klart dokumentationen.

Hinder:

- Vi behövde kontrollera att UI-förbättringarna inte gjorde koden för komplicerad.

## Standup 5: Test och dokumentation

Gjort:

- Vi testade huvudflödet.
- Vi återställde `savegame.json` till startläge.
- Vi skrev dokumentation för produktvision, sprint review, retrospective, ADKAR och manuell testning.

Plan:

- Redovisa projektet.
- Visa hur GitHub Projects användes med User Stories och Issues.

Hinder:

- Inga större hinder kvar, men vi skulle gärna lägga till automatiska tester om vi hade mer tid.
