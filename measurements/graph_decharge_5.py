import matplotlib.pyplot as plt
import numpy as np

# Données
battery_voltages = [3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2]
currents = [100, 200, 300, 400, 500]

# Tension moyenne (V avg) mesurée aux sorties 5V
v_avg_5 = [
    [2.760, 2.682, 2.582, 2.515, 2.450],  # 3.0V
    [5, 5, 5, 5, 2.65],  # 3.2V
    [5, 5, 5, 5, 5],  # 3.4V
    [5, 5, 5, 5, 5],  # 3.6V
    [5, 5, 5, 5, 5],  # 3.8V
    [5, 5, 5, 5, 5],  # 4.0V
    [5, 5, 5, 5, 5],  # 4.2V
]

# Création du graphique
fig, ax = plt.subplots(figsize=(12, 6))

# Générer des nuances de bleu
colors = plt.cm.Reds(np.linspace(0.4, 0.9, len(currents)))

# Tracer les courbes pour chaque courant (5V)
for i, (current, color) in enumerate(zip(currents, colors)):
    ax.plot(
        battery_voltages,
        [v[i] for v in v_avg_5],
        marker='o',
        label=f"5V, {current} mA",
        color=color
    )

# Configuration du graphique
ax.set_xlabel("Tension de la batterie (V)", fontsize=16)
ax.set_ylabel("Tension moyenne mesurée (V)", fontsize=16)
# ax.set_title("Tension moyenne mesurée à la sortie 5V")
ax.set_xticks(battery_voltages)
ax.legend(loc='lower right')  # Légende en bas à droite
ax.grid(True, linestyle="--", alpha=0.6)

# Afficher le graphique
plt.tight_layout()
plt.show()
