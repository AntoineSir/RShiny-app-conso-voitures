# Exemple d'application RShiny : consommation et émissions de Co2 de modèles de voitures françaises en 2014  

Cette application a été développée sous forme de package en suivant la méthodologie proposée par l'équipe de ThinkR (https://rtask.thinkr.fr/fr/notre-template-shiny-pour-concevoir-une-appli-prod-ready/). Pour lancer l'application, vous pouvez charger le package après avoir ouvert le projet R avec `devtools::load_all(".")` puis lancer `app.voitures::run_app()`.  
Cette application vise à illustrer des formations sur RShiny, le packaging en R et l'utilisation de Github. Elle est découpée en 3 parties :  

## Émissions de Co2 & consommation  
Cette première partie affiche un graphe des émissions de CO2 en fonction de la consommation des véhicules. L'utilisateur peut calibrer ce graphe en ne l'affichanty que pour certaines années des modèles, certaines marques, ou certains types de carburants. Il peut aussi ventiler l'affichage par type de carosserie, type de carburant, marque ou année du modèle. Le graphe n'est pas mis à jour instantanément lorsque les paramètres sont changés par l'utilisateur mais lorsqu'il clique sur un bouton d'exécution "Actualiser le graphique" une fois le paramétrage effectué. cette partie sert donc à illustrer en particulier les fonctions `eventreactive()` et `renderPlot()` de Shiny, ainsi que les différents widgets d'inputs utilisés.  

## Voir les données  
Cette partie, très simple, se contente d'afficher les données utilisées (et nettoyées par une fonction du package) et permet à l'utilisateur d'opérer des tris et des filtres sur la table. Elle illustre les fonctions `renderDataTable` (côté serveur) et `dataTableOutput` (côté ui).  

## Prédire ma consommation 
*En développement*
