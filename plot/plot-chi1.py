# coding: utf-8
import matplotlib.pyplot as plt
from pylab import *
import numpy as np
from scipy.stats.kde import gaussian_kde

def runningMeanFast(x, N=10): # where x is the aray of data and N the bin width
    x1 = np.pad(x,N,mode='reflect')
    output =np.convolve(x1, np.ones((N,))/N)[(N-1):]
    return output[N:-N]

def density(array,nbin=100, c="blue", linew=3) :

  kde = gaussian_kde( array )
  dist_space = linspace( min(array), max(array), nbin )
  plt.plot( dist_space, kde(dist_space), color=c, lw=linew) 


#set figure size
plt.rcParams["figure.figsize"] = (16,12)

#set parameters
frameWidth = 1.5
plt.rcParams["axes.linewidth"] = frameWidth
plt.rcParams["axes.linewidth"] = frameWidth
plt.rcParams["xtick.major.width"] = frameWidth
plt.rcParams["ytick.major.width"] = frameWidth
plt.rcParams['xtick.major.pad'] = 20
plt.rcParams['ytick.major.pad'] = 20
plt.xticks(fontsize=20,weight='bold')
plt.yticks(fontsize=20,weight='bold')
plt.xlabel('Time [ns]',fontsize=30,weight='bold')
plt.ylabel('Abs(chi-1)',fontsize=30,weight='bold')

data=np.genfromtxt('chi1-9.out')



dA=[]
dB=[]
dC=[]
dD=[]
dE=[]

for i in range(0,len(data[:,1])) :
    if (data[i,1]<0):
        dA.append(data[i,1]+360)
    else :
        dA.append(data[i,1])
    if (data[i,2]<0):
        dB.append(data[i,2]+360)
    else :
        dB.append(data[i,2])
    if (data[i,3]<0):
        dC.append(data[i,3]+360)
    else :
        dC.append(data[i,3])
    if (data[i,4]<0):
        dD.append(data[i,4]+360)
    else :
        dD.append(data[i,4])
    if (data[i,5]<0):
        dE.append(data[i,5]+360)
    else :
        dE.append(data[i,5])

plt.plot(data[:,0]/100,runningMeanFast(dA), label="A", c="blue") 
plt.plot(data[:,0]/100,runningMeanFast(dB), label="B", c="violet")
plt.plot(data[:,0]/100,runningMeanFast(dC), label="C", c="red") 
plt.plot(data[:,0]/100,runningMeanFast(dD), label="D", c="green") 
plt.plot(data[:,0]/100,runningMeanFast(dE), label="E", c="orange")
#plt.plot(data[:,0]/100000,runningMeanFast(abs(data[:,1])), label="A", c="blue") 
#plt.plot(data[:,0]/100000,runningMeanFast(abs(data[:,2])), label="B", c="yellow")
#plt.plot(data[:,0]/100000,runningMeanFast(abs(data[:,3])), label="C", c="red") 
#plt.plot(data[:,0]/100000,runningMeanFast(abs(data[:,4])), label="D", c="green") 
#plt.plot(data[:,0]/100000,runningMeanFast(abs(data[:,5])), label="E", c="orange")
plt.legend(fontsize=20,fancybox=True)
# insert

#a.ylim=(0.0,0.04)
#a = plt.axes([.60, .66, .2, .2], axisbg='white')
#plt.ylim(0,0.05)
#plt.title('Density')

#density(dA,c="blue") 
#density(dB,c="violet") 
#density(dC,c="red") 
#density(dD,c="green") 
#density(dE,c="orange") 

plt.savefig('./chi1-9-360.png')
#plt.show()
