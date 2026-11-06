# Documentation du jeu de données — Projet Householder

## Nature des données
Les données de ce projet sont entièrement SIMULÉES à des fins pédagogiques.
Elles ne proviennent ni d'une pharmacie, ni d'un hôpital, ni d'un système de santé réel.
Elles ne doivent pas être présentées comme des observations réelles.

## Périmètre
- 8 médicaments : Paracétamol, Amoxicilline, Ibuprofène, Metformine,
  Amlodipine, Oméprazole, Fer + acide folique et SRO.
- 24 mois : de janvier 2024 à décembre 2025.
- 192 observations : 8 médicaments × 24 mois.

## Fichiers
1. `donnees_medicaments_8x24_simulees.csv`
   Tableau combiné contenant les consommations et les informations de stock.
2. `donnees_stocks_8_medicaments_24_mois.csv`
   Tableau séparé contenant les informations relatives aux stocks.
   Il reprend les mêmes observations que le tableau combiné.

## Variables du tableau combiné
- `Mois` : mois de l'observation, au format AAAA-MM.
- `Medicament` : nom du médicament.
- `Consommation` : quantité consommée pendant le mois (unités simulées).
- `Stock_initial` : quantité disponible au début du mois.
- `Approvisionnement` : quantité reçue pendant le mois.
- `Stock_final` : quantité restante à la fin du mois.

## Variables du fichier de stocks
- `Mois` : mois de l'observation, au format AAAA-MM.
- `Medicament` : nom du médicament.
- `Stock_initial` : quantité disponible au début du mois.
- `Approvisionnement` : quantité reçue pendant le mois.
- `Stock_final` : quantité restante à la fin du mois.

## Règle de calcul des stocks
Pour chaque médicament et chaque mois :
`Stock_final = Stock_initial + Approvisionnement - Consommation`

Le stock initial du mois suivant correspond au stock final du mois précédent.

Les quantités sont des unités fictives de stock/consommation ; elles ne représentent
pas des posologies ni des recommandations médicales.

## Hypothèses et limites
- Les niveaux de consommation et d'approvisionnement ont été construits artificiellement
  pour illustrer des profils de demande différents.
- Ces données permettent de pratiquer l'importation, l'exploration, la régression,
  la factorisation QR et une démonstration de règles simples d'alerte de stock.
- Les résultats obtenus ne constituent pas une validation sur des données réelles.
- Pour une application réelle, il faudrait des historiques vérifiés, les délais
  d'approvisionnement, les dates de commande, les pertes/péremptions et les unités
  de conditionnement.

## Utilisation dans RStudio
Depuis la racine du projet :
`donnees <- read.csv("data/donnees_medicaments_8x24_simulees.csv")`

Pour importer uniquement les stocks :
`stocks <- read.csv("data/donnees_stocks_8_medicaments_24_mois.csv")`
