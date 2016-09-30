#!/usr/bin/env python

import numpy as np
import sys 

#./avg inp col start (end)

arglist=sys.argv

data=np.genfromtxt(arglist[1])
col=arglist[2]
start=int(arglist[3])
end=len(data)-1

if len(arglist) >=5 :
	end=int(arglist[4])
else :
	print("end = length of data")


if len(np.shape(data)) == 1 :
	print("Average is: %3.3f" % np.mean(data[start:end]))
	print("Std is: %3.3f" % np.std(data[start:end]))
else :
	print("Average is: %3.3f" % np.mean(data[start:end,col]))
	print("Std is: %3.3f" % np.std(data[start:end,col]))


