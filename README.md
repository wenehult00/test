# Ransomware Escape Room

Ransomware Escape Room är ett interaktivt CLI-spel i PowerShell. Spelet börjar med ett dramatiskt hacker-meddelande där spelaren får veta att filerna har blivit krypterade. För att återställa systemet måste spelaren svara rätt på 5 frågor om ransomware.

Tonen är spännande, men innehållet är skol- och utbildningsanpassat. Spelet lär ut hur ransomware fungerar, hur man reagerar på en misstänkt attack och hur man minskar risken att förlora data.

## Vad spelet gör

- Visar ett hacker-meddelande i terminalen.
- Startar ett ransomware-prov med 5 frågor.
- Varje fråga har 3 svarsalternativ: A, B och C.
- Spelaren måste svara rätt för att gå vidare.
- Fel svar ger tydlig feedback och samma fråga kommer igen.
- Aktuell tid visas före varje fråga.
- När alla frågor är avklarade visas en slutskärm med resultat.
- Färdiga resultat sparas i en scoreboard så flera spelare kan ha egna resultat.

## Starta spelet

Öppna PowerShell i projektmappen och kör:

```powershell
.\Start-Game.ps1
```

Om PowerShell stoppar skriptet på grund av execution policy kan man tillfälligt tillåta skript i samma terminalsession:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## Tidsmätning

Spelet mäter tiden från att ransomware-provet börjar tills alla 5 frågor är avklarade.
Under spelets gång visas aktuell total tid före varje fråga, till exempel `Tid just nu: 01:25`.

Slutresultatet visar:

- faktisk tid
- antal fel
- tidstillägg
- total sluttid

Varje fel svar ger `+10 sekunder`. Sluttiden räknas så här:

```text
total sluttid = faktisk tid + tidstillägg
```

Målet är att klara spelet så snabbt som möjligt.

## Scoreboard

Färdiga resultat sparas i `data/scoreboard.json`. Huvudmenyn har valet `2. Visa scoreboard`, som visar flera spelares resultat sorterade efter snabbaste total sluttid.

Scoreboarden visar:

- placering
- spelarnamn
- sluttid
- antal fel
- tidstillägg
- datum och tid när resultatet sparades

## Säkerhetskunskaper

Spelet tränar:

- vad ransomware är
- varför man ska koppla bort en misstänkt dator från nätverket
- varför man ska kontakta IT eller ansvarig person
- varför säkerhetskopior är viktiga
- hur phishingmejl och skadliga bilagor kan sprida ransomware
- varför okända bilagor ska hanteras försiktigt

## Projektstruktur

```text
Ransomware Escape Room
|-- Start-Game.ps1
|-- modules
|   |-- GameEngine.psm1
|   |-- SaveSystem.psm1
|   |-- SecurityChallenges.psm1
|   `-- UI.psm1
|-- data
|   |-- questions.json
|   |-- rooms.json
|   |-- savegame.json
|   `-- scoreboard.json
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

`GameEngine.psm1` innehåller huvudlogiken: meny, nytt spel, scoreboard, timer, tidstillägg och slutresultat.

`SecurityChallenges.psm1` innehåller ransomware-frågorna och quizflödet.

`SaveSystem.psm1` sparar senaste spel i `data/savegame.json` och flera färdiga resultat i `data/scoreboard.json`.

`UI.psm1` visar titel, hacker-meddelande, frågerubriker, aktuell timer, scoreboard, feedback och slutskärm med färger.

## Skoluppgiftens krav

Projektet uppfyller kraven genom att:

- vara ett modulärt PowerShell-projekt
- startas från `Start-Game.ps1`
- använda flera `.psm1`-moduler med tydliga ansvarsområden
- använda interaktiv input i terminalen
- hantera ogiltig input utan att krascha
- använda `try/catch` vid start, sparning och viktiga spelsteg
- spara resultat i JSON, inklusive flera spelare i en scoreboard
- ha dokumentation och manuell testplan
- koppla spelets innehåll till verkliga IT-säkerhetskunskaper om ransomware
