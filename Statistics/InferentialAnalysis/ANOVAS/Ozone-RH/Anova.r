library(foreign)
library(agricolae)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(car)

m1 <- read.table("O3_RH_3_categories.csv", header = TRUE, sep = ',')
print(names(m1))

# Let's do the ANOVA analysis for the ozone concentration
# The different samples of the relative humidity category are: "Humidity 1" < 33%, "Humidity 2" < 43%, "Humidity 3" < 53%, "Humidity 4" < 63%, "Humidity 5" < 73%, "Humidity 6" < 83%, and "Humidity 7" >= 83%

anova <- aov(O3 ~ RelativeHumidity, data = m1)
summary(anova)
#                        Df      Sum Sq     Mean Sq      F value    Pr(>F)    
# RelativeHumidity        6       15451      2575.2        48.76    <2e-16 ***
# Residuals             308       16265        52.8     
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# We can reject the null hypothesis (with high level confidence): not all the relative humidity categories have the same impact on the O3 concentration

# Before, doing a Tukey test for finding the RH categories that actually have impact on the O3 concentration,
# we hace to check the normality of the residuals and the homogeneity of their variances
ks.test(anova$residuals, "pnorm", mean(anova$residuals), sd(anova$residuals))
# p-value = 0.93 -> There is normality on the residuals

# Variance homogeneity
leveneTest(O3 ~ RelativeHumidity, data = m1)
#             Df         F value     Pr(>F)
# group        6          0.9769     0.4409
#            308
# p-value = 0.44 -> Variances are equal

# Tukey test for checking which relative humidity category has a different effect on the ozone concentration
tukey <- TukeyHSD(anova)
tukey
#                              diff        lwr         upr     p adj
# Humidity 2-Humidity 1  -0.9240383  -7.303976   5.4558988 0.9995133
# Humidity 3-Humidity 1  -5.5160681 -11.928943   0.8968065 0.1445273
# Humidity 4-Humidity 1  -9.6965367 -16.273310  -3.1197632 0.0003308
# Humidity 5-Humidity 1 -11.6634703 -17.732001  -5.5949396 0.0000006
# Humidity 6-Humidity 1 -19.0294496 -25.097980 -12.9609189 0.0000000
# Humidity 7-Humidity 1 -27.4703101 -36.912781 -18.0278388 0.0000000
# Humidity 3-Humidity 2  -4.5920298  -9.042202  -0.1418581 0.0381168
# Humidity 4-Humidity 2  -8.7724983 -13.455768  -4.0892285 0.0000012
# Humidity 5-Humidity 2 -10.7394320 -14.677215  -6.8016493 0.0000000
# Humidity 6-Humidity 2 -18.1054113 -22.043194 -14.1676285 0.0000000
# Humidity 7-Humidity 2 -26.5462717 -34.782735 -18.3098082 0.0000000
# Humidity 4-Humidity 3  -4.1804685  -8.908510   0.5475732 0.1223113
# Humidity 5-Humidity 3  -6.1474022 -10.138329  -2.1564756 0.0001417
# Humidity 6-Humidity 3 -13.5133815 -17.504308  -9.5224549 0.0000000
# Humidity 7-Humidity 3 -21.9542419 -30.216245 -13.6922390 0.0000000
# Humidity 5-Humidity 4  -1.9669336  -6.216226   2.2823585 0.8154273
# Humidity 6-Humidity 4  -9.3329129 -13.582205  -5.0836208 0.0000000
# Humidity 7-Humidity 4 -17.7737734 -26.163629  -9.3839175 0.0000000
# Humidity 6-Humidity 5  -7.3659793 -10.776199  -3.9557594 0.0000000
# Humidity 7-Humidity 5 -15.8068397 -23.804514  -7.8091652 0.0000002
# Humidity 7-Humidity 6  -8.4408605 -16.438535  -0.4431860 0.0309880

# In close categories there are not significant changes
# Specifically, in low percentages of rh, there are no significant changes on the ozone concentration
# But, the more rh we have, the more ozone concreation we get
