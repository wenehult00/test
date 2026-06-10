# Manuell Testplan

Den här testplanen används för att kontrollera att Ransomware Escape Room fungerar inför redovisning.

## Test 1: Starta spelet

Steg:

1. Öppna PowerShell i projektmappen.
2. Kör `.\Start-Game.ps1`.

Förväntat resultat:

Spelet visar rubriken `RANSOMWARE ESCAPE ROOM` och en huvudmeny med:

1. Nytt spel
2. Visa scoreboard
3. Avsluta

## Test 2: Starta nytt spel

Steg:

1. Välj `1. Nytt spel`.
2. Skriv ett spelarnamn.

Förväntat resultat:

Spelet visar ett hacker-meddelande om att filerna är krypterade och berättar att 5 frågor måste klaras.
Tiden börjar räknas när quizet startar efter hacker-meddelandet.

## Test 3: Svara rätt på en fråga

Steg:

1. Läs första ransomware-frågan.
2. Välj rätt alternativ.

Förväntat resultat:

Spelet visar positiv feedback och går vidare till nästa fråga.
Före nästa fråga visas aktuell tid, antal fel och tidstillägg.

## Test 4: Svara fel på en fråga

Steg:

1. Starta en fråga.
2. Välj ett felaktigt alternativ.

Förväntat resultat:

Spelet visar varför svaret var fel, lägger till `+10 sekunder` och visar samma fråga igen.
När samma fråga visas igen ska timern visa uppdaterat antal fel och uppdaterat tidstillägg.

## Test 5: Ogiltig input i huvudmenyn

Steg:

1. Starta spelet.
2. Skriv till exempel `x` i huvudmenyn.

Förväntat resultat:

Spelet visar ett tydligt felmeddelande och kraschar inte.

## Test 6: Ogiltig input i en fråga

Steg:

1. Gå in i quizet.
2. Skriv till exempel `9` eller `hej`.

Förväntat resultat:

Spelet säger att man ska välja A, B eller C och kraschar inte. Ogiltig input ger inget tidstillägg.

## Test 7: Spela hela spelet

Steg:

1. Starta ett nytt spel.
2. Svara rätt på alla fem frågor.

Förväntat resultat:

Spelet visar en tydlig slutskärm med:

- ett avslutande hacker-meddelande om att filerna släpps
- dekrypteringsrader
- `BRA JOBBAT! DU KLARADE DET!`
- `Systemet är återställt.`
- `Dina filer är dekrypterade.`
- faktisk tid
- antal fel
- tidstillägg
- total sluttid

## Test 8: Kontrollera tidstillägg

Steg:

1. Starta ett nytt spel.
2. Svara fel två gånger totalt.
3. Slutför spelet.

Förväntat resultat:

Slutskärmen visar `Antal fel: 2` och `Tidstillägg: +0 minuter och 20 sekunder`.

## Test 9: Spara resultat i scoreboard

Steg:

1. Slutför spelet.
2. Öppna `data/scoreboard.json`.

Förväntat resultat:

Scoreboarden innehåller en ny post med:

- `playerName`
- `completedAt`
- `actualTimeSeconds`
- `wrongAnswers`
- `penaltySeconds`
- `totalTimeSeconds`

## Test 10: Spara flera spelare

Steg:

1. Slutför ett spel som en spelare.
2. Slutför ett nytt spel som en annan spelare.
3. Öppna `data/scoreboard.json`.

Förväntat resultat:

Båda resultaten finns kvar. Det nya resultatet har lagts till utan att det gamla skrivs över.

## Test 11: Visa scoreboard

Steg:

1. Slutför minst ett spel.
2. Starta spelet igen.
3. Välj `2. Visa scoreboard`.

Förväntat resultat:

Spelet visar scoreboarden med placering, spelarnamn, sluttid, antal fel, tidstillägg och sparad tid.

## Test 12: Scoreboard sorteras rätt

Steg:

1. Lägg in eller spela fram minst två resultat med olika `totalTimeSeconds`.
2. Välj `2. Visa scoreboard`.

Förväntat resultat:

Resultatet med lägst total sluttid visas överst.
