import pandas as pd

pathMet = "../../Datasets/Meteorology/"
pathAQ = "../../Datasets/AirQuality/"
path = "../../Datasets/"

Met = "FullMeteorology.csv"
AQ = "FullAirQuality.csv"

dfMet = pd.read_csv(pathMet + Met)
dfAQ = pd.read_csv(pathAQ + AQ)

dfAQ["Time"] = pd.to_datetime(dfAQ["Time"])
dfMet["Time"] = pd.to_datetime(dfMet["TIMESTAMP"])
dfMet.drop("TIMESTAMP", axis=1, inplace=True)

df = pd.merge(dfAQ, dfMet, how='outer', on="Time").drop_duplicates()

df.to_csv(path + "CompletedDataset.csv", index=False)