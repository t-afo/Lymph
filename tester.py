import numpy as np
import scipy as sp
import script1
import time

start = time.time()
T = 80
L = 0.3
deltat = 0.05
initialD = 0.025 * np.array([1], ndmin=1)

pa = 2275
pb = 2375
pe = 2275


Dall, Qall, pall, Rvall, tall = script1.solver(initialD, deltat, T)

script1.savedata(Dall, Qall, pall, Rvall, tall)

elapsed = time.time() - start
print("Time elapsed: ", elapsed) # CPU seconds elapsed (floating point)

    

