#Code for test with 1 lymphangion

import numpy as np
import scipy as sp
import initialiser
import matplotlib.pyplot as plt
from scipy import optimize

#Constants
pa = 2275
pb = 2375
pe = 2275
Pd = 35
Dd = 0.025
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

coeff = np.array([1, -1])

def globalise(diameter, time):
    global D 
    global t 
    D = diameter
    t = time

def fode(t, D, p1, p2):
    return np.power(D, 3) * (p1 - 2 * pm(t, D) + p2) / (32 * mu * L**2)

def falmighty(pboth, D, t):
    p1 = pboth[0]
    p2 = pboth[1]

    val = fp1(p1, D, t) - fp2(p2, D, t)
    val = val.flatten()

    return val

def fp1(p1, D, t):
    return p1 - pm(t, D) - (64 * mu * L) / (np.pi * np.power(D, 4)) * (pa - p1) / ValveRes(pa,p1)
    
def fp2(p2, D, t):
    return p2 - pm(t, D) + (64 * mu * L) / (np.pi * np.power(D, 4)) * (p2 - pb) / ValveRes(p2,pb)

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
        return 10

#def minimiserval(func, D, t, p):
#    x0 = p - 100
#    pressure = sp.optimize.least_squares(func, x0, jac = "2-point", bounds=([p - 500, p + 500]), args= (D, t))
#    return pressure

def minimiserval(func, D, t, p1, p2):
    x0 = np.append(p1,p2)
    pressure = sp.optimize.least_squares(func, x0, jac = "2-point", bounds=([pa - 600, pb + 500]), args= (D, t)).x
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

def solver(D, deltat, T, initialt = 0):
    #initial conditions
    Dall, Qall, pall, Rvall, tall, p1, p2 = initialiser.initcon(D, initialt)

    for i in np.arange(initialt, T, deltat):
        t = i 
        
        print("time: ", t)

        pboth = minimiserval(falmighty, D, t, p1, p2)

        p1 = pboth[0]
        p2 = pboth[1]


        #Find viable values for p1 and p2
        #p1 = minimiserval(fp1, D, t, pa).x
        #print("p1 is ", p1)

        #p2 = minimiserval(fp2, D, t, pb).x
        #print("p2 is", p2)

        #Print values of Valve Resistance

        Rv1 = ValveRes(pa,p1)
        Rv2 = ValveRes(p2,pb)

        print("Rv for p1 is", Rv1)
        print("Rv for p2 is", Rv2)

        #Print values of flow rate
        Q1 = flowrate(pa, p1)

        Q2 = flowrate(p2, pb)

        print("Q1 is: ", Q1)

        print("Q1 is: ", Q2)

        # RK-4 method
        k1 = deltat * (fode(t, D, p1, p2))
        k2 = deltat * (fode((t + deltat / 2), (D + k1 / 2), p1, p2))
        k3 = deltat * (fode((t + deltat / 2), (D + k2 / 2), p1, p2))
        k4 = deltat * (fode((t + deltat), (D + k3), p1, p2))

        k = (k1 + 2 * k2 + 2 * k3 + k4) / 6

        print(k)

        Dnew = D + k

        p = np.array([p1, p2], ndmin=2)
        Q = np.array([Q1, Q2], ndmin=2)
        Rv = np.array([Rv1, Rv2], ndmin=2)
        Dsave = np.array([D], ndmin=2)

        Dall, Qall, pall, Rvall, tall = savevalues(Dsave, Q, p, Rv, [t], Dall, Qall, pall, Rvall, tall)

        print('%.4f\t%.4f\t%.4f'% (t, D, Dnew))
        print('-------------------------')
        D = Dnew
    
    print('\nAt t = %.4f, D = %.4f' %(t, D))

    return Dall, Qall, pall, Rvall, tall 


def savevalues(D, Q, p, Rv, t, Dall, Qall, pall, Rvall, tall):
    Dall = np.append(Dall, D, axis = 1)

    Qall = np.append(Qall, Q.reshape(-1, 1), axis = 1)

    pall = np.append(pall, p.reshape(-1, 1), axis = 1)

    Rvall = np.append(Rvall, Rv.reshape(-1, 1), axis = 1)

    tall = np.append(tall, t, axis = 0)

    return Dall, Qall, pall, Rvall, tall

def savedata(Dall, Qall, pall, Rvall, timearray):
    np.savetxt('Dall1.csv', Dall, delimiter = ',')
    np.savetxt('Qall1.csv', Qall, delimiter = ',')
    np.savetxt('pall1.csv', pall, delimiter = ',')
    np.savetxt('Rvall1.csv', Rvall, delimiter = ',')
    np.savetxt('time1.csv', timearray, delimiter = ',')




