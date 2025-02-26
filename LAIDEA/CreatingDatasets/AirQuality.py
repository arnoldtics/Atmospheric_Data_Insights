import pandas as pd
import os

pathAQ = "../../Datasets/AirQuality/"
titlesAQ = os.listdir(pathAQ)

if titlesAQ[-1] == "FullAirQuality.csv": os.remove(pathAQ + "FullAirQuality.csv")

for i, title in enumerate(titlesAQ):
    if i == 0: 
        dfAQ = pd.read_csv(pathAQ + title, skiprows=7)
        infoAQ = dfAQ.iloc[0,:]
        dfAQ.drop(0, axis=0, inplace=True)
    else:
        following = pd.read_csv(pathAQ + title, skiprows=7)
        following.drop(0, axis=0, inplace=True) 
        dfAQ = pd.concat([dfAQ, following], ignore_index=True)

dfAQ.to_csv(pathAQ + "FullAirQuality.csv", index=False)