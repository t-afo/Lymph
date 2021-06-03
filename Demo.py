#Code for running a simulation for a network of lymphangions

from sympy.core.numbers import Exp1
from sympy.functions.elementary.exponential import exp
from valveresistance import Rvmax, Rvmin, ValveRes, ValveSig
import numpy as np
import scipy as sp
import sympy as sy
from sympy import symbols, Eq, Function
from sympy.solvers.ode.systems import dsolve_system, canonical_odes
import matplotlib.pyplot as plt


#Setting up the parameters. All force related values in terms of dyn, all lengths in terms of cm

D = 6 #diameter
L = 3 #length of lymphangion
mu = 1 #lymph viscosity
Pd = 50 #constitutive-relation const.
Dd = 0.025 #constitutive-relation const.
cf = 1 #contraction frequency
M = 3.6 #max. active tension
pa = 2100 #inlet pressure
pb = 3000 #outlet pressure
pe = 2080 #external pressure
deltaP = pa - pb #adverse pressure overcome by chain
deltap = 3 #CHANGE, pressure difference across valve i
n = 1 #number of lymphagions
t0 = 0 #inter-lymphangion phase

#Setting up symbolic governing equations
t = symbols('t')
x, y, z = symbols('x y z', cls=Function)

eq1 = Eq(y(t) - z(t), (64 * mu * L * (2 * Rvmin + Rvmax * (ValveSig(pa, y(t)) + ValveSig(z(t), pb)))) / (np.power(x(t),4) * np.pi))
eq2 = Eq(x(t) * x.diff(t), 2 * Rvmax / (2 * np.pi) * (ValveSig(pa, y(t)) - ValveSig(z(t), pb)))
eq3 = Eq(y(t) + z(t), 2 * (Pd * (sy.exp(x(t) / Dd) - np.power((Dd / x(t)), 3)) + M / x(t) * (1 - sy.cos(2 * np.pi * cf * (t - t0)))) + pe)

eqs = [eq1, eq2, eq3]
funcs = [x(t), y(t), z(t)]

print(eqs)
print(funcs)
#canonical_eqs = canonical_odes(eqs,funcs=funcs, t=t)

systemm = dsolve_system(eqs,funcs=funcs, t=t)
print(systemm)
#---------------------------------------------------------------------------------------------------
#Going to use euler's method to solve, as opposed to symbolic eqs.




print("hi")
