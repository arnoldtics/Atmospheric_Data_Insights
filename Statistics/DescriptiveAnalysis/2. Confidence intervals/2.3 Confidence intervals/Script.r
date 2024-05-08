# Instructions:
# Define two levels of significance and calculate the confidence interval of the population mean for both levels, 
# then determine if there are differences between the population means.

# The two levels of significance that I will use to calculate the confidence interval are: 0.05 and 0.01

# For this analysis of the mean samples with these confidence intervals in relation to their population means to be interesting,
# I will use the samples of the air quality variables when it was raining. 
# The goal is to analyze how much the concentration of these pollutants changes during rainfall compared to their concentration 
# throughout the year.

standarError <- function(x) {sd(x)/(sqrt(length(x)))}
confidenceInterval95 <- function(x) {mean(x) + (qnorm(c(0.025, 0.975)) * (standarError(x)))}
confidenceInterval99 <- function(x) {mean(x) + (qnorm(c(0.005, 0.995)) * (standarError(x)))}

population <- read.table("Atmospheric Data With No Missing Values.csv", header = TRUE, sep = ',')
rain1 <- read.table("RainingSamples1.csv", header = TRUE, sep = ',')
rain2 <- read.table("RainingSamples2.csv", header = TRUE, sep = ',')
rain3 <- read.table("RainingSamples3.csv", header = TRUE, sep = ',')

# O3
mean(population$O3) # 34.1781
confidenceInterval95(rain1$O3) # 32.0738 - 33.7129
confidenceInterval95(rain2$O3) # 31.7366 - 33.3230
confidenceInterval95(rain3$O3) # 31.2997 - 32.8768
confidenceInterval99(rain1$O3) # 31.8162 - 33.9704
confidenceInterval99(rain2$O3) # 31.4873 - 33.5723
confidenceInterval99(rain3$O3) # 31.0519 - 33.1246
# As we can see in this ozone case, both confidence intervals in all our rain samples show a slight decrease
# in the concentration of the molecule compared to its population mean.

# NO2
mean(population$NO2) # 4.8262
confidenceInterval95(rain1$NO2) # 3.3908 - 3.7796
confidenceInterval95(rain2$NO2) # 3.4321 - 3.8219
confidenceInterval95(rain3$NO2) # 3.2675 - 3.6289
confidenceInterval99(rain1$NO2) # 3.3298 - 3.8407
confidenceInterval99(rain2$NO2) # 3.3709 - 3.8832
confidenceInterval99(rain3$NO2) # 3.2107 - 3.6857
# For NO2, we see a reduction in its concentration in the rain in a very similar way to that of ozone.

# NO
mean(population$NO) # 0.8407
confidenceInterval95(rain1$NO) # 0.2507 - 0.3605
confidenceInterval95(rain2$NO) # 0.2504 - 0.3169
confidenceInterval95(rain3$NO) # 0.2343 - 0.3348
confidenceInterval99(rain1$NO) # 0.2334 - 0.3777
confidenceInterval99(rain2$NO) # 0.2400 - 0.3273
confidenceInterval99(rain3$NO) # 0.2186 - 0.3505
# Despite the low concentration of NO, it also decreases during the rainy season. In fact, in terms of proportion,
# it is the one that has decreased the most so far: more than 50% in both confidence intervals.

# CO (remember that the concentration of CO is in ppm, not in ppb)
mean(population$CO) # 0.3305
confidenceInterval95(rain1$CO) # 0.2567 - 0.2736
confidenceInterval95(rain2$CO) # 0.2575 - 0.2761
confidenceInterval95(rain3$CO) # 0.2547 - 0.2717
confidenceInterval99(rain1$CO) # 0.2540 - 0.2763
confidenceInterval99(rain2$CO) # 0.2549 - 0.2767
confidenceInterval99(rain3$CO) # 0.2521 - 0.2743
# Even though it's not the one that has decreased the most in proportion, CO concentrations during rainfall 
# decreased significantly when observing their confidence intervals.

# PM10
mean(population$PM10) # 24.3758
confidenceInterval95(rain1$PM10) # 16.7280 - 18.3842
confidenceInterval95(rain2$PM10) # 16.7124 - 18.5798
confidenceInterval95(rain3$PM10) # 16.3807 - 18.1609
confidenceInterval99(rain1$PM10) # 16.4678 - 18.6445
confidenceInterval99(rain2$PM10) # 16.4190 - 18.8732
confidenceInterval99(rain3$PM10) # 16.1011 - 18.4405
# As expected, the concentration of PM10 particles decreased significantly during rainfall. 
# Not to the extent of dropping by 50%, but for high concentrations in its population mean,
# the confidence intervals during rainfall do show a reduction of approximately 40%.

# PM2.5
mean(population$PM2.5) # 17.4330
confidenceInterval95(rain1$PM2.5) # 14.2198 - 15.5836
confidenceInterval95(rain2$PM2.5) # 14.3917 - 15.7982
confidenceInterval95(rain3$PM2.5) # 13.8548 - 15.2236
confidenceInterval99(rain1$PM2.5) # 14.0055 - 15.7979
confidenceInterval99(rain2$PM2.5) # 14.1708 - 16.0191
confidenceInterval99(rain3$PM2.5) # 13.6398 - 15.4387
# Unlike PM10, PM2.5 did not decrease its concentration as much during rainfall.
# This could be because rainfall lowers the concentration more for particles with a larger diameter,
# while particles with a smaller radius are not affected as much by rainfall in reducing their concentration.