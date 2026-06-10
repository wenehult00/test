# Product Vision

## Produktnamn

Ransomware Escape Room

## Vision

Vi vill skapa ett terminalbaserat escape room-spel i PowerShell där spelaren lär sig om ransomware genom att klara ett tidspressat prov. Spelet ska vara enkelt att köra, lätt att förstå och tydligt kopplat till verkliga säkerhetssituationer.

Vår vision är:

> Ett kort och pedagogiskt PowerShell-spel där elever lär sig hur man känner igen, förebygger och reagerar på ransomware.

## Problem vi vill lösa

Ransomware kan kännas abstrakt om man bara läser om det. Vi gör ämnet mer praktiskt genom att låta spelaren hamna i ett fiktivt scenario där filerna är krypterade och systemet bara kan återställas genom rätt säkerhetskunskap.

Exempel:

- Vad är ransomware?
- Vad gör man först vid misstänkt ransomware?
- Varför är säkerhetskopior viktiga?
- Hur sprids ransomware ofta?
- Varför ska man vara försiktig med okända bilagor?

## Målgrupp

Målgruppen är elever som lär sig PowerShell och grundläggande IT-säkerhet. Spelet ska också vara möjligt att visa för en lärare vid redovisning.

## Mål

- Spelet ska kunna startas från `Start-Game.ps1`.
- Spelet ska visa ett tydligt ransomware-tema.
- Spelet ska innehålla 5 frågor med 3 svarsalternativ.
- Spelaren ska behöva svara rätt för att gå vidare.
- Fel svar ska ge feedback och +10 sekunders tidstillägg.
- Spelet ska mäta faktisk tid och total sluttid.
- Koden ska vara uppdelad i moduler.
- Koden ska vara enkel nog att vi kan förklara den muntligt.

## Avgränsningar

Vi bygger inte ett grafiskt spel. Spelet körs i PowerShell-terminalen. Vi använder inga externa paket eller databaser. Vi fokuserar på ett fungerande skolprojekt, inte på ett stort kommersiellt spel.

## Definition of Done

En del av projektet räknas som klar när:

- funktionen fungerar i PowerShell
- koden är enkel och kommenterad vid behov
- fel hanteras med tydligt meddelande där det behövs
- funktionen passar in i ransomware-temat
- dokumentationen är uppdaterad
