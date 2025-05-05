import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.impute import KNNImputer

sns.set_style("darkgrid")

def null_matrix(df:pd.DataFrame):
    plt.figure(figsize=(12, 6))
    sns.heatmap(df.isnull(), 
                cbar=False, 
                cmap=["#2E8B57", "#E8F5E9"],  
                yticklabels=False)  

    plt.xlabel("Variables", fontsize=12)
    plt.ylabel("Instances", fontsize=12)
    plt.title("Null-data matrix for RUOA database", fontsize=14)

    plt.tight_layout()
    plt.show()

def flags(df:pd.DataFrame):
    variables = ["O3", "SO2", "NO2", "NO", "CO", "PM10", "PM2.5"]
    for v in variables:
        df.loc[(df[v + "_flag"].isnull()) & (df[v].isnull()), v + "_flag"] = "OS"
        df.loc[(df[v + "_flag"].isnull()) & (df[v].isna()), v + "_flag"] = "OS"
        df.loc[(df[v + "_flag"].isnull()) & (df[v].notnull()), v + "_flag"] = "OK"
        df.loc[(df[v + "_flag"] == "OS") & (df[v].notnull()), v + "_flag"] = "OK"

def wind_speed_max(df:pd.DataFrame):
    df.loc[df["WSpeed_Avg"].notnull() & df["WSpeed_Max"].isnull(), "WSpeed_Max"] = df.loc[df["WSpeed_Avg"].notnull() & df["WSpeed_Max"].isnull(), "WSpeed_Avg"]

def knn_imputation(df:pd.DataFrame, n:int):
    numeric_cols = df.select_dtypes(include=[np.number]).columns.tolist()
    non_numeric_cols = df.columns.difference(numeric_cols).tolist()
    
    if not numeric_cols: return df
    
    df_numeric = df[numeric_cols].copy()
    df_non_numeric = df[non_numeric_cols].copy()

    ss = StandardScaler()
    ss_data = ss.fit_transform(df_numeric)

    model_imputer = KNNImputer(n_neighbors=n)
    imputed_data = model_imputer.fit_transform(ss_data)

    imputed_data = ss.inverse_transform(imputed_data)

    df_imputed_numeric = pd.DataFrame(imputed_data, columns=numeric_cols, index=df.index)
    df_final = pd.concat([df_imputed_numeric, df_non_numeric], axis=1)

    df_final = df_final[df.columns]

    return df_final