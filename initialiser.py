#Code for initialising conditions, along with supporting functions for 1 lymphangion

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
from scipy import optimize

#Constants
pa = 2190
pb = 2500
pe = 2140
Pd = 35
Dd = 0.025
mu = 1
L = 0.3
f = 0.5 
t0 = np.pi / 2

#Valve resistance constants throughout lymphagngions

Rvmin = 600.0 #min. valve resistance
Rvmax = 1.2 * 10**7 #max. valve resistance
sopen = 4.9 * 10**-2 #valve opening slope
sfail = 0.04 #valve failure slope
popen = -70.0 #valve opening pressure
pfail = -1.8 * 10**4 #valve failure pressure


def initcon(D, initialt): #initial conditions
    p1 = minimiserval(fp1, D, initialt, pa).x
    print("initial value of p1 is ", p1)

    p2 = minimiserval(fp2, D, initialt, pb).x
    print("initial value of p2 is", p2)

    #Print values of Valve Resistance

    Rv1 = ValveRes(pa,p1)
    Rv2 = ValveRes(p2,pb)

    print("initial value of Rv for p1 is", Rv1)
    print("initial value of Rv for p2 is", Rv2)

    #Print values of flow rate
    Q1 = flowrate(pa, p1)

    Q2 = flowrate(p2, pb)

    print("initial value of Q1 is: ", Q1)

    print("initial value of Q2 is: ", Q2)

    Dall = np.array([D])
    Qall = np.array([Q1, Q2], ndmin=2).reshape(-1, 1)
    pall = np.array([p1, p2], ndmin=2).reshape(-1, 1)
    Rvall = np.array([Rv1, Rv2], ndmin=2).reshape(-1, 1)
    tall = np.array([initialt])

    return Dall, Qall, pall, Rvall, tall, p1, p2


def fp1(p1, D, t):
    return p1 - pm(t, D) - (64 * mu * L) / (np.pi * D) * (pa - p1) / ValveRes(pa,p1)
    
def fp2(p2, D, t):
    return p2 - pm(t, D) + (64 * mu * L) / (np.pi * D) * (p2 - pb) / ValveRes(p2,pb)

def pm(t, D):
    return pe + fpassive(D) + factive(t, D)

def fpassive(D):
    return Pd * (np.exp(D/Dd) - np.power(Dd/D, 3))

def factive(t, D):
    return Mcon(t, t0) / D * (1 - np.cos(2 * np.pi * f * (t - t0)))

def Mcon(t, t0):
    if (t < t0):
        return 0 
    else:
        return 3.5

def minimiserval(func, D, t, p):
    x0 = p - 100
    pressure = sp.optimize.least_squares(func, x0, jac = "2-point", bounds=([p - 500, p + 500]), args= (D, t))
    return pressure


def ValveRes(pin, pout):

    deltap = (pin - pout)

    siglimit = 1 / (1 + np.exp(sopen * (deltap - popen)))
    """sigmoidal function for normal opening and transition
    from high resistance RVmax to low resistance RVmin when the pressure drop across it
    exceeds a small positive value popen""" 

    sigfailure = 1 / (1 + np.exp(-sfail * (deltap - pfail)))
    """sigmoidal function describing valve failure (prolapse) at the
    (large) adverse pressure difference pfail"""

    Rv = Rvmin + Rvmax * (siglimit + sigfailure - 1) #valve resistance equation

    #print(Rvmax * (siglimit + sigfailure - 1))

    #print(Rv)

    return Rv

def flowrate(pin, pout): #Calculate flow rate 
    return (pout - pin) / ValveRes(pin, pout)


def savevalues(D, Q, p, t, Dall, Qall, pall, tall):
    Dall = np.append(Dall, D, axis = 0)

    Qall = np.append(Qall.reshape(-1, 1), Q.reshape(-1, 1), axis = 1)

    pall = np.append(pall, p.reshape(-1, 1), axis = 1)

    tall = np.append(tall, t, axis = 0)

    return Dall, Qall, pall

def savedata(Dall, Qall, pall, timearray):
    np.savetxt('Dall.csv', Dall, delimiter = ',')
    np.savetxt('Qall.csv', Qall, delimiter = ',')
    np.savetxt('pall.csv', pall, delimiter = ',')
    np.savetxt('time.csv', timearray, delimiter = ',')




