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

rawPath = 'E:/BubbleRisingUltimate/BubbleRising'
for k in tqdm(range(len(fileNames))):
    filename = fileNames[k]
    frameInfo = framesInfo[k]
    startFrame = int(frameInfo.split('-')[0])
    endFrame = int(frameInfo.split('-')[1])
    targetPath = os.path.join('data',filename.split('-')[0],filename.split('-')[1])
    rawImagePath = os.path.join(rawPath, filename.split('-')[0], 'RawData')
    LeftImagePath = sorted(glob.glob(rawImagePath + '/*LA.tif'))
    RightImagePath = sorted(glob.glob(rawImagePath + '/*RA.tif'))
    Left = [cv2.imread(LeftImagePath[i], -1) for i in range(startFrame, endFrame + 1)]
    Left = np.stack(Left, axis = 2)
    LeftBackground = np.min(Left, axis = 2).astype(np.uint16)
    for i in range(Left.shape[-1]):
        tempImg = Left[:,:,i] - LeftBackground
        ImgSavingPath = os.path.join('data',filename.split('-')[0],filename.split('-')[1],'Left%04d.tif' % i)
        cv2.imwrite(ImgSavingPath, tempImg)

    Right = [cv2.imread(RightImagePath[i], -1) for i in range(startFrame, endFrame + 1)]
    Right = np.stack(Right, axis = 2)
    RightBackground = np.min(Right, axis = 2).astype(np.uint16)
    for i in range(Right.shape[-1]):
        tempImg = Right[:,:, i] - RightBackground
        ImgSavingPath = os.path.join('data',filename.split('-')[0],filename.split('-')[1], 'Right%04d.tif' % i)
        cv2.imwrite(ImgSavingPath, tempImg)

# %%
