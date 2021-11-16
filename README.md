## Vue d'ensemble



Voici le dépot Git pour le test technique de Weekendr.

Il possède les éléments suivants :


<ul>
<li>sql_ex1.txt : La réponse à la question 1 de l'exercice SQL</li>
<li>sql_ex2.txt : La réponse à la question 2 de l'exercice SQL</li>
<li>week_schedule_front : Le répertoire contenant le front de l'exercice 2, en NextJS</li>
<li>WeekScheduleApi : Le répertoire contenant le back de l'exercice 2, en Ruby on Rails</li>
</ul>


## Détail de la réponse à la question 1 de l'exercice SQL



La stratégie globale consiste à récupérer pour un même house_name (ligne 5 : WHERE b2.house_name = b.house_name) 

l'ensemble des entrées dont il y aurait chevauchement d'un date avec une autre, que cela soit le start_date ou le end_date ( Bloc AND entre 

les lignes 6 et 11 ). On exclue  la comparaison des dates d'une entrée avec elle même (Ligne 15 : b2.id != b.id).

La condition ligne 12 permet de selectionner la plage de réservation la plus courte pour être suprimée.

La condition ligne 13 permet en cas d'égalité de la durée de réservation, de supprimer la plus ancienne.


Le SELECT 1 FROM (ligne 5) permet de créer une colonne virtuelle constituée de 1. On ajoute un 1 si l'ensemble des consitions est réunie.

Elle est utilisée à des fins d'optimisation au lieu de faire un SELECT * et donc de rapatrier l'ensemble des données de la base de données.



 ## Détail de la réponse à la question 2 de l'exercice SQL



On émet l'hypothèse qu'il n'y a aucun chevauchement entre les dates. On peut par ailleurs considérer que l'on a éxécuté la requête de la question 1.


L'approche utilisée est la suivante. Pour chaque house_name, on prends la end_date de chaque réservation, on va récupérer la start_date de la réservation

suivante. En effet, l'intervalle entre la end_date et la start_date du voyage suivant est un intervalle de date libre. Pour récupérer la start_date suivant le end_date du

voyage précédent, on va effectuer une jointure (ligne 8) pour prendre l'ensemble des start_date postérieures à laend_date. Puis on prends le minimum.

( via le MIN(free_end) ). On fait cette opération pour chaque house_name et fin de date d'un voyage (avec la ligne 10, GROUP BY).


Une fois que l'on a l'ensemble des crénaux disponibles, on va enlever ceux qui dont l'intervale est inférieure à 5 jours ( ligne 12 ).

On effectue une jointure afin d'appliquer les conditions sur l'intervalle de la durée libre, et l'appliquer sur chaque house_name.



 ## Détail de la réponse à l'exercice 2


NB : Par soucis de place et practicité, les nodes_modules du dossier front on été supprimés. Le dossier tmp du back a été vidé.


### Partie Back :

L'application Ruby on Rails a été crée en mode API, permettant de reduire le nombre de modules embarqués. Les fichiers modifiés sont notamments

dans le dossier models et dans controller/API/v1. La base de donnée utilisée est PostgreSQL.

Il faut lancer le server rails avec le port 3001 ( rails server -p 3001 )

### Partie Front :

 Les instructions sont affichés dans le index.js



On pourra utiliser curl pour ajouter des plages horaires et voir le résultat sur le front.
