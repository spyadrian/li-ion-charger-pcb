= Processus de Conception

== Étapes initiales de conception

=== Recherche des composants

Pour chercher et choisir nos composants, nous utilisons principalement #link("https://www.mouser.ch")[Mouser] qui propose une large sélection de composants électroniques.
Leurs système de recherche nous permet de filtrer les composants afin de les faire concorder à nos contraintes.
De plus, c'est sur ce site que nous comandons nos composants.

Lorsqu'un composant paraissait convenir aux exigences données, nous investiguions plus en détail leurs _datasheets_.
Celles-ci présente en générale des circuits d'example d'utilisations, où nous pouvons venir voir qu'elles sont les autres composants nécéssaire électroniques nécéssaire au bon fonctionnement du système.
Il est important de noter que nous avions déjà tous les composants élémentaire de norme _E24_.

=== Création des composants sur Altium

Les composants que nous avons choisis ne se trouvaient généralement pas dans les libraries d'Altium.
Pour palier cela, nous avons dû créer nos propre composants sur Altium.
Il s'agit, entre-autre, de créer un schéma pratique et lisible pour leurs utilisations future.
En commençant par le taille de composants ainsi que les pins qui lui sont attribuées.

// TODO: ajouter image d'example


== Étapes de conception du PCB

=== Création du schéma éléctronique détaillé

Pour créer le schéma éléctronique, nous l'avons séparer en plusieurs partie.
Chaques partie concerne un des composants principal et le circuit pour qu'il fonctionne.
Par example, notre gestionnaire de tension nécessite un circuit bien précis autours de lui pour qu'il soi configurer et ajuster certaine valeur.
Il utilise, entre-autre, des résistances, des condensateurs et une led.

Les libraries que proposent Altium propose déjà les composants de norme _E24_, ceux-là on pu être directement utilisé pour faire nos circuits.
Une partie du schéma électroniques réalisé, une première vérification se faisait avec les professeurs.

=== Mise en place des règles Eurocircuits

#link("https://www.eurocircuits.com/")[Eurocircuits] est le site sur lequel nous avons commandé nos PCB.
Il utilise des machines qui soumettent des contraintes à respecter pour le PCB.
Tels que la taille minimum d'un trou, la marge entre chaque route ou bien l'espacement entre chaque composants.
Celles-ci sont données sur leurs site internet.

=== Routage des composants

Le routage des composants consiste à poser tous les composants décrits dans le schéma éléctronique de façon à ce qu'il se connecte à leurs voisin sans problème.
La petite taille de notre plaque était un défi à par entière, car, au vu, du nombre de composants dans notre circuits, il a été compliqué de tous les rentrer dedans.
La liaison entre les composants se fait à l'aide de piste de cuivre vernie d'un revêtement protecteur.

=== Montage du PCB

Pour monter le PCB, nous avons éffectué les étapes suivante :

- application de la pâte à souder à l'aide du _stencil_
- positionnement des composants SMD (montés en surface) avec un _pick-and-place manuel_
- chauffage de la pâte à souder avec un four de refusion (_reflow oven_)
- soudure manuelle des composants traversants (_through-hole_)
- inspection visuelle à l'aide d'un microscope pour détecter les défauts éventuels

== Activités post-conception

=== Mesures et tests du PCB

Pour finir, nous avons éffectué une serie de tests pour démontrer le bon fonctionnement de notre PCB.
À commencer par des tests sur les tensions de sortie ainsi que des sur le sont courant.
La protection de la batterie aussi a été mise en tests, afin de ne pas en abimé.

Pour cela, nous utilisons un générateur, un oscilloscope ainsi qu'un multimètre.
