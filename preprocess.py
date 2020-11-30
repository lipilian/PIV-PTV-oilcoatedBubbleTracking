# %%
import os 
import pandas as pd
import glob
import cv2
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
from tqdm import tqdm
data = pd.read_csv('experiment_info.csv')
fileNames = list(data['ID'])
framesInfo = list(data['StartFrame-EndFrame'])
# %%
rawPath = 'E:/BubbleRisingUltimate/BubbleRising'
for k in tqdm(range(33,35)):
# for k in tqdm(range(len(fileNames))):
    filename = fileNames[k]
    frameInfo = framesInfo[k]
    startFrame = int(frameInfo.split('-')[0])
    endFrame = int(frameInfo.split('-')[1])
    targetPath = os.path.join('data',filename.split('-')[0],filename.split('-')[1])
    rawImagePath = os.path.join(rawPath, filename.split('-')[0], 'RawData')
    LeftImagePath = sorted(glob.glob(rawImagePath + '/*LA.tif'))
    RightImagePath = sorted(glob.glob(rawImagePath + '/*RA.tif'))
    validLeftPath = []
    validRightPath = []
    for i in range(startFrame, endFrame + 1):
        ss = '%06d' % i
        for m, path in enumerate(LeftImagePath):
            aa = path.split('X')[-1]
            if ss in aa:
                validLeftPath.append(path)
        for m, path in enumerate(RightImagePath):
            aa = path.split('X')[-1]
            if ss in aa:
                validRightPath.append(path)
    validLeftPath = sorted(validLeftPath)
    validRightPath = sorted(validRightPath)

    Left = [cv2.imread(pp, -1) for pp in validLeftPath]
    Left = np.stack(Left, axis = 2)
    LeftBackground = np.median(Left, axis = 2).astype(np.uint16)
    for i in range(Left.shape[-1]):
        tempImg = cv2.subtract(Left[:,:,i], LeftBackground)
        ImgSavingPath = os.path.join('data',filename.split('-')[0],filename.split('-')[1],'Left%04d.tif' % i)
        cv2.imwrite(ImgSavingPath, tempImg)

    Right = [cv2.imread(pp, -1) for pp in validRightPath]
    Right = np.stack(Right, axis = 2)
    RightBackground = np.median(Right, axis = 2).astype(np.uint16)
    for i in range(Right.shape[-1]):
        tempImg = cv2.subtract(Right[:,:, i], RightBackground)
        ImgSavingPath = os.path.join('data',filename.split('-')[0],filename.split('-')[1], 'Right%04d.tif' % i)
        cv2.imwrite(ImgSavingPath, tempImg)

# %%
