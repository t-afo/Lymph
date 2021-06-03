import numpy as np
import scipy as sp
import scriptn
import time

start = time.time()
N = 4 #number of lymphangions
T = 120
L = 0.3
deltat = 0.05
initialD = 0.025 * np.ones((1, N))

print(np.arange(0, T, deltat))

pa = 2275
pb = 2275 + 20000
pe = 2575


Dall, Qall, pall, Rvall, tall = scriptn.solver(initialD, deltat, N, T, pa, pb, pe)

scriptn.savedata(Dall, Qall, pall, Rvall, tall)

elapsed = time.time() - start
print("Time elapsed: ", elapsed) # CPU seconds elapsed (floating point)

    

