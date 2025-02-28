import pandas as pd

PATH = "../../Datasets/"

df = pd.read_csv(PATH + "CompletedDataset.csv")
df["Time"] = pd.to_datetime(df["Time"])

full_range = pd.date_range(start=df["Time"].min(), end=df["Time"].max(), freq='D')
dfFull = pd.DataFrame(full_range, columns=["Time"])
dfFinal = dfFull.merge(df, on="Time", how="left")

aggregation_functions = {
    **{col: lambda x: x.mode().iloc[0] if not x.mode().empty else None for col in dfFinal.columns if 'flag' in col},
    'WDir_Avg': lambda x: round(x).mode().iloc[0] if not x.mode().empty else None,
    'Rain_Tot': 'sum',
    'WDir_SD': 'std',
    **{col: 'mean' for col in df.columns if col not in ['Time'] and 'flag' not in col and col not in ['WDir_Avg', 'Rain_Tot', 'WDir_SD']}
}
dfDay = df.groupby(df["Time"].dt.date).agg(aggregation_functions).reset_index()

dfDay.to_csv(PATH + "Day.csv", index=False)