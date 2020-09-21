# %% create data folder 
import os 
import pandas as pd
if not os.path.exists('data'):
    os.makedirs('data')
data = pd.read_csv('experiment_info.csv')
fileNames = list(data['ID'])
Subfolder = []
for name in fileNames:
    subname1 = name.split('-')[0]
    subname2 = name.split('-')[1]
    path1 = os.path.join('data', subname1)
    if not os.path.exists(path1):
        os.makedirs(path1)
    path2 = os.path.join('data', subname1, subname2)
    if not os.path.exists(path2):
        os.makedirs(path2)
if not os.path.exists('data/airbubble'):
    os.makedirs('data/airbubble')
    for i in range(4):
        path = os.path.join('data/airbubble', str(i + 1))
        os.makedirs(path)
        
# %%
