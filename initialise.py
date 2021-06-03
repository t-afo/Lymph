#Code for initialising conditions, along with supporting functions

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt

pa = 2100
pb = 3000

coeff = np.array([1, -1])


def matfac(coeff, N): #Function to make matrices for calculation of Q
    mat = np.zeros((N - 1, N))
    for i in range(N - 1):
        mat[i,i:] = np.concatenate((coeff, np.zeros(N - 2 - i)))
    return mat

def Amaker(mat1, mat2, D, L, mu):
    mat2temp = np.matmul(np.power(np.diagflat(D), 4), mat2)
    mat2 = mat2temp
    mat1 = np.delete(mat1, 0, 1)
    A = 1 / (64 * L * mu) * np.matmul(mat1, mat2)
    return A

def constitutive(D, pe, p, N): #transmural pressure = internal pressure - external pressure = (pi + pi+1)/2 - pe 
    Dd = 2 * np.ones(N - 1)
    Pd = 3 * np.ones(N - 1)
    Pe = pe * np.ones(N - 1)

    P0 = np.zeros(N - 1)
    P0[0] = 1/2 * p[0]
    
    exp1 = np.exp(D[1:]/Dd) #first part of passive component
    exp2 = np.power((Dd/D[1:]), 3) #seond part of passive component

    expoverall = np.multiply(Pd, exp1 - exp2)
    rhs = expoverall + Pe - P0 #adding transmural pressure to right hand side
    #print(rhs)

    factor = matfac(np.array([0.5, -0.5]), N) #creatting coefficient matrix for pressures
    #print(factor)
    mat = np.delete(factor, 0, 1) #removing first column, as per boundary conditions

    value = np.matmul(np.linalg.inv(mat), rhs.transpose()) #new values of pressure

    return value.transpose()


def savevalues(D, Q, p, Dall, Qall, pall):
    Dall = np.append(Dall, D.reshape(-1, 1), axis = 1)

    Qall = np.append(Qall, Q.reshape(-1, 1), axis = 1)

    pall = np.append(pall, p.reshape(-1, 1), axis = 1)

    print(Dall, Qall, pall)

    return Dall, Qall, pall

def savedata(Dall, Qall, pall, timearray):
    np.savetxt('Dall.csv', Dall, delimiter = ',')
    np.savetxt('Qall.csv', Qall, delimiter = ',')
    np.savetxt('pall.csv', pall, delimiter = ',')
    np.savetxt('time.csv', timearray, delimiter = ',')

