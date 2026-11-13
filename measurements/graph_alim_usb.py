import matplotlib.pyplot as plt
import numpy as np

# Data
categories = ["5 V", "3.3 V"]
max_values = [5.075, 3.277]
min_values = [4.9, 3.1]
avg_values = [5.03, 3.247]

# Positions of categories on the y-axis
x = np.arange(len(categories))

# Bar width
bar_width = 0.5

# Create horizontal stacked bars
plt.barh(x, max_values, height=bar_width, label="Minimum",
         color="#1b1464", edgecolor="black", zorder=3)
plt.barh(x, avg_values, height=bar_width, label="Moyenne",
         color="#544f8b", edgecolor="black", zorder=3)
plt.barh(x, min_values, height=bar_width, label="Maximum",
         color="#827eaa", edgecolor="black", zorder=3)

# Add annotations for average values below the bars
for i, avg in enumerate(avg_values):
    plt.text(avg, i + 0.28, f"{avg:.2f}", va='bottom',
             ha='center', color='black', fontsize=10, zorder=4)

for i, min in enumerate(min_values):
    plt.text(min, i - 0.28, f"{min:.2f}", va='top',
             ha='center', color='black', fontsize=10, zorder=4)

for i, max in enumerate(max_values):
    plt.text(max, i - 0.28, f"{max:.2f}", va='top',
             ha='left', color='black', fontsize=10, zorder=4)

# Configure the chart
plt.yticks(x, categories)
plt.xlabel("Tension (V)")
# plt.title("Tensions d'entrée et de sortie lors d'une alimentation via USB 5V")

# Adjust y-axis limits for more margin
plt.ylim(-0.5, len(categories) - 0.5)

# Place grid behind the bars
plt.grid(axis="x", linestyle="--", alpha=0.5, zorder=0)

# Add legend and set zorder for legend
legend = plt.legend()
legend.set_zorder(5)

# Adjust layout for more margin at the top and bottom
plt.subplots_adjust(top=0.85, bottom=0.15)

# Show the chart
plt.tight_layout()
plt.show()
