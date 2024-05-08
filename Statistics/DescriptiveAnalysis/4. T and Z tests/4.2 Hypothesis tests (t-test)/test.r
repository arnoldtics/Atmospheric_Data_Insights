# H0: mean(O3_high_radiation) <= mean(O3_low_radiation)
# H1: mean(O3_high_radiation) > mean(O3_low_radiation)

library(moments)
library(MASS)

setwd("D:/Github/Atmospheric_Data_Insights/Statistics/DescriptiveAnalysis/4. T and Z tests/4.2 Hypothesis tests (t-test)")
high <- read.table("high_radiation.csv", header = TRUE, sep = ',')
low <- read.table("low_radiation.csv", header = TRUE, sep = ',')

# Normality test
ks.test(high$O3, "pnorm", mean(high$O3), sd(high$O3))
ks.test(low$O3, "pnorm", mean(low$O3), sd(low$O3))
# Both tests have a p-value lower than 0.05. Neither has normality.

# Boxcox transformation
O3high <- high$O3
b <- boxcox(lm(O3high ~ 1))
b$x[which.max(b$y)]
tranform_high <- O3high^0.5
ks.test(tranform_high, "pnorm", mean(tranform_high), sd(tranform_high))
# We still have a p-value lower than 0.05. No normality
O3low <- low$O3
b <- boxcox(lm(O3low ~ 1))
b$x[which.max(b$y)]
tranform_low <- O3low^0.5
ks.test(tranform_low, "pnorm", mean(tranform_low), sd(tranform_low))
# We still have a p-value lower than 0.05. No normality

# Due to neither distribution is normal, we should perform non-parametric statistical tests
# However, just to do a t-test demostration, let's continue with the process

# Variances
# We still have a p-value lower than 0.05. No normality
var(high$O3)
var(low$O3)
# H0: v_high = v_low
# H1: h_high > v_low
fc <- var(high$O3)/var(low$O3)
fc
qf(0.05, length(high$O3)-1, length(low$O3)-1, lower.tail = FALSE)
# fc > qf -> Reject H0. So the variances are different

# T-test
# H0: mean(O3_high_radiation) <= mean(O3_low_radiation)
# H1: mean(O3_high_radiation) > mean(O3_low_radiation)
t.test(high$O3, low$O3, var.equal=FALSE, alternative="less")
# P-value = 1. There is not enough evidence to reject H0
# In conclusion, the concentration of O3 during the hours of high radiation is not higher than the
# concentration of O3 during the hours of low radiation
# Note: this conclusion might not be correct because we did a parametric test when our data does not allow parametric statistics.