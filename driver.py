#Code for running a simulation for a network of lymphangions

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt

#Setting up the parameters. All force related values in terms of dyn, all lengths in terms of cm

D = 6 #diameter
L = 3 #length of lymphangion
mu = 1 #lymph viscosity
Pd = 78 #constitutive-relation const.
Dd = 65 #constitutive-relation const.
f = 1 #contraction frequency
M = 3.6 #max. active tension
pa = 2100 #inlet pressure
pb = 3000 #outlet pressure
pe = 2080 #external pressure
deltaP = pa - pb #adverse pressure overcome by chain
deltap = 3 #CHANGE, pressure difference across valve i
n = 3 #number of lymphagions
t = 1
t0 = 0.5

#Changing variables
q1 = np.zeros(n)
q2 = np.zeros(n)
D = np.zeros(n)
p1 = np.zeros(n)
p2 = np.zeros(n)


#Governing equations

dDdt = 2 * (q1 - q2) / (np.pi * L * D) #conservation of mass

deltap = (64 * mu * L * q1) / (D * np.pi) #conservation of momentum

ptm = Pd * (np.exp(D / Dd) - np.power((Dd / D), 3)) + M / D * (1 - np.cos(2 * np.pi * f * (t - t0)))#vessel wall consituitive equation
#first term is the passive term, second term is hoop tension (active)

print("hi")