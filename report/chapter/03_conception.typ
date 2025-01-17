= Processus de Conception

== Étapes initiales de conception

=== Recherche des composants

Pour chercher et choisir nos composants, nous utilisons principalement #link("https://www.mouser.ch")[Mouser] qui propose une large sélection de composants électroniques.
Leur système de recherche nous permet de filtrer les composants afin de les faire concorder à nos contraintes.
De plus, c'est sur ce site que nous avons commandé nos composants.

Lorsqu'un composant paraissait convenir aux exigences données, nous investiguions plus en détail leurs _datasheets_.
Celle-ci présente en général des circuits d'exemple d'utilisations, où nous pouvons venir voir quels sont les autres composants électroniques nécessaires au bon fonctionnement du système.
Il est important de noter que nous avions déjà tous les composants élémentaires de la norme _E24_.

=== Création des composants sur Altium

Les composants que nous avons choisis ne se trouvaient généralement pas dans les librairies d'Altium.
Pour pallier cela, nous avons dû créer nos propres composants sur Altium.
Il s'agit, entre autres, de créer un schéma pratique et lisible pour leurs utilisations futures.
En commençant par la taille des composants ainsi que les pins qui lui sont attribués.


== Étapes de conception du PCB

=== Création du schéma électronique détaillé

Pour créer le schéma électronique, nous l'avons séparé en plusieurs parties.
Chaque partie concerne un des composants principaux et le circuit pour qu'il fonctionne.
Par exemple, notre gestionnaire de tension nécessite un circuit bien précis autour de lui pour qu'il soit configuré et ajusté à certaines valeurs.
Il utilise, entre autres, des résistances, des condensateurs et une led.

Les librairies qu'offre Altium proposent déjà les composants de norme _E24_, ceux-là ont pu être directement utilisés pour faire nos circuits.
Une partie du schéma électronique réalisée, une première vérification se faisait avec les professeurs.

=== Mise en place des règles Eurocircuits

#link("https://www.eurocircuits.com/")[Eurocircuits] est le site sur lequel nous avons commandé nos PCB.
Il utilise des machines qui soumettent des contraintes à respecter pour le PCB.
Telle que la taille minimum d'un trou, la marge entre chaque route ou bien l'espacement entre chaque composant.
Celles-ci sont données sur leur site internet.

=== Routage des composants

Le routage des composants consiste à poser tous les composants décrits dans le schéma électronique de façon à ce qu'ils se connectent à leur voisin sans problème.
La petite taille de notre plaque était un défi à part entière, car, au vu du nombre de composants dans notre circuit, il a été compliqué de tous les rentrer dedans.
La liaison entre les composants se fait à l'aide de pistes de cuivre vernies d'un revêtement protecteur.

=== Montage du PCB

Pour monter le PCB, nous avons effectué les étapes suivantes :

- application de la pâte à souder à l'aide du _stencil_
- positionnement des composants SMD (montés en surface) avec un _pick-and-place manuel_
- chauffage de la pâte à souder avec un four de refusion (_reflow oven_)
- soudure manuelle des composants traversants (_through-hole_)
- inspection visuelle à l'aide d'un microscope pour détecter les défauts éventuels

== Activités post-conception

=== Mesures et tests du PCB

Pour finir, nous avons effectué une série de tests pour démontrer le bon fonctionnement de notre PCB.
À commencer par des tests sur les tensions de sortie ainsi que sur le courant.
La protection de la batterie aussi a été mise en tests, afin de ne pas en abîmer.

Pour cela, nous utilisons un générateur, un oscilloscope ainsi qu'un multimètre.

