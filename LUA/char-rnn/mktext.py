#!/usr/local/bin/python
from __future__ import division
import sys
import glob
import time
import os
import matplotlib
import matplotlib.pyplot as plt
#%matplotlib inline 
import numpy as np 
if len(sys.argv)==1: sys.exit("\n=========================\nThe directory of *.t7 files required. Example:\npython mktext-n-plot.py uranbible\n=========================\n")
directory = sys.argv[1]
#directory ="wiki"
filenameD = directory+"_.dat"
# Function to get loss from the model filename in the list 'samp'  
def rateloss(iteR):
    for x in iteR:leng = len(x)
    for x in iteR:X= x[leng-9:leng-3]
    return X
def decrate(iteR):
    for x in iteR:leng = len(x)
    for x in iteR:Y = x[leng-51:leng-38]
    return Y
def epoch(iteR):
    for z in iteR:leng = len(z)
    for z in iteR:Z = z[leng-14:leng-10]
    return Z
try:
    os.remove(filenameD)
except:
    pass
# built is list ' samp ' of all models in a directory
samp = []
cwd = os.getcwd()
PATH = cwd+"/"+directory+"/"
# prevent the detection of vocab.t7 and data.t7
files = glob.glob(PATH+"BASE*.t7")
files.sort(key=os.path.getmtime)
line = ("\n".join(files))
print "last sample is",line
use = line

samp.append(line)
# clear the memory of any prior files that may have been created
# prevents the accidental printing of memory to the file 
try:
    del line
    del li
except:
    pass
fn = open(filenameD, "a")
count = 0
for line in samp:
    line = line.split()
    for li in line:
        count = count +1
        #if count>2:
        if len(li)>50:
            #print count-2,li
            li = li[-9:-3]
            
            #skips the first entry then print a comma before every ' li ' written
            # this avoids a tailing comma
            #if count>3:fn.write(", ")
            if count>1:fn.write(", ")
            fn.write(li)            
fn.close() 
#os.execv("th sample1.lua", line)
nn = len(line)
cmd = 'th sample0.lua ',line[nn-1]
cmd = str(cmd)
CMD = "".join(cmd)
print CMD
CMD = CMD.replace(",","");CMD = CMD.replace("'","")
CMD = CMD.replace("(","");CMD = CMD.replace(")","")
print CMD
os.system(CMD)
#os.execv(cmd, ('',))
#os.execv('sample1.lua', (line))




"""
num = 0
for n in open(filenameD, "r").read().split(","):
    num = num+1
b = num    
a = 14
"""
f = open(filenameD).read()
f = str(f).split()
a = len(f)
A= str(a)
b = int(a)+1
print "---",A,a
c = a / b
c = 12
#np.arange(0.0, a, c)
#steps = 1
#c = range(b,steps)
iteR = samp    
LosR = rateloss(iteR) 
DecR = decrate(iteR)
E = epoch(iteR)
fname = filenameD
s = np.loadtxt(fname, dtype='float', comments='#', delimiter=",")
#s = (2.8920 , 2.2190 , 2.0573 , 1.9742 , 1.8616 , 1.8021 , 1.7422 , 1.7081 , 1.6884 , 1.6534 , 1.6351 , 1.6167 , 1.6084 , 1.5963 , 1.5953 , 1.5796 , 1.5654 , 1.5635 , 1.5472 , 1.5382 , 1.5329 , 1.5264 , 1.5266 , 1.5185 , 1.5118 , 1.5068 , 1.5075 , 1.5025 , 1.4998 , 1.4988 , 1.4974 , 1.4933 , 1.4945 , 1.4968 , 1.4859 , 1.4848 , 1.4840 , 1.4762 , 1.4718 , 1.4735 , 1.4684 , 1.4658 , 1.4609 , 1.4645 , 1.4587 , 1.4571 , 1.4533 , 1.4508 , 1.4483 , 1.4420 , 1.4363 , 1.4290 , 1.4219 , 1.4170 , 1.4013 , 1.3768 , 1.3657 , 1.3676 , 1.3694 , 1.3784 , 1.3823 , 1.3918 , 1.3867 , 1.3873 , 1.3894 , 1.3933 , 1.4013 , 1.3953 , 1.3955 , 1.3954 , 1.4042 , 1.3995 , 1.3992 , 1.3995 , 1.4001 , 1.3994 , 1.3983 , 1.3922 , 1.3970 )
#t = np.arange(0.0, a, c)
#t = np.arange(0.0, b, c)
e = len(s)
ss = range(0,e)
aa = np.array(ss)
#t = np.arange(0.0, aa, c)
# Note that using plt.subplots below is equivalent to using
# fig = plt.figure() and then ax = fig.add_subplot(111)
fig, ax = plt.subplots(dpi=100)
"""
print t
print"-------------"
print s
print"-------------"
print e
print"-------------"
print ss
"""
ax.plot(aa, s)
DT = time.strftime("%Y-%m-%d:%H")
ax.set(xlabel='DATE: '+DT+'      Samples(Scale = 1 per sample)', ylabel='Training Loss',
       title='Training Loss Plot from Last '+A+' Samples.   Epoch: '+E+' \n Last: ModelLoss: '+LosR+"    DecayRate: "+DecR )

ax.grid()
tm = time.strftime("%Y-%m%d%H%M%S")
Filename = "Last-GRU-network-loss-"+LosR+"-plot-for-Directory-"+directory+"_"+tm+".png"
print Filename
fig.savefig(Filename)
plt.show()
