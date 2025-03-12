import numpy as np

def windDirection(x):
    if x > 0 and x <= 360: return x
    return np.nan

def rainfall(x):
    if x >= 0: return x
    return np.nan

def radiation(x):
    if x > 0: return x
    return np.nan

def relativeHumidity(x):
    if x >= 0 and x <= 100: return x
    return np.nan

def o3(x):
    if x >= 0.03 and x <= 500: return x
    return np.nan

def co(x):
    if x >= 0.04 and x <= 25: return x
    return np.nan

def no2(x):
    if x >= 0.4 and x <= 300: return x
    return np.nan

def no(x):
    if x >= 0.4 and x <= 500: return x
    return np.nan

def so2(x):
    if x >= 0.5 and x <= 1000: return x
    return np.nan

def pm(x):
    if x >= 4 and x <= 400: return x
    return np.nan