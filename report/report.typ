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

= Titre du chapitre

#lorem(10)

#lorem(30)

== Titre de niveau 2
#lorem(50)

#figure(
  image("image/hepia_logo.png", width: 75%),
  caption: "Hepia logo"
)

=== Titre de niveau 3
#lorem(50)

=== Titre de niveau 3
#lorem(50)

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    [hahaha], [hahaha], [hahaha],
    [hahaha], [hahaha], [hahaha],
    [hahaha], [hahaha], [hahaha],
  ),

  caption: "it's a table !",
)

== Titre de niveau 2
#lorem(50)

=== Titre de niveau 3
#lorem(50)

=== Titre de niveau 3
#lorem(50)

== Titre de niveau 2
#lorem(50)

=== Titre de niveau 3
#lorem(50)

=== Titre de niveau 3
#lorem(50)

= Titre du chapitre
#lorem(50)

== Titre de niveau 2
#lorem(50)

= Titre du chapitre

== Titre de niveau 2
#lorem(50)

= Conclusion
#lorem(50)
