library(foreign)
library(agricolae)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(car)

m1 <- read.table("PM2.5_Rain_3_categories.csv", header = TRUE, sep = ',')
print(names(m1))

# Let's do the ANOVA analysis for the PM2.5 concentration
# The different samples of the rain category are: no rain, rain, and heavy rain.

anova <- aov(PM2.5 ~ Weather, data = m1)
summary(anova)
#              Df Sum Sq Mean Sq F value Pr(>F)
# Weather       2    420  210.05   3.454 0.0328 *
# Residuals   312  18975   60.82
# Then, we can reject the null hypothesis: not all the rain samples have the same impact on the PM2.5 concentration

# Before, doing a Tukey test for finding the rain categories that actually have impact on the PM2.5 concentration,
# we hace to check the normality of the residuals and the homogeneity of the variances
ks.test(anova$residuals, "pnorm", mean(anova$residuals), sd(anova$residuals))
# p-value = 0.02 -> There is not normality

# So, let's do a Kruskal-Wallis test instead of the ANOVA that we did
kruskal.test(PM2.5 ~ Weather, data = m1)
# chi-squared = 8.4563
# df = 2
# p-value = 0.0145
# In this case, we also can reject the null hypothesis: not all the rain samples have the same impact on the PM2.5 concentration

pairwise.wilcox.test(m1$PM2.5, m1$Weather, p.adjust.method = "bonferroni")
#               Heavy Rain      No Rain
#No Rain        0.750           -
#Rain           1.000           0.016
# The pair: No Rain - Rain is the one that has a significant difference

