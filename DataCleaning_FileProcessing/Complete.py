import pandas as pd

PATH = "../Datasets/"

dfMorelia = pd.read_csv(PATH + "Morelia.csv")
dfJuriquilla = pd.read_csv(PATH + "Juriquilla.csv")
dfMerida = pd.read_csv(PATH + "Merida.csv")
dfHermosillo = pd.read_csv(PATH + "Hermosillo.csv")
dfSaltillo = pd.read_csv(PATH + "Saltillo.csv")

df = pd.concat([dfMorelia, dfJuriquilla, dfMerida, dfHermosillo, dfSaltillo], axis=0)
df["Time"] = pd.to_datetime(df["Time"])
df.sort_values("Time", inplace=True)

df.to_csv(PATH + "Complete.csv", index=False)