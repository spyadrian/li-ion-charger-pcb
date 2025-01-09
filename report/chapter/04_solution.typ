= Détaille de la Solution


== Architecture générale

Notre chargeur de batterie a une architecture simple.
Il s'agit d'aligner correctement les quatres composants décrits dans le @chap_composants_principaux en ajoutant les entrée et sortie nécéssaire.
Chaque de ces composants ont besoins d'autres composants externe pour bien fonctionner.
En dehors des entrées et des sorties, nous avons alors choisi de séparer le circuit en quatres sous-circuits, celui du gestionnaire de charge, du détecteur de tension, du régulateur de tension élévateur et abaisseur.
Chaque sous-circuits est décrit précisément dans les sections dessous.
Le schéma ci-dessous montre l'architecture générale du projet.

// TODO: add image générale

// TODO: besoin de la détailler ?

== Gestionnaire de batterie

Le gestionnaire de tâche n'est pas un composant compliqué.
Il est nécéssaire d'ajouter qu'une résistance afin de le voir fonctionner correctement.
Celle-ci se trouve entre les pins PROG et VSS.
Le @tab_bat_desc_pins décrit l'utilité de chaque pins.

#figure(
  table(
    columns: (2em, 1fr, 5fr),
    align: (center, center, left),
    table.header(
      [*\#*], [*Symbole*], [*Fonction*],
    ),

    [1], [STAT],      [Status de la charge],
    [2], [$V_"SS"$],  [Référence de gestion de batterie ($0$V)],
    [3], [$V_"BAT"$], [Sortie pour la charge la batterie],
    [4], [$V_"DD"$],  [Entrée de l'alimentation],
    [5], [PROG],      [Le courant maximum est programé avec une résistance de PROG à $V_"SS"$],
  ),

  caption: "Description des pins du gestionnaire de batterie",
) <tab_bat_desc_pins>

Tandis que $V_"DD"$ et $V_"BAT"$ sont respictivement l'entrée et la sortie du gestionnaire de batterie, la pin PROG sert configurer le courant maximum.
La pin STAT, elle, est utilisé afin de donner un retour utilisateur sur l'état de la batterie.

#figure(
  image("../image/battery-management_schema.png", width: 170%),

  caption: "Schéma électronique du gestionnaire de batterie",
)

Afin de configurer la sortie du gestionnaire de batterie à $500$mA, nous avons placé une résistance entre la pin PROG et VSS comme indiqué dans la _datasheet_.
La valeur de cette résistance est donner à l'aide de l'@eq_bat_res.

$
  &I_"REG" = (1000"V")/R_"PROG" \
  arrow.l.r.double &R_"PROG" = (1000"V")/I_"REG"
$ <eq_bat_res>

Étant donnée les $500$mA souhaiter en sortie, la valeur de la résistance est de $2$k$ohm$.

La pin STAT est relié à une led ainsi qu'une résistance afin d'indiquer l'état de la charge.
Connaissant le courant que l'on veut faire passer dans la led, il suffit d'utilisé la loi d'Ohm pour trouver la valeur de la résistance.

$ U = R times I arrow.l.r.double R = U / I $

Afin de faire illuminé la led à $75%$ de ca capacité, nous devons faire passer $10$mA à travers.
Cela revient a avoir une résistance de $500ohm$.
Le plus proche avec la norme _E24_ étant $470ohm$.

Les condensateurs qui reste sont principalement là pour atténuer le bruit et lisser les signaux d'entrées et de sorties.
En ce qui concerne leurs valeurs, nous avons repris celle donnée dans la _datasheet_.


== Détecteur de tension

Le schéma du détecteur de tension est très simple dans mon cas, car l'intégralité du travail, pour détecter une tension, est fait à l'intérieur du `BD53E30G-MTR`.

#figure(
  table(
    columns: (2em, 1fr, 5fr),
    align: (center, center, left),
    table.header(
      [*\#*], [*Symbole*], [*Fonction*],
    ),

    [1], [$V_"out"$], [Signal de sortie pour le _reset_],
    [2], [$V_"DD"$],  [Tension d'alimentation de référence],
    [3], [GND],       [_Ground_],
    [4], [N.C.],      [Pin non connectée],
    [5], [$C_"T"$],   [Connexion pour un condensateur ajoutant un délai à la sortie],
  ),

  caption: "Description des pins du détecteur de tension",
)

Les deux pins les plus importantes de ce composants, sont les pins $V_"DD"$ et $V_"out"$.
$V_"DD"$ est l'entrée sur laquelle va se baser la détection et $V_"out"$ serra le signal de sortie.

La tension à surveiller dans notre projet est celle situé sur le segment $V_"bat"$ qui est lié à la sortie de notre batterie lithium-polymère et à celle de notre gestionnaire de batterie.
Notre signal de sortie serra utilisé pour activé ou désactivé les régulateurs de tension, il est alors connectée au segment _EN_ (_enable_).

#figure(
  image("../image/voltage-detector_schema.png", width: 100%),

  caption: "Schéma électronique du détecteur de tension",
)

Dans notre schéma, il aurait été possible de rajouter deux condensateurs.
L'un connecté à la pin $C_"T"$ afin d'ajouter un délai à la sortie, et l'autre, $C_"L"$ connecté à la sortie afin de filtrer le bruit.
Dans le cadre de notre projet, nous avons jugé que ces deux condensateurs n'étaient pas nécéssaire.
Il est bien de noter que mettre un condensateur $0$F à la sortie $C_"T"$ revient à la laisser flottante.


== Régulateur de tension boost

Le régulateur de tension élévateur est l'élément de contrôle central de son circuit.
Il gère les signaux de commutation, la comparaison des tensions, et les mécanismes de contrôle nécessaires pour réguler la tension.
Il ajoute aussi des fonctionnalités de protection, comme le _overvoltage protection_, le _overcurrent protection_ ou le _soft start_.

En revanche, il n'est pas capable de stocker de l'énergie ou bien même de filtrer du bruit.
C'est pour cela que, de plus des résistances pour configurer la tension voulu, il faut ajouter une serie de composants autour du régulateur afin de le faire fonctionner.

Voici un tableau résumant les functions des pins du `ISL97519AIUZ` :

#figure(
  table(
    columns: (2em, 1fr, 5fr),
    align: (center, center, left),
    table.header(
      [*\#*], [*Symbole*], [*Fonction*],
    ),

    [1], [COMP],  [Pin de compensation, sortie de l'amplificateur d'erreur interne],
    [2], [FB],    [Feedback de la tension],
    [3], [EN],    [Pin de contrôle d’arrêt, tirez EN vers le bas pour éteindre l'appareil],
    [4], [GND],   [_Ground_],
    [5], [LX],    [Pin de l'interrupteur d'alimentation],
    [6], [VDD],   [Tension d'alimentation de référence],
    [7], [FSEL],  [Pin de sélection de fréquence],
    [8], [SS],    [Configuration du démarrage progressif],
  ),

  caption: "Description des pins du régulateur de tension boost",
)

Les pins nécessitant une attention particulière sont clairement FB et LX.
La pin de _Feedback_ (FB) surveille la tension de sortie.
La tension à cette pin serra comparé a une référence de tension à l'intérieur du composant.
Une comparaison qui va permettre de dire au régulateur d'augmenter ou diminuer la tension.
C'est pour cela que cette pin est connectée à un diviseur de tension qui determinera la tension de sortie du régulateur.

La _switching pin_ (LX) va alterner entre une haute en basse tension.
Connectée à une inductance, celle-ci pourra stocker de l'énergie (à l'état haut) et la libérer (à l'état bas).
C'est le coeur du processus d'élévation de la tension.

#figure(
  image("../image/boost-regulator_schema.png", width: 110%),

  caption: "Schéma électronique du régulateur de tension boost",
)

Comme anoncé précédement, le schéma montre que la pin FB est connectée à un diviseur de tension.
Les valeurs pour ce diviseur de tension sont donnée via @eq_boost_out.

$ V_"OUT" = V_"FB" times (1 + R_3 / R_4) $ <eq_boost_out>

Il existe plusieurs valeurs possible pour résoudre cette équation.
La _datasheet_ conseillant un réseau de résistances inférieur à $100$k$ohm$ et voulant rester dans les normes _E24_, nous avons choisi $82$k$ohm$ pour $R_3$ et $27$k$ohm$ pour $R_4$.
La valeur final de $V_"OUT"$ étant de $5.006$V qui aproxime bien nos $5$V voulu.

Une inductance est nécéssaire afin de stocker de l'énergie et la relacher.
Son choix dépends de la plage de tension d'entrée, de la tension de sortie, du courant de charge et de la fréquence de commutation.
La _datasheet_ propose une inductance entre $2mu$H et $33mu$H pour la majorité des applications.
Une des application donnée en example utilise une valeur de $10mu$H, c'est la valeur que nous avons décidé de prendre.
Afin de ne pas saturer l'inductance, il est nécéssaire que son courant maximum soit supérieur à celui demandé par le régulateur.
Celui-ci est donnée via @eq_boost_Lpeak.

$ I_"L(PEAK)" = (I_"OUT" times V_"OUT") / V_"IN" + 1/2 times (V_"IN" times (V_"OUT" - V_"IN"))/(L times V_"OUT" times "FREQ") = 1.71"A" $ <eq_boost_Lpeak>

L'inductance finale a $10mu$H et résiste à $2$A.

La diode $D_1$ est positionné à cet endroit afin de ne pas laisser passer le courant lorsque la pin LX est à l'état bas.
Il faut alors qu'elle puisse endosser plus que la tension de sortie ainsi qu'un courant plus élevé que celui pique de l'inductance.
D'où une diode de $15$V et $2$A.

// TODO: probleme, g pa vu ca au debu, alors mauvaise valeur mais ca marche quand meme avec les valeurs max de la diode
//       Comme vous avez pu voir, c'est pa 2 mè 1

Les condensateurs présent dans le circuit servent principalement à lisser les sorties/entrées et à atténuer le bruit.
Pour leurs valeurs, nous avons décidé de gardé les valeurs données dans la _datasheet_.


== Régulateur de tension buck

De la même façon que le régulateur de tension élévateur, le régulateur de tension abaisseur n'est pas capable de tous faire tous seul.
Il se focalise uniquement sur quelques tâches, comme entre-autre, la comparaison des tensions et les signaux de commutation.

Le régulateur de tension abaisseur ne fait donc pas les choses seuls, il utilise plusieurs composants externe afin de fonctionner correctement.
Ils sont nécéssaire pour configurer la tension de sortie, ou bien stocker de l'énergie.

Le @tab_desc_pins_buck decrit les différents pins du `LM22671MRX-ADJ/NOPB`.

#figure(
  table(
    columns: (2em, 1fr, 5fr),
    align: (center, center, left),
    table.header(
      [*\#*], [*Symbole*], [*Fonction*],
    ),

    [1], [BOOT],    [Fournit la tension de grille pour le NFET haut],
    [2], [SS],      [Configuration du démarrage progressif],
    [3], [RT/SYNC], [Utilisé pour contrôler le mode oscillateur du régulateur],
    [4], [FB],      [Feedback de la tension],
    [5], [EN],      [Pin de contrôle d’arrêt, tirez EN vers le bas pour éteindre l'appareil],
    [6], [GND],     [_Ground_],
    [7], [VIN],     [Tension d'alimentation de référence],
    [8], [SW],      [Sortie de commutation du régulateur],
  ),

  caption: "Description des pins du régulateur de tension buck",
) <tab_desc_pins_buck>

Les pins FB, SW et BOOT sont les plus complexes mais aussi les plus utiles.
La pin de _Feedback_ (FB) a le même comportement que celle dans le régulateur de tension élévateur.
Elle est connectée à un diviseur de tension qui donnera la tension de sortie.

La pin _Switch_ (SW) est similaire à la pin (LX) du régulateur de tension élévateur.
Elle permet de stocker de l'énergie dans une inductance en alternant entre l'état haut et l'état bas.
C'est ce qui permet d'abaisser la tension de sortie.

La pin _Bootstrap_ (BOOT) est utilisé afin d'activé et désactivé le MOSFET à l'intérieur du composant, comme illustré sur le schéma de la @img_buck_boot_pin.

#figure(
  image("../image/buck-regulator_boot_pin.png", width: 50%),

  caption: "Schéma block de la pin boot du régulateur de tension abaisseur",
) <img_buck_boot_pin>

En effet, pour faire passer du courant à travers un MOSFET, il faut une tension positive.
Celle-ci est difficile à retrouver lorsque l'unique source de tension est $V_"IN"$.
Pour pouvoir augmenter la tension, on utilise un condensateur qui va revenir depuis la sortie du MOSFET à son entrée.

#figure(
  image("../image/buck-regulator_schema.png", width: 100%),

  caption: "Schéma électronique du régulateur de tension buck",
)

Le diviseur de tension connecté à la pin FB est calculé à l'aide de l'@eq_buck_out fournit dans la _datashet_.

$
  &R_"FBT" = (V_"OUT"/1.285 - 1) times R_"FBB" \
  arrow.l.r.double &V_"OUT" = (R_"FBT"/R_"FBB" + 1) times 1.285 = 3.3V
$ <eq_buck_out>

Une valeur maximale de $10$k$ohm$ est recommandée pour la somme de $R_"FBB"$ et $R_"FBT"$ afin de maintenir une bonne précision de la tension de sortie.
C'est pour cela, que nous avons choisi $2$k$ohm$ pour $R_"FBT"$ et $1.3$k$ohm$ pour $R_"FBB"$.

Étant donnée que la _datasheet_ du `LM22671MRX-ADJ/NOPB` donne un example d'application pour un régulateur de tension ayant une sortie à $3.3$V, nous avons repris leurs valeur pour les condensateurs, l'inductance et la diode.
A l'exception du $C_8$, les condensateurs servent à atténuer le buit et lisser les signaux d'entrée/sortie.

N'ayant pas besoin de _soft start_, la pin SS est flottante.
De la même manière, la pin RT/SYNC est flottante car la configuration de la fréquence de base convient.

// TODO: j'ai pas mis la bonne diode mais pas un soucis


== Routage du PCB

Étant donnée le nombre de composants que nous avions, le routage du PCB c'est passé sans encombre.
L'une des règles du pouce était d'avoir $1$mm de large pour une route pour $100$mA.
Nous avons pu la respecter sans trop de problème.

// TODO: add schema rout PCB
