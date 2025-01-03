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

#include "chapter/01_introduction.typ"

#include "chapter/02_composants.typ"

#include "chapter/03_conception.typ"

#include "chapter/04_solution.typ"

#include "chapter/05_resultats.typ"

#include "chapter/06_conclusion.typ"
