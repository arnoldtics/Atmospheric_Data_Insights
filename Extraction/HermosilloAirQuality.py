import requests as rq 
from bs4 import BeautifulSoup as bs 
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

PATH = "../Datasets/Hermosillo/AirQuality/"

url = "https://ruoa.unam.mx/caire/erno/minuto.php"
years = [str(y) for y in range(2015, 2026)]
html = bs(rq.get(url).content, "html.parser")

links = []
for label in html.find_all('a'): 
    for year in years:
        if year in label['download'] and ".csv" in label['download'] and not "STAT" in label['download'] and "caire" in label["download"]:
            links.append(url.replace(".php", "/") + label['download'])

os.makedirs(PATH, exist_ok=True)

new, already = 0, 0
for link in links:
    name = link.split("/")[-1]
    if os.path.exists(PATH + name): already += 1
    else:
        with open(PATH + name, "wb") as file:
            response = rq.get(link)
            file.write(response.content)
            new += 1

print(f"Descargados: {new}, ya existían: {already}")