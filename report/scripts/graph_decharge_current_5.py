import matplotlib.pyplot as plt
import numpy as np

# Données (en A, converties en mA)
voltage_levels = ["3.0", "3.2", "3.4", "3.6", "3.8", "4.0", "4.2"]
current_groups = ["100", "200", "300", "400", "500"]

data = [
    [101, 200, 301, 400, 500],  # 3.0
    [187, 378, 600, 877, 500],  # 3.2
    [175, 351, 550, 782, 1000],  # 3.4
    [165, 328, 508, 711, 950],  # 3.6
    [156, 308, 475, 656, 865],  # 3.8
    [148, 291, 444, 611, 795],  # 4.0
    [134, 262, 397, 540, 693],  # 4.2
]

# Conversion des données en un tableau numpy pour une manipulation plus facile
data = np.array(data)

# Paramètres pour le graphique
bar_width = 0.1  # Largeur des barres
index = np.arange(len(current_groups))  # Position des barres sur l'axe des X

# Initialisation du graphique
fig, ax = plt.subplots(figsize=(10, 6))

# Définir une palette de bleu (nuances de bleu)
colors = plt.cm.Reds(np.linspace(0.3, 0.8, len(voltage_levels)))

# Ajouter les barres pour chaque groupe de tension
for i, (voltage_level, color) in enumerate(zip(voltage_levels, colors)):
    bars = ax.bar(index + i * bar_width,
                  data[i], bar_width, label=voltage_level, color=color)

    # Ajouter les labels au-dessus des barres
    for bar in bars:
        yval = bar.get_height()
        ax.text(bar.get_x() + bar.get_width() / 2, yval +
                5, voltage_level, ha='center', va='bottom')

# Paramètres du graphique
ax.set_xlabel('Courant tiré par la sortie 5V (mA)', fontsize=16)
ax.set_ylabel(
    'Courant tiré sur la batterie (mA)', fontsize=16)
# ax.set_title(
#     'Variation du courant tiré sur la batterie en fonction de ça tension et du courant de la sortie 3.3V', fontsize=20)
ax.set_xticks(index + bar_width * (len(voltage_levels) / 2 - 0.5))
ax.set_xticklabels(current_groups)

# Ajouter une grille horizontale
ax.grid(axis='y', linestyle='--', alpha=0.7)

ax.legend(title="Tension de la batterie (V)", loc='upper left')

# Afficher le graphique
plt.tight_layout()
plt.show()
