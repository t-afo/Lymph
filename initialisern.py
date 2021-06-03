#Code for initialising conditions, along with supporting functions for 1 lymphangion

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
from scipy import optimize

#Constants
Pd = np.array([50, 75, 100, 125])
Dd = np.array([0.025, 0.022, 0.019, 0.016])
mu = 1
L = 0.3
f = 0.5 
t0 = 1 / 2

#Valve resistance constants throughout lymphagngions

Rvmin = 600.0 #min. valve resistance
Rvmax = 1.2 * 10**7 #max. valve resistance
sopen = 4.9 * 10**-2 #valve opening slope
sfail = 0.04 #valve failure slope
popen = -70.0 #valve opening pressure
pfail = -1.8 * 10**4 #valve failure pressure


def initcon(D, initialt, Num, pinlet, poutlet, pext): #initial conditions
    global N
    global pa
    global pb
    global pe

    N = Num
    pa = pinlet
    pb = poutlet
    pe = pext  

    #p1 = minimiserval(falmighty, D, initialt, p1, p2).x
    p1 = np.linspace(pa, pb, N, endpoint=False)
    print("initial value of p1 is ", p1)

    #p2 = minimiserval(falmighty, D, initialt, p1, p2).x
    p2 = np.linspace(pa, pb, N)
    print("initial value of p2 is", p2)

    #Print values of Valve Resistance

    Rv1 = ValveRes1(p2,p1)
    Rv2 = ValveRes2(p2,p1)

    print("initial value of Rv for p1 is", Rv1)
    print("initial value of Rv for p2 is", Rv2)

    #Print values of flow rate
    Q1 = flowrate1(np.append(pa, p2[0:N-1]), p1)

    Q2 = flowrate2(p2, (np.append(p1[1:N], pb)))

    print("initial value of Q1 is: ", Q1)

    print("initial value of Q2 is: ", Q2)

    Dall = np.array(D.reshape(-1, 1))
    Qall = np.array([Q1, Q2], ndmin=2).reshape(-1, 1)
    pall = np.array([p1, p2], ndmin=2).reshape(-1, 1)
    Rvall = np.array([Rv1, Rv2], ndmin=2).reshape(-1, 1)
    tall = np.array([initialt])

    return Dall, Qall, pall, Rvall, tall, p1, p2


def fp1(p1, p2, D, t):
    p2 = np.append(pa, p2[0:N - 1])
    
    return p1 - pm(t, D) - (64 * mu * L) / (np.pi * D) * (p2 - p1) / ValveRes1(p2, p1)
    
def fp2(p1, p2, D, t):
    p1 = np.append(p1[1:N], pb)

    return p2 - pm(t, D) + (64 * mu * L) / (np.pi * D) * (p2 - p1) / ValveRes2(p2, p1)

def falmighty(p1, p2, D, t):
    return fp1(p1, p2, D, t) + fp2(p1, p2, D, t)


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

def minimiserval(func, D, t, p1, p2):
    x0 = np.append(p1, p2)
    pressure = sp.optimize.least_squares(func, x0, jac = "2-point", bounds=([x0 - 500, x0 + 500]), args= (D, t))
    return pressure


def ValveRes1(pin, pout):

    pout = np.append(pa, pout[0:N - 1])

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

def ValveRes2(pin, pout):

    pin = np.append(pin[1:N], pb)

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

def flowrate1(pin, pout): #Calculate flow rate 

    pout = np.append(pa, pout[0:N - 1])

    return (pout - pin) / ValveRes1(pin, pout)

def flowrate2(pin, pout): #Calculate flow rate 

    pin = np.append(pin[1:N], pb)

    return (pout - pin) / ValveRes2(pin, pout)


def savevalues(D, Q, p, t, Dall, Qall, pall, tall):
    Dall = np.append(Dall, D.reshape(-1, 1), axis = 0)

    Qall = np.append(Qall.reshape(-1, 1), Q.reshape(-1, 1), axis = 1)

    pall = np.append(pall, p.reshape(-1, 1), axis = 1)

    tall = np.append(tall, t, axis = 0)

    return Dall, Qall, pall

def savedata(Dall, Qall, pall, timearray):
    np.savetxt('Dall.csv', Dall, delimiter = ',')
    np.savetxt('Qall.csv', Qall, delimiter = ',')
    np.savetxt('pall.csv', pall, delimiter = ',')
    np.savetxt('time.csv', timearray, delimiter = ',')




