import pandas as pd
import os 
from Clean import *

pathAQ = "../Datasets/AirQuality/"
titlesAQ = os.listdir(pathAQ)

for i, title in enumerate(titlesAQ):
    if i == 0: 
        dfAQ = pd.read_csv(pathAQ + title, skiprows=7)
        dfAQ.drop(0, axis=0, inplace=True)
    else:
        following = pd.read_csv(pathAQ + title, skiprows=7)
        following.drop(0, axis=0, inplace=True) 
        dfAQ = pd.concat([dfAQ, following], ignore_index=True)

pathMet = "../Datasets/Meteorology/"
titlesMet = os.listdir(pathMet)

for i, title in enumerate(titlesMet):
    if i == 0: 
        dfMet = pd.read_csv(pathMet + title, skiprows=6, encoding='latin1')
        dfMet.drop(0, axis=0, inplace=True)
    else:
        following = pd.read_csv(pathMet + title, skiprows=6, encoding='latin1')
        following.drop(0, axis=0, inplace=True) 
        dfMet = pd.concat([dfMet, following], ignore_index=True)

dfAQ["Time"] = pd.to_datetime(dfAQ["Time"])
dfMet["Time"] = pd.to_datetime(dfMet["TIMESTAMP"])
dfMet.drop("TIMESTAMP", axis=1, inplace=True)
df = pd.merge(dfAQ, dfMet, how='outer', on="Time").drop_duplicates()

for c in df.columns:
    if c == "Time" or "flag" in c: continue
    else: df[c] = pd.to_numeric(df[c], errors="coerce")

aggregation_functions = {
    **{col: lambda x: x.mode().iloc[0] if not x.mode().empty else None for col in df.columns if 'flag' in col},
    'WDir_Avg': lambda x: round(x).mode().iloc[0] if not x.mode().empty else None,
    'Rain_Tot': 'sum',
    'WDir_SD': 'std',
    **{col: 'mean' for col in df.columns if col not in ['Time'] and 'flag' not in col and col not in ['WDir_Avg', 'Rain_Tot', 'WDir_SD']}
}
df = df.groupby(df["Time"].dt.date).agg(aggregation_functions).reset_index()
df["City"] = "Merida"

for c in df.columns:
    if c == "RH_Avg": df[c] = df[c].apply(relativeHumidity)
    elif c == "WDir_Avg": df[c] = df[c].apply(windDirection)
    elif c == "Rain_Tot": df[c] = df[c].apply(rainfall)
    elif c == "Rad_Avg": df[c] = df[c].apply(radiation)
    elif c == "O3": df[c] = df[c].apply(o3)
    elif c == "NO": df[c] = df[c].apply(no)
    elif c == "NO2": df[c] = df[c].apply(no2)
    elif c == "SO2": df[c] = df[c].apply(so2)
    elif c == "CO": df[c] = df[c].apply(co)
    elif c == "PM10": df[c] = df[c].apply(pm)
    elif c == "PM2.5": df[c] = df[c].apply(pm)

PATH = "../Datasets/"
df.to_csv(PATH + "Merida.csv", index=False)