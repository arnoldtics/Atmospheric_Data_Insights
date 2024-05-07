library(moments)

m <- read.table("VariablesToTestNormality.csv", header = TRUE, sep = ',')
print(names(m))

# Given that we have more than 400,000 instances, it is best to perform Kolmogorov-Smirnov tests 
# (although we could also perform Shapiro-Wilk tests) to test the normality of each variable in the dataset. 
# Therefore, our null hypothesis will be that there is normality in our data, 
# while the alternative hypothesis will be that there is no normality.

ks.test(m$O3, "pnorm", mean(m$O3), sd(m$O3))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for O3

ks.test(m$NO2, "pnorm", mean(m$NO2), sd(m$NO2))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for NO2

ks.test(m$NO, "pnorm", mean(m$NO), sd(m$NO))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for NO

ks.test(m$CO, "pnorm", mean(m$CO), sd(m$CO))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for CO

ks.test(m$PM10, "pnorm", mean(m$PM10), sd(m$PM10))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for PM10

ks.test(m$PM2.5, "pnorm", mean(m$PM2.5), sd(m$PM2.5))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for PM2.5

# All air quality variables don't have normality

ks.test(m$Temp_Avg, "pnorm", mean(m$Temp_Avg), sd(m$Temp_Avg))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for Temperature Average

ks.test(m$RH_Avg, "pnorm", mean(m$RH_Avg), sd(m$RH_Avg))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for Relative Humidity

ks.test(m$WSpeed_Avg, "pnorm", mean(m$WSpeed_Avg), sd(m$WSpeed_Avg))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for Wind Speed

ks.test(m$WDir_Avg, "pnorm", mean(m$WDir_Avg), sd(m$WDir_Avg))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for Wind Direction

ks.test(m$Rain_Tot, "pnorm", mean(m$Rain_Tot), sd(m$Rain_Tot))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for Rainfall Totals

ks.test(m$Press_Avg, "pnorm", mean(m$Press_Avg), sd(m$Press_Avg))
# p-value < 2.2e-16 -> reject the null hypothesis: there is no normality for atmospheric pressure

# All meteorological variables don't have normality

# So, let's try to some boxcox transformations 

library(MASS)

# O3
O3 <- m$O3
b <- boxcox(lm(O3 ~ 1))
b$x[which.max(b$y)]
tranform_O3 <- O3^0.5
ks.test(tranform_O3, "pnorm", mean(tranform_O3), sd(tranform_O3))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# NO2
NO2 <- m$NO2
b <- boxcox(lm(NO2 ~ 1))
b$x[which.max(b$y)]
tranform_NO2 <- log(NO2)
ks.test(tranform_NO2, "pnorm", mean(tranform_NO2), sd(tranform_NO2))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

#NO
NO <- m$NO
b <- boxcox(lm(NO ~ 1))
b$x[which.max(b$y)]
tranform_NO <- 1/(NO^2)
ks.test(tranform_NO, "pnorm", mean(tranform_NO), sd(tranform_NO))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

#CO
CO <- m$CO
b <- boxcox(lm(CO ~ 1))
b$x[which.max(b$y)]
tranform_CO <- CO^0.5
ks.test(tranform_CO, "pnorm", mean(tranform_CO), sd(tranform_CO))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

#PM10
pm10 <- m$PM10
b <- boxcox(lm(pm10 ~ 1))
b$x[which.max(b$y)]
tranform_PM10 <- pm10^0.5
ks.test(tranform_PM10, "pnorm", mean(tranform_PM10), sd(tranform_PM10))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

#PM2.5
pm25 <- m$PM2.5
b <- boxcox(lm(pm25 ~ 1))
b$x[which.max(b$y)]
tranform_PM25 <- pm25^0.5
ks.test(tranform_PM25, "pnorm", mean(tranform_PM25), sd(tranform_PM25))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# All air quality variables still remain without normality. In consequence, we will have to make no parametric statistics test

# Temp_Avg
temp <- m$Temp_Avg
b <- boxcox(lm(temp ~ 1))
b$x[which.max(b$y)]
tranform_temp <- temp
ks.test(tranform_temp, "pnorm", mean(tranform_temp), sd(tranform_temp))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# RH_Avg
rh <- m$RH_Avg
b <- boxcox(lm(rh ~ 1))
b$x[which.max(b$y)]
tranform_rh <- rh
ks.test(tranform_rh, "pnorm", mean(tranform_rh), sd(tranform_rh))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# WSpeed_Avg
wspeed <- m$WSpeed_Avg
b <- boxcox(lm(wspeed ~ 1))
b$x[which.max(b$y)]
tranform_wspeed <- wspeed
ks.test(tranform_wspeed, "pnorm", mean(tranform_wspeed), sd(tranform_wspeed))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# WDir_Avg
wdir <- m$WDir_Avg
b <- boxcox(lm(wdir+1 ~ 1))
b$x[which.max(b$y)]
tranform_wdir <- wdir^0.5
ks.test(tranform_wdir, "pnorm", mean(tranform_wdir), sd(tranform_wdir))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# Rain_Tot
rain <- m$Rain_Tot
b <- boxcox(lm(rain + 1 ~ 1))
b$x[which.max(b$y)]
tranform_rain <- 1/(rain^2)
ks.test(tranform_rain, "pnorm", mean(tranform_rain), sd(tranform_rain))
# p-value and Dc equal NaN.

# Press_Avg
press <- m$Press_Avg
b <- boxcox(lm(press ~ 1))
b$x[which.max(b$y)]
tranform_press <- press^2
ks.test(tranform_press, "pnorm", mean(tranform_press), sd(tranform_press))
# p-value remained < 2.2e-16. Although the Dc decreased, it was not enough to achieve normality.

# All meteorological variables still remain without normality. In consequence, we will have to make no parametric statistics test

# These results are very unusual. One possible explanation for not having normality in any variable is the amount of data: more than 400,000. 
# At these orders of magnitude, it is almost certain to have normality.s
# In fact, our Dc in most cases were very close to zero. However, they were not close enough. 
# Precisely because with 400,000 data points, the theoretical D approaches 0.00. 
# And although our Dc values are close (0.0), they did not approach close enough.