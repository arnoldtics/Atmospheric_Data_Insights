library(foreign)
library(agricolae)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(car)

m1 <- read.table("O3_Temperature_3_categories.csv", header = TRUE, sep = ',')
print(names(m1))

# Let's do the ANOVA analysis for the ozone concentration
# The different samples of the temperature category are: "Low Temperature" <= 15°C, "Medium Temperature" <= 20, and "High Temperature" > 20.

anova <- aov(O3 ~ Temperature, data = m1)
summary(anova)
#                Df  Sum Sq  Mean Sq     F value Pr(>F)    
# Temperature     2   11240     5620       85.63 <2e-16 ***
# Residuals     312   20477       66    
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# We can reject the null hypothesis (with high level confidence): not all the temperature categories have the same impact on the O3 concentration

# Before, doing a Tukey test for finding the temperature categories that actually have impact on the O3 concentration,
# we hace to check the normality of the residuals and the homogeneity of their variances
ks.test(anova$residuals, "pnorm", mean(anova$residuals), sd(anova$residuals))
# p-value = 0.37 -> There is normality on the residuals

# Variance homogeneity
leveneTest(O3 ~ Temperature, data = m1)
#            Df      F value      Pr(>F)
# group       2       5.7441     0.00355 **
#           312     
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# p-value = 0.003 -> Variances are different

# So let's do an ANOVA Welch test because variances are different
anova_welch <- oneway.test(O3 ~ Temperature, data = m1, var.equal = FALSE)
print(anova_welch)
# F = 131.71, num df = 2.00, denom df = 124.92, p-value < 2.2e-16
# We can reject the null hypothesis: not all the temperature categories have the same impact on the O3 concentration

# Tukey test for checking which temperature category has a different effect on the ozone concentration
tukey <- TukeyHSD(anova)
tukey
#                                           diff        lwr        upr    p adj
# Low Temperature-High Temperature    -17.565616 -21.043334 -14.087898 0.00e+00
# Medium Temperature-High Temperature -11.854411 -14.423934  -9.284889 0.00e+00
# Medium Temperature-Low Temperature    5.711205   2.651109   8.771301 4.51e-05

# In this case all the temperature categories have a different effect on the ozone concentration
# The bigger the temperature, the more concentration of ozone we have
