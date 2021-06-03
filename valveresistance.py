#Function(s) for calculating valve resistance
import numpy as np
import scipy as sp
import sympy as sy

#Valve resistance constants throughout lymphagngions

Rvmin = 600.0 #min. valve resistance
Rvmax = 1.2 * 10**7 #max. valve resistance
sopen = 4.9 * 10**-2 #valve opening slope
sfail = 0.04 #valve failure slope
popen = -70.0 #valve opening pressure
pfail = -1.8 * 10**4 #valve failure pressure


def ValveRes(pin, pout):

    deltap = (pin - pout) * 1.0

    siglimit = 1 / (1 + sy.exp(sopen * (deltap - popen)))
    """sigmoidal function for normal opening and transition
    from high resistance RVmax to low resistance RVmin when the pressure drop across it
    exceeds a small positive value popen""" 

    sigfailure = 1 / (1 + sy.exp(- sfail * (deltap - pfail)))
    """sigmoidal function describing valve failure (prolapse) at the
    (large) adverse pressure difference pfail"""

    Rv = Rvmin + Rvmax * (siglimit + sigfailure - 1) #valve resistance equation

    return Rv

def ValveSig(pin, pout):
    
    deltap = (pin - pout)

    siglimit = 1 / (1 + sy.exp(sopen * (deltap - popen)))
    """sigmoidal function for normal opening and transition
    from high resistance RVmax to low resistance RVmin when the pressure drop across it
    exceeds a small positive value popen""" 

    sigfailure = 1 / (1 + sy.exp(- sfail * (deltap - pfail)))
    """sigmoidal function describing valve failure (prolapse) at the
    (large) adverse pressure difference pfail"""

    val = (siglimit + sigfailure - 1) #valve resistance equation

    return val


