import pandas as pd
import os

pathMet = "../../Datasets/Meteorology/"
titlesMet = os.listdir(pathMet)

if titlesMet[-1] == "FullMeteorology.csv": os.remove(pathMet + "FullMeteorology.csv")

for i, title in enumerate(titlesMet):
    if i == 0: 
        dfMet = pd.read_csv(pathMet + title, skiprows=6, encoding='latin1')
        infoMetVariables = dfMet.iloc[0,:]
        dfMet.drop(0, axis=0, inplace=True)
    else:
        following = pd.read_csv(pathMet + title, skiprows=6, encoding='latin1')
        following.drop(0, axis=0, inplace=True) 
        dfMet = pd.concat([dfMet, following], ignore_index=True)

dfMet.to_csv(pathMet + "FullMeteorology.csv", index=False)