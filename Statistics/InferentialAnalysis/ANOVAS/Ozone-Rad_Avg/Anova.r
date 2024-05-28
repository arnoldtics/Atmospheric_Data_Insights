library(foreign)
library(agricolae)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(car)

m1 <- read.table("O3_Rad_Avg_3_categories.csv", header = TRUE, sep = ',')
print(names(m1))

# Let's do the ANOVA analysis for the ozone concentration
# The different samples of the solar radiation category are: "Radiation 1" <= 300 W/m^2, "Radiation 2" <= 500 W/m^2, and "Radiation 3" > 500 W/m^2

anova <- aov(O3 ~ Radiation, data = m1)
summary(anova)
#                 Df     Sum Sq  Mean Sq     F value    Pr(>F)    
# Radiation        2       6120     3060        37.3    3e-15 ***
# Residuals      312      25597       82                       
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# We can reject the null hypothesis (with high level confidence): not all the solar radiation categories have the same impact on the O3 concentration

# Before, doing a Tukey test for finding the radiation categories that actually have impact on the O3 concentration,
# we hace to check the normality of the residuals and the homogeneity of their variances
ks.test(anova$residuals, "pnorm", mean(anova$residuals), sd(anova$residuals))
# p-value = 0.6299 -> There is normality on the residuals

# Variance homogeneity
leveneTest(O3 ~ Radiation, data = m1)
#        Df F value Pr(>F)
# group   2  1.7462 0.1761
#       312
# p-value = 0.17 -> Variances are equal

# Tukey test for checking which radiation category has a different effect on the ozone concentration
tukey <- TukeyHSD(anova)
tukey
#                              diff      lwr       upr     p adj
# Radiation 2-Radiation 1  7.127965 2.791436 11.464494 0.0003876
# Radiation 3-Radiation 1 13.876173 9.524272 18.228074 0.0000000
# Radiation 3-Radiation 2  6.748208 4.225069  9.271348 0.0000000

# All the categories presents different impact on the ozone concentration
# Specially, low levels of radiation decrease the ozone concentration
