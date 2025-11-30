# Entrainement-aux-Algorithmes
Ce répertoire contient différents exercices réalisés durant ma formation au Campus Numérique In The Alps.
Les exercices de ce répertoire sont réalisés avec Java sur Processing.

## Dessine-moi un mouton
L'objectif de cet exercice était de nous familiariser avec les fonctions et les outils de dessin spécifiques à Java.

## Go Toto
Cet exercice nous a permis d'apprendre à bien définir les étapes nécessaires pour faire avancer Toto sans le mouiller.

## Création d'un démineur 
Nous nous sommes servis de nos connaissances algorithmiques pour coder un démineur  à l'aide de boucles et de conditions, organisées dans des fonctions pour une meilleure organisation du code.

## Le jeu de l'oie
Programmer un jeu de l'oie en respectant les conditions spécifiques des cases.

### consignes :
CONDITION DE VICTOIRE

Pour gagner une partie, il faut être le premier à arriver sur la case 63. Plateau de jeu
Obligation d’arriver pile sur la case 63. Si le score au dés est supérieur au nombre de cases le séparant de la victoire, il devra reculer d’autant de cases supplémentaires. Exemple : Le joueur est en case 60. Il lance les dés et obtient 10. Le joueur devra retourner à la case 56 (60 + 3 - 7 = 56) ) 

RÈGLES SPÉCIALES AU COMMENCEMENT DU  JEU

Si l’un des joueurs fait 9 par 6 et 3, il doit avancer son pion immédiatement au nombre 26
S’il fait 9 par 4 et 5, il ira au nombre 53.
Si un joueur fait 6, il doit se rendre sur la case 12.


CASES SPÉCIALES SUR LE PLATEAU

Des oies sont placées en cases 9, 18, 27, 36, 45 et 54. Le joueur qui y  tombe avance de nouveau du nombre de points réalisé.
Un hôtel en case 19. Un joueur qui y tombe passe ses 2 prochains tours.
Un puits en case 3. Si un joueur tombe dessus, il devra attendre qu’un autre joueur arrive au même numéro. L’autre joueur tombera dans le puits et devra attendre d’être secouru. 
Un labyrinthe en case 42. Le joueur se perd et devra retourner en case 30. 
Une prison en case 52. Si un joueur tombe dessus, il devra attendre qu’un autre joueur vienne le libérer.
Une tête de mort en case 58. Le joueur qui y tombe recommence la partie depuis le début.


INTERACTION ENTRE JOUEURS

Celui qui est rejoint par un autre joueur sur la même case devra se rendre sur la case ou l’autre joueur se trouvait avant de jouer.


## Exercice bonus : le livreur de pizza
Nous avons appliqué nos connaissances pour aider un livreur de pizza à gérer sa journée de travail.

### consignes :
Un livreur de pizzas charge son scooter avec les pizzas à livrer.

A chaque livraison, le nombre de pizzas baisse pour revenir à la pizzeria à vide.

Voici le nombre de pizzas au départ, après chacune des livraisons et à l’arrivée :

13      	11      	8         	7         	5         	3         	0

Ecrire un programme qui affiche le nombre de pizzas au départ et le nombre de pizzas déposées à chaque livraison.

Livraison 1 = > x pizzas

A l’aide d’une fonction, calculer le prix de chacune des livraisons avec la règle suivante :

Les pizzas sont vendues 10 € l’unité

Les frais de livraison sont à 3€ par livraison mais sont offerts si l’on a commandé au moins 3 pizzas

Adapter le programme pour afficher le prix pour chaque livraison

Calculer et afficher le montant des ventes de la tournée
