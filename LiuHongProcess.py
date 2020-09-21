# %% import the package
import cv2
print(cv2.__version__)
import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd
from pandas import DataFrame, Series  # for convenience
import pims
import trackpy as tp
import numpy as np
import glob
from tqdm import tqdm
# %% parameter need to set
ImagePath = 'C:/Users/liuhong2/Desktop/200610_Prelim/PTV_LiuHong/P3O190/2nd/Right/'
frames = pims.open(ImagePath + '*.tif')
#f = tp.locate(frames[0], estimateFeatureSize)
print('Valid frames length is %d' %len(frames))

# %% test with parameter (First run to find the min Mass)
estimateFeatureSize = 45 # must be odd numer
minMass = 200 # calculate the integrate minMass intensity
f = tp.locate(frames[110], estimateFeatureSize)
# plot the mass diagram to check the orginal distribution of the mass histogram
fig, ax = plt.subplots()
ax.hist(f['mass'], bins=20)
ax.set(xlabel='mass', ylabel='count');
# %% second run and ask user input minmass
minMass = 80000
f = tp.locate(frames[100], estimateFeatureSize, minmass= minMass)
tp.annotate(f, frames[100]);
# %% 
f = f.sort_values(by='mass', ascending=False).iloc[0]
# %% check subpixel accuracy
tp.subpx_bias(f)

# %% locate feature in all frames
f = tp.batch(frames, estimateFeatureSize, minmass = minMass)
# %%
t = tp.link(f, 60, memory=3)
plt.figure()
tp.annotate(t[t['frame'] == 0], frames[0]);
# %%
t1 = tp.filter_stubs(t, 100)
tp.plot_traj(t1)
# %%
t1.to_csv('./Right_P3O190_2nd.csv')

#%% sort and filter traj to avoid not moving particles
'''
Ntrajs = np.max(np.array(t1['particle'])) + 1
minMoveDistance = 1000
print('there are %s trajectories' % Ntrajs)
t2 = t1[0:0]
for i in range(Ntrajs):
    tNew = t1[t1['particle']==i]
    if(len(tNew) < 300):
        continue
    distData = tp.motion.msd(tNew,1,1,len(tNew))
    dist = distData.iloc[-1,:]['msd']
    print('partile index:' , i ,' traveling distance: ', dist)
    if dist > minMoveDistance:
        t2 = t2.append(tNew)


h = plt.figure(1, figsize=(6,12))
tp.plot_traj(t2)
h.savefig('images.jpg')
t2.to_csv('./pointsData.csv')
'''