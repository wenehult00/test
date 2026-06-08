# Product Vision

## Produktnamn

Security Escape Room

## Vision

Vi vill skapa ett terminalbaserat escape room-spel i PowerShell där spelaren lär sig grundläggande IT-säkerhet genom att lösa fem rum. Spelet ska vara enkelt att köra, lätt att förstå och tydligt kopplat till verkliga säkerhetssituationer.

Vår vision är:

> Ett kort och pedagogiskt PowerShell-spel där elever lär sig säkerhetsbeslut genom att spela, inte bara genom att läsa teori.

## Problem vi vill lösa

IT-säkerhet kan kännas abstrakt om man bara läser om det. Vi ville göra det mer praktiskt genom att låta spelaren hamna i situationer där man måste välja rätt åtgärd.

Exempel:

- Ska man klicka på en länk i ett stressande mejl?
- Vad gör man med en MFA-notis man inte själv startat?
- Är det okej att stoppa in ett okänt USB-minne?
- När ska man rapportera en misstänkt incident?

## Målgrupp

Målgruppen är elever som lär sig PowerShell och grundläggande IT-säkerhet. Spelet ska också vara möjligt att visa för en lärare vid redovisning.

## Mål

- Spelet ska kunna startas från `Start-Game.ps1`.
- Spelet ska ha en tydlig huvudmeny.
- Spelet ska ha fem escape room-rum.
- Spelet ska ge tydlig feedback efter spelarens val.
- Spelet ska spara progress i JSON.
- Koden ska vara uppdelad i moduler.
- Koden ska vara enkel nog att vi kan förklara den muntligt.

## Avgränsningar

Vi bygger inte ett grafiskt spel. Spelet körs i PowerShell-terminalen. Vi använder inga externa paket eller databaser. Vi fokuserar på ett fungerande skolprojekt, inte på ett stort kommersiellt spel.

## Definition of Done

En del av projektet räknas som klar när:

- funktionen fungerar i PowerShell
- koden är enkel och kommenterad vid behov
- fel hanteras med tydligt meddelande där det behövs
- funktionen passar in i spelets escape room-känsla
- dokumentationen är uppdaterad
