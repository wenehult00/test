# Manuell Testplan

Den här testplanen används för att kontrollera att Security Escape Room fungerar inför redovisning.

## Test 1: Starta spelet

Steg:

1. Öppna PowerShell i projektmappen.
2. Kör `.\Start-Game.ps1`.

Förväntat resultat:

Spelet visar rubriken `SECURITY ESCAPE ROOM` och en huvudmeny med:

1. Nytt spel
2. Fortsätt sparat spel
3. Avsluta

## Test 2: Starta nytt spel

Steg:

1. Välj `1. Nytt spel`.
2. Skriv ett spelarnamn.

Förväntat resultat:

Spelet välkomnar spelaren och visar första rummet, Phishing Room.

## Test 3: Svara rätt i Phishing Room

Steg:

1. Läs scenariot.
2. Välj alternativet som säger att man ska kontrollera avsändaren och gå själv till den riktiga inloggningssidan.

Förväntat resultat:

Spelet visar positiv feedback, dörren låses upp och poängen ökar med 10.

## Test 4: Svara fel i ett rum

Steg:

1. Starta ett rum.
2. Välj ett osäkert alternativ.

Förväntat resultat:

Spelet visar tydlig negativ feedback och rummet är fortfarande låst. Spelaren får försöka igen.

## Test 5: Spara progress

Steg:

1. Lös minst ett rum.
2. Öppna `data/savegame.json`.

Förväntat resultat:

Sparfilen innehåller uppdaterade värden för:

- `playerName`
- `currentRoom`
- `score`
- `completedRooms`
- `lastSaved`

## Test 6: Fortsätt sparat spel

Steg:

1. Starta spelet igen.
2. Välj `2. Fortsätt sparat spel`.

Förväntat resultat:

Spelet fortsätter från det rum som står i sparfilen.

## Test 7: Ogiltig input i huvudmenyn

Steg:

1. Starta spelet.
2. Skriv till exempel `x` i huvudmenyn.

Förväntat resultat:

Spelet visar ett tydligt felmeddelande och kraschar inte.

## Test 8: Ogiltig input i säkerhetsutmaning

Steg:

1. Gå in i ett rum.
2. Skriv till exempel `9` eller `hej`.

Förväntat resultat:

Spelet säger att man ska välja 1, 2 eller 3 och returnerar till rummet utan att krascha.

## Test 9: Spela hela spelet

Steg:

1. Starta nytt spel.
2. Lös alla fem rum.

Förväntat resultat:

Spelet visar ett slutmeddelande, slutpoäng 50 och att 5 av 5 rum är avklarade.

## Test 10: Trasig sparfil

Steg:

1. Gör en kopia av `data/savegame.json`.
2. Skriv medvetet fel JSON i `data/savegame.json`.
3. Starta spelet och välj fortsätt sparat spel.
4. Lägg tillbaka den fungerande kopian efter testet.

Förväntat resultat:

Spelet visar ett tydligt felmeddelande om att sparfilen inte kan laddas eller att JSON är trasig.
