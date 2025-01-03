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

== Gestionnaire de tension

== Détecteur de tension

== Régulateur de tension Boost

== Régulateur de tension Buck



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


