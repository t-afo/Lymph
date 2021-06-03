#Code for test with n lymphangions

import numpy as np
import scipy as sp
import initialisern
import matplotlib.pyplot as plt
from scipy import optimize

#Constants
Pd = np.array([50, 75, 100, 125])
Dd = np.array([0.025, 0.022, 0.019, 0.016])
mu = 1
L = 0.3
f = 0.5 

#Valve resistance constants throughout lymphagngions

Rvmin = 600.0 #min. valve resistance
Rvmax = 1.2 * 10**7 #max. valve resistance
sopen = 4.9 * 10**-2 #valve opening slope
sfail = 0.04 #valve failure slope
popen = -70.0 #valve opening pressure
pfail = -1.8 * 10**4 #valve failure pressure


def fode(t, D, p1, p2):
    return np.power(D, 3) * (p1 - 2 * pm(t, D) + p2) / (32 * mu * L**2)

def fp1(p1, p2, D, t):
    p2 = np.append(pa, p2[0:N - 1])
    
    return p1 - pm(t, D) - (64 * mu * L) / (np.pi * np.power(D, 4)) * (p2 - p1) / ValveRes1(p2, p1)
    
def fp2(p1, p2, D, t):
    p1 = np.append(p1[1:N], pb)

    return p2 - pm(t, D) + (64 * mu * L) / (np.pi * np.power(D, 4)) * (p2 - p1) / ValveRes2(p2, p1)

def falmighty(pboth, D, t):
    p1 = pboth[0:N]
    p2 = pboth[N:2*N]

    val = fp1(p1, p2, D, t) + fp2(p1, p2, D, t)
    val = val.flatten()

    return val

def pm(t, D):
    return pe + fpassive(D) + factive(t, D)

def fpassive(D):
    return Pd * (np.exp(D/Dd) - np.power((Dd/D), 3))

def factive(t, D):
    return Mcon(t, t0) / D * (1 - np.cos(2 * np.pi * f * (t - t0)))

def Mcon(t, t0):
    M = 3.5 * np.ones(N)
    for r in np.arange(1, len(t0) + 1):
        if (t < r):
            M[r - 1] = 0
    return M

def minimiserval(func, D, t, p1, p2):
    x0 = np.append(p1,p2)
    pressure = sp.optimize.least_squares(func, x0, jac = "2-point", bounds = ([pa -750, pb + 750]) , args= (D, t)).x
    return pressure

def ValveRes1(pin, pout):

    #pout = np.append(pa, pout[0:N - 1])
    
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

    #pin = np.append(pin[1:N], pb)
    
    deltap = (pin - pout)

    siglimit = 1 / (1 + np.exp(sopen * (deltap - popen)))
    """sigmoidal function for normal opening and transition
    from high resistance RVmax to low resistance RVmin when the pressure drop across it
    exceeds a small positive value popen""" 

    sigfailure = 1 / (1 + np.exp(-sfail * (deltap - pfail)))
    """sigmoidal function describing valve failure (prolapse) at the
    (large) adverse pressure difference pfail"""

    Rv = Rvmin + Rvmax * (siglimit + sigfailure - 1) #valve resistance equation

    #print(Rv)

    return Rv


def flowrate1(pin, pout): #Calculate flow rate 

    return (pin - pout) / ValveRes1(pin, pout)

def flowrate2(pin, pout): #Calculate flow rate 

    return (pin - pout) / ValveRes2(pin, pout)

def solver(D, deltat, Num, T, pinlet, poutlet, pext, initialt = 0):
    #initial conditions
    global N
    global pa
    global pb
    global pe
    global t0

    N = Num
    pa = pinlet
    pb = poutlet
    pe = pext
    t0 = 1 / 2 * np.linspace(1, N, N)


    Dall, Qall, pall, Rvall, tall, p1, p2 = initialisern.initcon(D, initialt, N, pa, pb, pe)

    for i in np.arange(initialt, T, deltat):
        t = i
        
        print("time: ", t)

        #Find viable values for p1 and p2
        pboth = minimiserval(falmighty, D, t, p1, p2)

        p1 = pboth[0:N]
        p2 = pboth[N:2*N]

        #print("p1 is ", p1)

        #print("p2 is", p2)

        #Print values of Valve Resistance

        Rv1 = ValveRes1(np.append(pa, p2[0:N-1]), p1)
        Rv2 = ValveRes2(p2, (np.append(p1[1:N], pb)))

        #print("Rv for p1 is", Rv1)
        #print("Rv for p2 is", Rv2)

        #Print values of flow rate
        Q1 = flowrate1(np.append(pa, p2[0:N-1]), p1)

        Q2 = flowrate2(p2, (np.append(p1[1:N], pb)))

        #print("Q1 is: ", Q1)

        #print("Q2 is: ", Q2)

        # RK-4 method
        k1 = deltat * (fode(t, D, p1, p2))
        k2 = deltat * (fode((t + deltat / 2), (D + k1 / 2), p1, p2))
        k3 = deltat * (fode((t + deltat / 2), (D + k2 / 2), p1, p2))
        k4 = deltat * (fode((t + deltat), (D + k3), p1, p2))

        k = (k1 + 2 * k2 + 2 * k3 + k4) / 6

        Dnew = D + k

        p = np.array([p1, p2], ndmin=2)
        Q = np.array([Q1, Q2], ndmin=2)
        Rv = np.array([Rv1, Rv2], ndmin=2)
        Dsave = np.array([D], ndmin=2)

        Dall, Qall, pall, Rvall, tall = savevalues(Dsave, Q, p, Rv, [t], Dall, Qall, pall, Rvall, tall)

        #print('%.4f\t%.4f\t%.4f'% (t, D, Dnew))
        #print(D.reshape(-1, 1))
        #print('-------------------------')
        D = Dnew
    
    #print('\nAt t = %.4f, D = %.4f' %(t, D))

    return Dall, Qall, pall, Rvall, tall 


def savevalues(D, Q, p, Rv, t, Dall, Qall, pall, Rvall, tall):
    Dall = np.append(Dall, D.reshape(-1, 1), axis = 1)

    Qall = np.append(Qall, Q.reshape(-1, 1), axis = 1)

    pall = np.append(pall, p.reshape(-1, 1), axis = 1)

    Rvall = np.append(Rvall, Rv.reshape(-1, 1), axis = 1)

    tall = np.append(tall, t, axis = 0)

    return Dall, Qall, pall, Rvall, tall

def savedata(Dall, Qall, pall, Rvall, timearray):
    np.savetxt('Dallnfailure.csv', Dall, delimiter = ',')
    np.savetxt('Qallnfailure.csv', Qall, delimiter = ',')
    np.savetxt('pallnfailure.csv', pall, delimiter = ',')
    np.savetxt('Rvallnfailure.csv', Rvall, delimiter = ',')
    np.savetxt('timenfailure.csv', timearray, delimiter = ',')




