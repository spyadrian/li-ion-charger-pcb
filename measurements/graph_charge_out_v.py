import matplotlib.pyplot as plt

# Données
v_battery = [2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2, 4.4]
v_3_3V = [0, 0, 0, 0, 0, 0, 3.281, 3.281, 3.281, 3.281, 3.281, 3.282, 3.282]
v_5V = [2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0]

# Création du graphique
plt.figure(figsize=(8, 5))
plt.plot(v_battery, v_3_3V, label="Sortie 3.3V", marker='o', color='b')
plt.plot(v_battery, v_5V, label="Sortie 5V", marker='x', color='r')

# Titres et labels
# plt.title("Valeurs des sorties en fonction de la tension de la batterie")
plt.xlabel("Tension de la batterie (V)")
plt.ylabel("Tension des sorties (V)")

# Affichage de la légende
plt.legend()

# Affichage du graphique
plt.grid(True)
plt.show()
