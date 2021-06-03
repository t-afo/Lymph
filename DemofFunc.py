#Code for running a demo simulation for the flow through one lymphangion

from sympy.core.function import _coeff_isneg
from sympy.core.numbers import Exp1
from sympy.functions.elementary.exponential import exp
from sympy.polys.rootoftools import _pure_factors
from valveresistance import Rvmax, Rvmin, ValveRes, ValveSig
import initialise
import numpy as np


from sympy import symbols, Eq, Function

import matplotlib.pyplot as plt

#initialising & constants
N = 2 #number of lymphangions
N = N + 1
pa = 2100
pb = 3000
pinitial = np.linspace(pa, pb, N) #initial pressure distribution
print(pinitial)
pinitial = pinitial.transpose()

p1initial = pinitial
p2initial = pinitial


#A = np.ones((N, N)) #matrix
D = 0.03 * np.ones(N - 1)
Dall = D.reshape(-1, 1)
pe = 2100 #transmural pressure
deltaT = 0.01 #timestep
T = 0.1
L = 0.3
timearray = np.arange(0, T, deltaT)
mu = 1



#You have initial assumed pressure distribution
p = pinitial.transpose()
pall = p.reshape(-1, 1)

#Also boundary condition for Q. Input flow doesn't change
Q = np.zeros(N).reshape(-1, 1)
Qall = Q.reshape(-1, 1)

Q0 = np.zeros(N)

Q[0] = 1
Q0[0] = 1 * Q[0]

for t in np.arange(0, T, deltaT):
    #1. Find value of pressure from diameter distribution
    print("start")
    print(t)

    p[1:] = initialise.constitutive(D, pe, p, N)

    #2. Find flow rates from [q] = [A][p]

        #2.a Build matrix A

    pfac = initialise.matfac(np.array([1, -1]), N)
    Qfac = initialise.matfac(np.array([1, 1]), N)

    #1.b Put them in to find values for Q
    A = initialise.Amaker(Qfac, pfac, D, L, mu)

    ptemp = p - Q0

    print(np.matmul(A, ptemp.reshape(-1, 1)))
    Q[1:] = np.matmul(A, ptemp.reshape(-1, 1))

    #3. Add n values for stuff to find diameter at new timestep

    Dnew = D.reshape(-1, 1) + 2 * deltaT / (np.pi * L * D.reshape(-1, 1)) * np.matmul(initialise.matfac(([1, -1]), N), Q)
    print(np.matmul(initialise.matfac(([1, -1]), N), Q))
    print(initialise.matfac(([1, -1]), N))
    print(Q)
    print(D)
    val, vec = np.linalg.eig(np.matmul(initialise.matfac(([1, -1]), N), Q))

    print("hi")

    print(Dnew)

    print("check")

    Dall, Qall, pall = initialise.savevalues(D, Q, p, Dall, Qall, pall)

    #4. n+1 is now n, repeat
    D = Dnew

    print("end")

initialise.savedata(Dall, Qall, pall, timearray)

print("real end")







