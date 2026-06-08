# Sprint Retrospective

## Vad gick bra?

- Vi fick en tydlig projektstruktur tidigt.
- Det blev lättare att jobba när vi delade upp koden i moduler.
- JSON-sparningen gjorde spelet mer komplett.
- UI-förbättringarna gjorde att spelet kändes mer som ett escape room.
- GitHub Projects hjälpte oss att se vilka Issues som var kvar.

## Vad gick mindre bra?

- I början blandade vi quiz-logik och escape room-känsla för mycket.
- Vissa funktionsnamn och datastrukturer ändrades under arbetet, vilket gjorde att modulerna behövde kopplas ihop igen.
- Vi behövde testa sparfilen flera gånger eftersom `currentRoom` först användes som text och senare som nummer.

## Vad lärde vi oss?

- PowerShell-moduler gör projekt lättare att dela upp.
- `ConvertTo-Json` och `ConvertFrom-Json` är användbara för enkel sparning.
- Felhantering med `try/catch` gör spelet bättre för användaren.
- UI i terminalen handlar mycket om tydligt språk, färger och radbrytningar.
- Det är viktigt att testa hela flödet, inte bara en funktion i taget.

## Vad skulle vi göra annorlunda nästa gång?

- Bestämma datastrukturen för sparfilen tidigare.
- Skriva User Stories innan vi börjar koda.
- Testa varje modul direkt när den är klar.
- Göra en enkel checklista för redovisningskraven från början.

## Fortsatt utveckling

Om vi fortsätter projektet vill vi:

- lägga till fler rum
- lägga till slumpade frågor
- skapa automatiska tester med Pester
- lägga till ett val för att återställa sparfilen från huvudmenyn
- göra en lärarvy som visar vilka säkerhetsområden spelet täcker
