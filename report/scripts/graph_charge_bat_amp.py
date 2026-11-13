import matplotlib.pyplot as plt

# Data
tension_batterie = [2.0, 2.2, 2.4, 2.6, 2.8,
                    3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2, 4.4]
ampere_usb = [0.232, 0.248, 0.266, 0.288, 0.314,
              0.346, 0.383, 0.430, 0.491, 0.500, 0.502, 0, 0]
ampere_bat = [0.230, 0.245, 0.264, 0.286, 0.311,
              0.341, 0.367, 0.410, 0.460, 0.468, 0.470, -0.006, -0.008]

# Plotting
plt.figure(figsize=(10, 6))
plt.plot(tension_batterie, ampere_usb,
         label="Courant USB", marker='o', color='b')
plt.plot(tension_batterie, ampere_bat,
         label="Courant batterie", marker='x', color='r')

# Labels and title
plt.xlabel('Tension Batterie (V)')
plt.ylabel('Courant (A)')
# plt.title('Courant USB vs. Courant Batterie en fonction de la tension')

# Add grid and legend
plt.grid(True)
plt.legend()

# Show plot
plt.tight_layout()
plt.show()
