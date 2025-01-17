= Résultats et Discussion


== Résultats des tests

=== Alimentation USB

Pour ce test, le circuit est branché directement via la sortie USB $5$V, c'est ce qui l'alimente.
Les sorties $3.3$V et $5$V sont connectées à des oscilloscopes qui permettent la mesure de la tension minimum, maximum et moyenne.
Nos tests ont démontré que le circuit a bien le comportement attendu lors de l'utilisation de la sortie USB $5$V.

Les sorties ont des valeurs de _peek-to-peek_ de $0.15$V ce qui n'est pas anormal.
La tension de la sortie $3.3$V est en moyenne à $3.25$V ce qui n'est pas optimal mais reste dans une marge d'erreur de $2%$.
Pour la sortie de $5$V, celle-ci est en moyenne à $5.03$V ce qui est parfait.

#figure(
  image("../image/graph_alim_usb_tension.png", width: 100%),

  caption: "Tensions d'entrée et de sortie lors d'une alimentation via USB 5V",
) <img_graph_alim_usb>

=== Charge de la batterie

La charge de la batterie a été testée en simulant la tension de la batterie.
Les tensions de sorties ainsi que la consommation de la batterie ont été mesurée lors de ce test et cela a permis de vérifier plusieurs points clefs du circuit.

La première observation que l'on peut faire se trouve au niveau des entrées du circuit.
Tout d'abord, on note que la consommation du circuit entre l'entrée USB et la batterie est très faible.
Elle consommerait en moyenne $5%$ du courant d'entrée, le reste étant utilisé pour charger la batterie.
Par la suite, on remarque que la charge de la batterie s'arrête au-delà de $4.2$V mais pas avant $2.8$V.
Cela est un problème majeur, car la batterie pourrait s'abimer en dessous de ce seuil.
La raison à cela est due à une erreur lors de la commande du gestionnaire de batterie.
Nous avons commandé le `MCP73831T-2DCI/OT` au lieu du `MCP73831T-2ACI/OT` et celui-ci ne contient pas de mode de protection, comme mis en évidence par la @img_graph_usb_bat.

#figure(
  image("../image/graph_charge_courant_usb_bat.png", width: 100%),

  caption: "Courant de l'entrée USB et de la batterie en fonction de la tension de la batterie",
) <img_graph_usb_bat>

La seconde observation se fait au niveau des sorties du circuit.
Celles-ci ont en général le comportement voulu, à l'exception de deux détails que l'on retrouve sur le graphique présent dans la @img_graph_charge_out.
Ces deux détails ne sont pas si embêtants, mais il est important de les notifier.

Premièrement, on s'aperçoit qu'en dessous de $3.2$V le comportement des sorties n'est pas identique.
La sortie $3.3$V est à zéro, tandis que la $5$V reprend la valeur de la tension d'entrée.
Cela peut paraitre assez étrange, car leurs régulateurs de tension sont les deux branchés à la même pin _EN_ mais cela s'explique dans leurs _datasheet_.
En effet, la sortie $3.3$V dépend principalement du régulateur de tension abaisseur.
Lorsque ça pin _EN_ est désactivé, il coupe sa sortie.
Pour le régulateur de tension élévateur qui régit la sortie $5$V ce n'est pas la même chose.
Lorsqu'il est désactivé, il laisse simplement passer la tension qu'il a en entrée.
Ceci est un détail auquel nous n'avions pas fait attention lors des choix des composants.

#figure(
  image("../image/graph_charge_out.png", width: 100%),

  caption: "Valeurs des sorties en fonction de la tension de la batterie",
) <img_graph_charge_out>

Le deuxième détail se trouve dans l'activation des sorties.
De nouveau, bien que la pin _EN_ des régulateurs de tension soient connectés de la même façon, les sorties se comportent différemment.
La sortie $3.3$V s'active lorsque la tension de sortie de la batterie est à $3$V alors que la sortie de $5$V s'active quand elle est à $3.2$V.
Nous n'avons pas réussi à expliquer cette légère différence, mais elle est tout de même présente dans notre circuit.

=== Décharge de la batterie

Afin de tester la décharge de la batterie, nous avons connecté un oscilloscope aux sorties capable de tirer un courant spécifié.
De l'autre côté, nous avons branché la batterie à un oscilloscope pouvant simuler une batterie à une tension donnée et capable de mesurer le courant tiré.
Les tensions de sortie ainsi que le courant utilisé par la batterie ont été les deux éléments principaux qui ont été observés lors de ce test.
Ces valeurs ont été mesurées dans $35$ différentes configurations différentes, données par la variation de la tension de la batterie entre $3.0$V et $4.2$V ainsi que le courant tiré par la sortie entre $100$mA et $500$mA.

Dans la @img_graph_decharge_tension_33, on peut voir les valeurs pour la sortie $3.3$V en fonction de la tension de la batterie.
Le graphique démontre bien que notre sortie arrive à fournir une tension de $3.3$V peu importe la charge tirée par celle-ci.
On constate quand même un pique lors de l'activation de la sortie à $500$mA et à $3.2$V en tension pour la batterie.
Ce pique est un comportement assez étrange, entre autres, dû au fait que la sortie se stabilise après coup.
Nous n'avons pas réussi à l'expliquer autrement que par ceci : c'est une erreur de mesure.

#figure(
  image("../image/graph_decharge_tension_33.png", width: 100%),

  caption: "Tension moyenne mesurée à la sortie 3.3V lors de la décharge",
) <img_graph_decharge_tension_33>

Le même graphique concernant la sortie $5$V est présent dans la @img_graph_decharge_tension_5.
Celui-ci souligne une conduite assez atypique du régulateur de tension élévateur.
En effet, on remarque que lorsque la tension de la batterie est à $3.2$V, le régulateur arrive à élever la tension à $5$V.
Mais lorsque l'on tire $500$mA, il n'y arrive plus.
La fiche technique du régulateur de tension indique qu'il peut fonctionner avec une tension aussi basse que $2.3$V.
Cependant, à des courants de sortie plus élevés, il demande des tensions d'entrée plus hautes.
Cela est certainement dû aux pertes internes du composant.

Il est bon de noter que si l'on compare ces deux graphiques, nous remarquons que la sortie $3.3$V s’active en même temps que la sortie $5$V, à l'exception du problème souligné au-dessus, lorsque l'on tire $500$mA.

#figure(
  image("../image/graph_decharge_tension_5.png", width: 100%),

  caption: "Tension moyenne mesurée à la sortie 5V lors de la décharge",
) <img_graph_decharge_tension_5>

La @img_graph_decharge_courant_tire_33 et @img_graph_decharge_courant_tire_5 récapitulent les valeurs du courant tiré sur la batterie en fonction de la tension de la batterie et du courant de sortie.
Ils permettent de comparer de manière visuelle la consommation du circuit entre les différents niveaux de la batterie.

#figure(
  image("../image/graph_decharge_courant_tire_33.png", width: 100%),

  caption: "Variation du courant tiré sur la batterie en fonction de sa tension et du courant de la sortie 3.3V",
) <img_graph_decharge_courant_tire_33>

Le graphique concernant la sortie $3.3$V montre que la consommation augmente en fonction de la tension de la batterie : plus elle est baisse, plus on consomme.
Évidemment, uniquement quand la sortie est activée.
Cette augmentation est négligeable lorsque l'on tire $100$mA mais drastique lorsqu'il s'agit de $500$mA, avec une différence de plus de $250$mA entre une tension de $3.2$V et $4.2$V.
En effet, lorsque la tension de la batterie diminue, le régulateur doit fournir plus de courant pour maintenir une puissance de sortie constante. 
Cela provoque une augmentation des pertes.
Son rendement réduit alors grandement.

#figure(
  image("../image/graph_decharge_courant_tire_5.png", width: 100%),

  caption: "Variation du courant tiré sur la batterie en fonction de sa tension et du courant de la sortie 5V",
) <img_graph_decharge_courant_tire_5>

De la même manière que pour celui de la sortie $3.3$V, le graphique sur la @img_graph_decharge_courant_tire_5 montre que la consommation augmente plus on tire de courant et plus la tension de la batterie est basse.
Le courant tiré sur la batterie le plus élevé est de $1$A, autrement dit un facteur deux par rapport à ce qui se trouve en sortie.

La puissance consommée par un circuit est donnée en watts par la relation :

$ P = V times I $

Celle-ci est utile pour calculer l'efficacité du circuit, ici en pourcentage :

$ mu = P_"utile" / P_"fournie" times 100 $

Dans notre cas, nous avons une efficacité qui alentour les $75%$ pour la sortie $3.3$V comme pour la $5$V.


== Problèmes rencontrés et Solutions

L'un des plus gros problèmes que nous avons rencontrés s'est passé lors de la mesure des composants.
En effet, lors d'une mesure, nous avons, malencontreusement, mis $7$V en entrée de la batterie.
Les composants ont pour la majorité bien réagi, hormis le régulateur de tension élévateur qui a cessé de fonctionner directement après cela.

Heureusement, nous avions préparé un double de tous les composants et avons pu le remplacer.
Pour ce faire, nous avons dessoudé le composant à l'aide d'une tresse à dessouder, pour ensuite souder au fer à souder le nouveau régulateur.
Après cela, le chargeur de batterie était à nouveau fonctionnel.

