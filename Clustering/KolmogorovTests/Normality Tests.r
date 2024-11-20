library(moments)
library(MASS)
m <- read.table("Atmospheric Data Cleaned Instances Per Day.csv", header = TRUE, sep = ',')
print(names(m))

# O3
ks.test(m$O3, "pnorm", mean(m$O3), sd(m$O3)) # P-value = 0.60 -> It has normal distribution
shapiro.test(m$O3) # P-value = 0.03 < 0.05 -> It hasn't normal distribution
# boxcox transformations
O3 <- m$O3
b <- boxcox(lm(O3 ~ 1))
b$x[which.max((b$y))]
transform_O3 <- O3^0.5
shapiro.test(transform_O3) # p-value = 0.006. Although the Wc decreases, it wasn't enough to reach the normal distribution

# NO2
ks.test(m$NO2, "pnorm", mean(m$NO2), sd(m$NO2)) # P-value = 0.009 -> It hasn't normal distribution
shapiro.test(m$NO2) # p-value = 3.16e-09 -> No normal distribution
# boxcox transformation
NO2 <- m$NO2
b <- boxcox(lm(NO2 ~ 1))
b$x[which.max(b$y)]
transform_NO2 <- log(NO2)
ks.test(transform_NO2, "pnorm", mean(transform_NO2), sd(transform_NO2)) # p-value = 0.84 -> It has normal distribution
shapiro.test(transform_NO2) # p-value = 0.41 -> It has normal distribution

# NO
ks.test(m$NO, "pnorm", mean(m$NO), sd(m$NO)) # p-value = 1.21e-08 -> It hasn't normal distribution
shapiro.test(m$NO) # p-value = 2.2e-16 -> It hasn't normal distribution
# boxcox transformation
NO <- m$NO
b <- boxcox(lm(NO ~ 1))
b$x[which.max(b$y)]
transform_NO <- log(NO)
ks.test(transform_NO, "pnorm", mean(transform_NO), sd(transform_NO)) # p-value = 0.765 -> It has normal distribution
shapiro.test(transform_NO) # p-value = 0.0018 -> It hasn't normal distribution

# CO
ks.test(m$CO, "pnorm", mean(m$CO), sd(m$CO)) # p-value = 0.11 -> It has normal distribution
shapiro.test(m$CO) # p-value = 0.0014 -> It hasn't normal distribution
# boxcox transformation
CO <- m$CO
b <- boxcox(lm(CO ~ 1))
b$x[which.max(b$y)]
transform_CO <- CO
shapiro.test(transform_CO) # It hasn't normal distribution

# PM10
ks.test(m$PM10, "pnorm", mean(m$PM10), sd(m$PM10)) # p-value = 0.0041 -> It hasn't normal distribution
shapiro.test(m$PM10) # p-value = 1.82e-6 -> It hasn't normal distribution
# boxcox transformation
PM10 <- m$PM10
b <- boxcox(lm(PM10 ~ 1))
b$x[which.max(b$y)]
transform_PM10 <- PM10^0.5
ks.test(transform_PM10, "pnorm", mean(transform_PM10), sd(transform_PM10)) # p-value = 0.2826 -> It has normal distribution
shapiro.test(transform_PM10) # p-value = 0.0099 -> It hasn't normal distribution

# PM2.5
ks.test(m$PM2.5, "pnorm", mean(m$PM2.5), sd(m$PM2.5)) # p-value = 0.0061 -> It hasn't normal distribution
shapiro.test(m$PM2.5) # p-value = 4.76e-8 -> It hasn't normal distribution
# boxcox transformation
PM2.5 <- m$PM2.5
b <- boxcox(lm(PM2.5 ~ 1))
b$x[which.max(b$y)]
transform_PM2.5 <- log(PM2.5)
ks.test(transform_PM2.5, "pnorm", mean(transform_PM2.5), sd(transform_PM2.5)) # p-value = 0.3375 -> It has normal distribution
shapiro.test(transform_PM2.5) # p-value = 0.0135 -> It hasn't normal distribution

# All air quality variables passed at least one normality test 


# Temp_Avg
ks.test(m$Temp_Avg, "pnorm", mean(m$Temp_Avg), sd(m$Temp_Avg)) # p-value = 0.5977 -> It has normal distribution
shapiro.test(m$Temp_Avg) # p-value = 0.0153 -> It hasn't normal distribution
# boxcox transformation
temp <- m$Temp_Avg
b <- boxcox(lm(temp ~ 1))
b$x[which.max(b$y)]
tranfomation_temp <- temp
ks.test(tranfomation_temp, "pnorm", mean(tranfomation_temp), sd(tranfomation_temp)) # p-value = 0.374 -> It has normal distribution
shapiro.test(tranfomation_temp) # p-value = 0.0153 -> It hasn't normal distribution

# RH_Avg
ks.test(m$RH_Avg, "pnorm", mean(m$RH_Avg), sd(m$RH_Avg)) # p-value = 0.001 -> It hasn't normal distribution
shapiro.test(m$RH_Avg) # p-value = 1.372e-9 -> It hasn't normal distribution
# boxcox tranformation
rh <- m$RH_Avg
b <- boxcox(lm(rh ~ 1))
b$x[which.max(b$y)]
tranfomation_rh <- rh^2
ks.test(tranfomation_rh, "pnorm", mean(tranfomation_rh), sd(tranfomation_rh)) # p-value = 0.009 -> It hasn't normal distribution
shapiro.test(tranfomation_rh) # p-value = 2.39e-8 -> It hasn't normal distribution
# At the moment rh is the only variable that haven't get normality

# WSpeed_Avg
ks.test(m$WSpeed_Avg, "pnorm", mean(m$WSpeed_Avg), sd(m$WSpeed_Avg)) # p-value = 0.040 -> It hasn't normal distribution
shapiro.test(m$WSpeed_Avg) # p-value = 7.24e-6 -> It hasn't normal distribution
# boxbox tranformation
wspeed <- m$WSpeed_Avg
b <- boxcox(lm(wspeed ~ 1))
b$x[which.max(b$y)]
tranfomation_wspeed <- wspeed^0.5
ks.test(tranfomation_wspeed, "pnorm", mean(tranfomation_wspeed), sd(tranfomation_wspeed)) # p-value = 0.288 -> It has normal distribution
shapiro.test(tranfomation_wspeed) # p-value = 0.1912 -> It has normal distribution

# WDir_Avg
ks.test(m$WDir_Avg, "pnorm", mean(m$WDir_Avg), sd(m$WDir_Avg)) # p-value = 0.8227 -> It has normal distribution
shapiro.test(m$WDir_Avg) # p-value = 0.08 -> It has normal distribution

# Rain_Tot
ks.test(m$Rain_Tot, "pnorm", mean(m$Rain_Tot), sd(m$Rain_Tot)) # p-value = 2.2e-16 -> It hasn't normal distribution
shapiro.test(m$Rain_Tot) # p-value = 2.2e-16 -> It hasn't normal distribution
# boxcox tranformation
rain <- m$Rain_Tot
b <- boxcox(lm(rain ~ 1))
b$x[which.max(b$y)]
tranfomation_rain <- rain ^ 0.5
ks.test(tranfomation_rain, "pnorm", mean(tranfomation_rain), sd(tranfomation_rain)) # p-value = 2.2e-16 -> It hasn't normal distribution, eventhough the Dc increased
shapiro.test(tranfomation_rain) # p-value = 2.2e-16 -> It hasn't normal distribution
# No normality for this variable

# Press_Avg
ks.test(m$Press_Avg, "pnorm", mean(m$Press_Avg), sd(m$Press_Avg)) # p-value = 0.83 -> It has normal distribution
shapiro.test(m$Press_Avg) # p-value = 0.64 -> It has normal distribution

# Rad_Avg
ks.test(m$Rad_Avg, "pnorm", mean(m$Rad_Avg), sd(m$Rad_Avg)) # p-value = 0.1308 -> It has normal distribution
shapiro.test(m$Rad_Avg) # p-value = 2.75e-8 -> It hasn't normal distribution
# boxcox tranfomation
radiation <- m$Rad_Avg
b <- boxcox(lm(radiation ~ 1))
b$x[which.max(b$y)]
tranfomation_radiation <- radiation^2
ks.test(tranfomation_radiation, "pnorm", mean(tranfomation_radiation), sd(tranfomation_radiation)) # p-value = 0.2795 -> It has normal distribution
shapiro.test(tranfomation_radiation) # p-value = 6.99e-5 -> It hasn't normal distribution

# All meteorological variables except RH_Avg (relative humidity) and Rain_Tot (rainfall total) present normality with at least one test