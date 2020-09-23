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
import os
# %% parameters
data = pd.read_csv('experiment_info.csv')
fileNames = list(data['ID'])
framesInfo = list(data['StartFrame-EndFrame'])
data
# %%
index = 11
CaseName = fileNames[index]
print(CaseName)
startFrame = int(framesInfo[index].split('-')[0])
endFrame = int(framesInfo[index].split('-')[1])
testFrame = 80


# %% define feature detect function
def Detect(estimateFeatureSize, CameraName):
    ImagePath = os.path.join('data', CaseName.split('-')[0], CaseName.split('-')[1])
    Path = os.path.join(ImagePath, CameraName + '*.tif')
    frames = pims.open(Path)
    print('Valid frames length is %d' %len(frames))
    # check start frame and end frame with total frames number
    if len(frames) != (endFrame - startFrame + 1):
        print('Invalid frames length')
        return
    # find five brightest
    f = tp.locate(frames[testFrame], estimateFeatureSize)
    TopFive = np.argsort(f['mass'])[-5:]
    TopFiveArray = f['mass'][TopFive]
    # show mass histogram
    # show subpixel accuracy of the detection 
    minMass = list(TopFiveArray)[0]
    f = tp.locate(frames[testFrame], estimateFeatureSize, minmass= minMass)
    plt.figure()
    tp.annotate(f, frames[testFrame]);
    # run batch processing for all frames
    f = tp.batch(frames, estimateFeatureSize, minmass = minMass)
    return f, frames
# define link function
def Link(searchRange, memory, minFrames):
    t = tp.link(f, search_range = searchRange, memory = memory)
    t1 = tp.filter_stubs(t, minFrames)
    plt.figure()
    tp.plot_traj(t1)
    return t1
# filter the trajectory
def filterTrajectory(t1, minDistance, minFrames):
    Ntrajs = np.max(np.array(t1['particle'])) + 1
    print('There are %d trajectories' % Ntrajs)
    t2 = t1[0:0]
    for i in range(Ntrajs):
        tNew = t1[t1['particle']==i]
        if(len(tNew) < minFrames):
            continue
        distData = tp.motion.msd(tNew,1,1,len(tNew))
        dist = distData.iloc[-1,:]['msd']
        print('partile index:' , i ,' traveling distance: ', dist)
        if dist > minDistance**2:
            t2 = t2.append(tNew)
    return t2

# %% run trajectory finding 
estimateFeatureSizeLeft = 21
CameraName = 'Left'
tp.quiet()
f, frames = Detect(estimateFeatureSizeLeft, CameraName)
# %% Link trajectory
searchRange = 100
memory = 10
minFrames = 100
t = Link(searchRange, memory, minFrames)
# %% filter trajectory by minimum moving distance
minFrames = 50
minDistance = 2000
t = filterTrajectory(t, minDistance, minFrames)
plt.figure()
#t = t[t['particle'] == 5]
tp.plot_traj(t)

t.to_csv('./' + CaseName + 'Left.csv')

listParticle = list(t['particle'])
listParticle = list(set(listParticle))
print('There are %d trajectories' % len(listParticle))


# %% run trajectory finding for Right
estimateFeatureSizeRight = 21
CameraName = 'Right'
tp.quiet()
f, frames = Detect(estimateFeatureSizeRight, CameraName)
# %%
searchRange = 40
memory = 10
minFrames = 100
t = Link(searchRange, memory, minFrames)
# %%  filter trajectory by minimum moving distance
minFrames = 50
minDistance = 1500
t = filterTrajectory(t, minDistance, minFrames)
plt.figure()
tp.plot_traj(t)
t.to_csv('./' + CaseName + 'Right.csv')
listParticle = list(t['particle'])
listParticle = list(set(listParticle))
print('There are %d trajectories' % len(listParticle))

# %%
