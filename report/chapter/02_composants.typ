= Composants Principaux <chap_composants_principaux>


== Gestionnaire de batterie - `MCP73831T-2ACI/OT` // and not ...-2DCI... !!!

Le composant #link("https://www.mouser.ch/ProductDetail/Microchip-Technology/MCP73831T-2ACI-OT?qs=yUQqVecv4qvbBQBGbHx0Mw%3D%3D")[`MCP73831T-2ACI/OT`] est un gestionnaire de batterie (ou _battery management_) dédié aux batteries lithium-ion et lithium-polymère.
Il est conçu pour charger une seule cellule et, entre-autre, reguler la tension de sortie.

#figure(
  image("../image/battery-management.png", width: 25%),

  caption: "Photo du gestionnaire de batterie",
)

=== Justification

Le gestionnaire de batterie s'inscrit dans notre projet comme étant l'élément qui supervisera le chargement de la batterie.
En effet, pour bien concerver une batterie lithium-polymère, il est nécessaire de ne pas charger la batterie au-delà de $4.2$V, en plus de ne pas la charger avec trop de charge lorsqu'elle est en-dessous de $2.9$V.
Cela pourrait reduire la capacité de la batterie ainsi que sa durée de vie.

Le gestionnaire de batterie `MCP73831T-2ACI/OT` convient à nos car critères, car il fixe la tension maximale appliquée à la batterie à $4.2$V.
De plus, afin de ne pas brusquer la batterie, le `MCP73831T-2ACI/OT` défini plusieurs mode de charge pour la batterie.
Lorsqu'elle est en-dessous de $66.5$ % de la tension maximale, donc $~2.8$V, il passera en _Trickle Charge Mode_ (en préconditionnement) qui consiste à chargé la batterie utilisant uniquement $10$ % du courant maximal spécifié.

=== Caractéristiques principales

#figure(
  table(
    columns: (3fr, 2fr),
    align: (left, right),

    [Tension de sortie],                        [$4.2$V],
    [Courant de sortie],                        [$15$mA à $500$mA],
    [Tension d'alimentation en fonctionnement], [$3.75$V à $6$V],
    [Seuil de tension de préconditionnement],   [$66.5$ %],
    [Courant de préconditionnement],            [$10$ %],
  ),

  caption: "Caractéristiques principales du gestionnaire de batterie",
)


== Détecteur de tension - `BD52E30G-M`

Le composant #link("https://www.mouser.ch/ProductDetail/ROHM-Semiconductor/BD53E30G-MTR?qs=WHeKGGBt0W8BsyUIHW4eRw%3D%3D")[`BD52E30G-M`] est un détecteur de tension (ou _voltage detector_).
Ce type de circuit intégré est conçu pour surveiller une tension d'entrée (par exemple, celle d'une batterie ou d'une alimentation) et générer un signal lorsqu'une certaine condition de tension est atteinte.

#figure(
  image("../image/voltage-detector.jpg", width: 35%),

  caption: "Photo du détecteur de tension",
)

=== Justification

Dans notre cas, nous ne voulons pas que la batterie soit utilisé lorsqu'elle n'est pas chargé au-delà de $3$V.
Pour cela, nous utilisons la condition du `BD52E30G-M` défini à $3$V pour activé et désactivé les régulateurs de tension utilisé avant les sorties.
De sorte, le circuit utilisant la batterie ne pourra pas l'utilisé lorsque celle-ci se trouve en dessous de $3$V.
La tension d'entrée du détecteur de tension est évidement la sortie de la batterie.

=== Caractéristiques principales

#figure(
  table(
    columns: (3fr, 2fr),
    align: (left, right),

    [Tension de seuil],               [$3$V],
    [Type de sortie],                 [CMOS],
    [Tension d'alimentation - Max],   [$10$V],
    [Courant de sortie],              [$80$mA],
    [Tension de sortie "bas" - Max],  [$0.5$V],
    [Tension de sortie "haut" - Min], [$2.5$V],
  ),

  caption: "Caractéristiques principales du détecteur de tension",
)


== Régulateur de tension boost - `ISL97519A`

Le #link("https://www.mouser.ch/ProductDetail/Renesas-Intersil/ISL97519AIUZ?qs=sGAEpiMZZMvAX9OfPh%252B2NdrUzpYIC9WFoHZg1f2cJ9g%3D")[`ISL97519A`] est un régulateur de tension élévateur (ou _boost regulator_).
C'est un type de convertisseur conçu pour augmenter une tension d'entrée plus basse à une tension de sortie plus élevée tout en maintenant une alimentation stable et efficace pour les circuits électroniques.

#figure(
  image("../image/boost-regulator.jpg", width: 30%),

  caption: "Photo du régulateur de tension boost",
)

=== Justification

Notre circuit électronique demande d'avoir deux sortie, dont une à $5$V.
Puisque notre batterie doit garder une tension entre $2.9$V et $4.2$V, il est difficile de prendre dirctement une sortie $5$V.
Nous avons alors utilisé le un régulateur de tension élévateur afin d'ajuster la tension fluctuante de la batterie à $5$V.

Le `ISL97519A` convient parfaitement à nos exigences, car il a une tension de sortie programable entre $5$V et $25$V, qu'il est fonctionnel avec une tension d'entrée entre $2.3$V et $5.5$V et qu'il dispose d'une pin afin de l'activé ou de le désactivé.
Son courant de sortie à $1$A est essentiel afin de pouvoir utilisé les deux sortie du circuit à $500$mA.

=== Caractéristiques principales

#figure(
  table(
    columns: (3fr, 2fr),
    align: (left, right),

    [Tension de sortie],      [$5$V à $25$V],
    [Courant de sortie],      [$1$A],
    [Tension d'entrée - Max], [$2.3$V],
    [Tension d'entrée - Min], [$5.5$V],
  ),

  caption: "Caractéristiques principales du régulateur de tension boost",
)


== Régulateur de tension buck - `LM22671MRX-ADJ/NOPB`

Le composant #link("https://www.mouser.ch/ProductDetail/Texas-Instruments/LM22671MRX-ADJ-NOPB?qs=X1J7HmVL2ZGHbJs9hwNu1Q%3D%3D")[`LM22671MRX-ADJ/NOPB`] est un régulateur de tension abaisseur (ou _buck regulator_).
Il est conçu pour convertir une tension d'entrée plus élevée en une tension de sortie plus basse avec une efficacité élevée.
Ce type de régulateur est souvent utilisé pour alimenter des circuits sensibles ou pour ajuster la tension d'alimentation aux besoins spécifiques de la charge.

#figure(
  image("../image/buck-regulator.jpg", width: 30%),

  caption: "Photo du régulateur de tension buck",
)

=== Justification

De la même manière qu'avec le régulateur de tension élévateur, nous devions adapter la sortie fluctuante de la batterie à une sortie $3.3$V stable.
Étant donnée que la batterie peut sortir une tension inférieur et supérieur à $3.3$V, nous avons préféré utilisé la sortie du régulateur de tension élévateur afin d'avoir uniquement à abaisser le tension.

Le `LM22671MRX-ADJ/NOPB` comporte les caractéristiques adéquate à notre problème, car il est capable d'abaisser une tension d'entrée jusqu'à $1.29$V.
De plus, il sort un courant à $500$mA comme le demande l'énoncé.
Il est fonctionnel entre $4.5$V et $42$V, ce qui harmonise avec notre sortie de $5$V.

=== Caractéristiques principales

#figure(
  table(
    columns: (3fr, 2fr),
    align: (left, right),

    [Tension de sortie],      [$>1.29$V],
    [Courant de sortie],      [$500$mA],
    [Tension d'entrée - Min], [$4.5$V],
    [Tension d'entrée - Max], [$42$V],
  ),

  caption: "Caractéristiques principales du régulateur de tension buck",
)

