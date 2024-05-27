library(foreign)
library(agricolae)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(car)

m1 <- read.table("PM2.5_Temperature_3_categories.csv", header = TRUE, sep = ',')
print(names(m1))

# Let's do the ANOVA analysis for the PM2.5 concentration
# The different samples of the temperature category are: "Low Temperature" <= 15°C, "Medium Temperature" <= 20, and "High Temperature" > 20.

anova <- aov(PM2.5 ~ Temperature, data = m1)
summary(anova)
#              Df Sum Sq Mean Sq F value Pr(>F)    
# Temperature   2   7005    3502    88.2 <2e-16 ***
# Residuals   312  12390      40
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# We can reject the null hypothesis (with high level confidence): not all the temperature categories have the same impact on the PM2.5 concentration

# Before, doing a Tukey test for finding the temperature categories that actually have impact on the PM2.5 concentration,
# we hace to check the normality of the residuals and the homogeneity of their variances
ks.test(anova$residuals, "pnorm", mean(anova$residuals), sd(anova$residuals))
# p-value = 0.27 -> There is normality on the residuals

# Variance homogeneity
leveneTest(PM2.5 ~ Temperature, data = m1)
#        Df F value  Pr(>F)
# group   2  3.6794 0.02634 *
#       312
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# p-value = 0.02 -> Variances are different

# So let's do an ANOVA Welch test because variances are different
anova_welch <- oneway.test(PM2.5 ~ Temperature, data = m1, var.equal = FALSE)
print(anova_welch)
# F = 67.918, num df = 2.00, denom df = 107.97, p-value < 2.2e-16
# We can reject the null hypothesis: not all the temperature categories have the same impact on the PM2.5 concentration

# Tukey test for checking which temperature category has a different effect on the PM2.5 concentration
tukey <- TukeyHSD(anova)
tukey
#                                              diff             lwr            upr           p adj
# Low Temperature-High Temperature       -12.531799     -15.2369750      -9.826623       0.0000000
# Medium Temperature-High Temperature    -10.317923     -12.3166501      -8.319195       0.0000000
# Medium Temperature-Low Temperature       2.213876      -0.1664482       4.594201       0.0744055
# diff: mean difference between the two categories according to the PM2.5 concentration
# lwr - upr confidence interval
# p adj. Significance. Only Medium and Low Temperature don't have significant differences
