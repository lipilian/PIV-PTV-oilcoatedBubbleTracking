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
index = 19
CaseName = fileNames[index]
print(CaseName)
startFrame = int(framesInfo[index].split('-')[0])
endFrame = int(framesInfo[index].split('-')[1])
testFrame = 31


# %% define feature detect function
def Detect(estimateFeatureSize, CameraName, minMass = None, dynamicMinMass = False):
    ImagePath = os.path.join('data', CaseName.split('-')[0], CaseName.split('-')[1])
    Path = os.path.join(ImagePath, CameraName + '*.tif')
    frames = pims.open(Path)
    print('Valid frames length is %d' %len(frames))
    # check start frame and end frame with total frames number
    if len(frames) != (endFrame - startFrame + 1):
        print('Invalid frames length')
        return
    # find five brightest
    if not minMass:
        f = tp.locate(frames[testFrame], estimateFeatureSize)
        mass = list(f['mass']); mass.sort()
        minMass = int(mass[-2]*0.9 + mass[-1]*0.1)
        print(minMass)
    #TopTen = np.argsort(f['mass'])[-5:]
    #TopTenArray = f['mass'][TopTen]
    # show mass histogram
    # show subpixel accuracy of the detection 
    #minMass = list(TopTenArray)[0]
    f = tp.locate(frames[testFrame], estimateFeatureSize, minmass= minMass)
    plt.figure()
    tp.annotate(f, frames[testFrame]);
    # run batch processing for all frames
    if dynamicMinMass:
        f = f[0:0]
        for i in range(len(frames)):
            f_ele = tp.locate(frames[i], estimateFeatureSize)
            mass = list(f_ele['mass']); mass.sort()
            minMass = int(mass[-2]*0.9 + mass[-1]*0.1)
            f_ele = tp.locate(frames[i], estimateFeatureSize, minmass = minMass)
            f = f.append(f_ele)
    else:
        f = tp.batch(frames, estimateFeatureSize, minmass = minMass)
    return f, frames
# define link function
def Link(searchRange, memory, minFrames):
    t = tp.link(f, search_range = searchRange, memory = memory)
    t1 = tp.filter_stubs(t, minFrames)
    plt.figure()
    tp.plot_traj(t1, label = True)
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


# %% run trajectory finding ------------------------------Left
estimateFeatureSizeLeft = 31
CameraName = 'Left'
tp.quiet()
f, frames = Detect(estimateFeatureSizeLeft, CameraName, minMass = None, dynamicMinMass = True)
# %% test prediction

# %% test minMass . If link is not good , recheck the minMass
estimateFeatureSizeLeft = 61
f1 = tp.locate(frames[148], estimateFeatureSizeLeft)
plt.figure()
tp.annotate(f1, frames[148])
mass = list(f1['mass']); mass.sort()
minMass = int(mass[-2]*0.9 + mass[-1]*0.1)
f1 = tp.locate(frames[148], estimateFeatureSizeLeft, minMass)
plt.figure()
tp.annotate(f1, frames[148]);

'''
pred = tp.predict.NearestVelocityPredict()
t = pred.link_df(f,40,memory=20)
#t = tp.link(f, 50, memory = 20, predictor = tp.predict.NearestVelocityPredict)
t1 = tp.filter_stubs(t, 20)
plt.figure()
tp.plot_traj(t1)
'''
# %% Link trajectory
f = f[['y', 'x', 'frame']]
searchRange = 90
memory = 30
minFrames = 20
t = Link(searchRange, memory, minFrames)
# %% filter trajectory by minimum moving distance
minFrames = 20
minDistance = 2000
t = filterTrajectory(t, minDistance, minFrames)
plt.figure()
#t = t[t['particle'] == 5]
tp.plot_traj(t)

t.to_csv('./' + CaseName + 'Left.csv')

listParticle = list(t['particle'])
listParticle = list(set(listParticle))
print('There are %d trajectories' % len(listParticle))


# %% ---------------------------------------- Right Camera
f1 = tp.locate(frames[87], 21, 7000)
plt.figure()
tp.annotate(f1, frames[87]);

# %% run trajectory finding for Right
estimateFeatureSizeRight = 31
CameraName = 'Right'
tp.quiet()
f, frames = Detect(estimateFeatureSizeRight, CameraName, dynamicMinMass = True)
# %%
f = f[['y', 'x', 'frame']]
searchRange = 70
memory = 40
minFrames = 40
t = Link(searchRange, memory, minFrames)
# %%  filter trajectory by minimum moving distance
minFrames = 10
minDistance = 1000
t = filterTrajectory(t, minDistance, minFrames)
plt.figure()
tp.plot_traj(t)
t.to_csv('./' + CaseName + 'Right.csv')
listParticle = list(t['particle'])
listParticle = list(set(listParticle))
print('There are %d trajectories' % len(listParticle))

# %%
