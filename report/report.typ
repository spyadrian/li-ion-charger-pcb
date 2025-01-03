#import "conf.typ": *

#show: conf.with(
  title: "Développement d'un chargeur Li-Ion - Li-Po",
  authors: "Adrian Spycher",
  orientation: "systèmes embarqué",
  teachers: "Berthet Quentin, Fourquier Simon Aurélien",
  illustration: image("image/pcb_front.png", width: 50%),
)

#show: apply_intro_style

#outline(title: "Table des matières")

#outline(title: "Liste des illustration", target: figure.where(kind: image))

#outline(title: "Liste des tableaux", target: figure.where(kind: table))

#show: apply_chapter_style



= Introduction

== Énoncé du problème

== Objectifs et périmètre

== Vue d'ensemble des exigences



= Composants Principaux


== Gestionnaire de tension - `MCP73831T-2ACI/OT` // and not ...-2ADCI... !!!

Le composant #link("https://www.mouser.ch/ProductDetail/Microchip-Technology/MCP73831T-2ACI-OT?qs=yUQqVecv4qvbBQBGbHx0Mw%3D%3D")[`MCP73831T-2ACI/OT`] est un gestionnaire de charge (ou _battery management_) dédié aux batteries lithium-ion et lithium-polymère.
Il est conçu pour charger une seule cellule et, entre-autre, reguler la tension de sortie.

#figure(
  image("image/battery-management.png", width: 25%),

  caption: "Photo du gestionnaire de tension",
)

=== Justification

Le gestionnaire de tension s'inscrit dans notre projet comme étant l'élément qui supervisera le chargement de la batterie.
En effet, pour bien concerver une batterie lithium-polymère, il est nécessaire de ne pas charger la batterie au-delà de $4.2$V, en plus de ne pas la charger avec trop de charge lorsqu'elle est en-dessous de $2.9$V.
Cela pourrait reduire la capacité de la batterie ainsi que sa durée de vie.

Le gestionnaire de tension `MCP73831T-2ACI/OT` convient à nos car critères, car il fixe la tension maximale appliquée à la batterie à $4.2$V.
De plus, afin de ne pas brusquer la batterie, le `MCP73831T-2ACI/OT` défini plusieurs mode de charge pour la batterie.
Lorsqu'elle est en-dessous de $66.5$ % de la tension maximale, donc $~2.8$V, il passera en _Trickle Charge Mode_ (en préconditionnement) qui consiste à chargé la batterie utilisant uniquement $10$ % du courant maximal spécifié.

// TODO: j'ai commandé le mauvais mdr ? (2ADCI)

=== Principals characteristiques

#figure(
  table(
    columns: (3fr, 2fr),
    align: (left, right),

    [Tension de sortie], [$4.2$V],
    [Courant de sortie], [$15$mA à $500$mA],
    [Tension d'alimentation en fonctionnement], [$3.75$V à $6$V],
    [Seuil de tension de préconditionnement], [$66.5$ %],
    [Courant de préconditionnement], [$10$ %],
  ),

  caption: "Caractéristiques principales du gestionnaire de tension",
)

// TODO: mettre ici les calculs pour la resistance REG et pour la valeur de la charge maximale programmée ?

== Détecteur de tension

Le composant #link("https://www.mouser.ch/ProductDetail/ROHM-Semiconductor/BD53E30G-MTR?qs=WHeKGGBt0W8BsyUIHW4eRw%3D%3D")[`BD52E30G-M`] est un détecteur de tension (ou _voltage detector_).
Ce type de circuit intégré est conçu pour surveiller une tension d'entrée (par exemple, celle d'une batterie ou d'une alimentation) et générer un signal lorsqu'une certaine condition de tension est atteinte.

#figure(
  image("image/voltage-detector.jpg", width: 30%),

  caption: "Photo du détecteur de tension",
)

=== Justification

// TODO:

=== Principal characteristique

#figure(
  table(
    columns: (1fr, 1fr),
    align: (left, right),

    [Threshold Voltage], [3V],
    [Output Type], [CMOS],
    [Supply Voltage - Max], [10V],
    [Output Current], [80mA],
    ["Low" Output Voltage - Max], [0.5V],
    ["High" Output Voltage - Min], [2.5V],
  ),

  caption: "Caractéristiques principales du détecteur de tension",
)


== Régulateur de tension Boost

Le #link("https://www.mouser.ch/ProductDetail/Renesas-Intersil/ISL97519AIUZ?qs=sGAEpiMZZMvAX9OfPh%252B2NdrUzpYIC9WFoHZg1f2cJ9g%3D")[`ISL97519A`] est un régulateur de tension élévateur (ou _boost regulator_).
C'est un type de convertisseur conçu pour augmenter une tension d'entrée plus basse à une tension de sortie plus élevée tout en maintenant une alimentation stable et efficace pour les circuits électroniques.

#figure(
  image("image/boost-regulator.jpg", width: 30%),

  caption: "Photo du régulateur de tension boost",
)

=== Justification

// TODO:

=== Principal characteristique

#figure(
  table(
    columns: (1fr, 1fr),
    align: (left, right),

    [Output Voltage], [5V to 25V],
    [Output Current], [1A],
    [Input Voltage - Max], [2.3V],
    [Input Voltage - Min], [5.5V],
  ),

  caption: "Caractéristiques principales du régulateur de tension boost",
)

== Régulateur de tension buck

Le composant #link("https://www.mouser.ch/ProductDetail/Texas-Instruments/LM22671MRX-ADJ-NOPB?qs=X1J7HmVL2ZGHbJs9hwNu1Q%3D%3D")[`LM22671MRX-ADJ/NOPB`] est un régulateur de tension abaisseur (ou _buck regulator_).
Il est conçu pour convertir une tension d'entrée plus élevée en une tension de sortie plus basse avec une efficacité élevée.
Ce type de régulateur est souvent utilisé pour alimenter des circuits sensibles ou pour ajuster la tension d'alimentation aux besoins spécifiques de la charge.

#figure(
  image("image/buck-regulator.jpg", width: 30%),

  caption: "Photo du régulateur de tension buck",
)

=== Justification

// TODO:

=== Principal characteristique

#figure(
  table(
    columns: (1fr, 1fr),
    align: (left, right),

    [Output Voltage], [ADJ (3.3V)],
    [Output Current], [500mA],
    [Input Voltage - Max], [4.5V],
    [Input Voltage - Min], [42V],
  ),

  caption: "Caractéristiques principales du régulateur de tension buck",
)



= Processus de Conception

== Étapes initiales de conception

== Étapes de conception du PCB

== Activités post-conception



= Détaille de la Solutions

== Architecture

== Schémas

== Routage du PCB



= Résultats et Discussion

== Résultats des tests

== Problèmes rencontrés

== Solutions apportées



= Conclusion

== Résumé du projet

== Enseignements tirés

== Améliorations futures


