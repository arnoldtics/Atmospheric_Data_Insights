library(moments)
library(MASS)
m_no_rain <- read.table('PM2.5_no_rain.csv', header = TRUE,  sep = ',')
m_rain <- read.table('PM2.5_With_Rain.csv', header = TRUE,  sep = ',')

print(names(m_no_rain))
print(names(m_rain))

no_rain <- m_no_rain$PM2.5
rain <- m_rain$PM2.5


# Checking the distribution with a boxplot
png("boxplot.png", width = 800, 1200)
boxplot(no_rain, rain)
dev.off()
# It is possible that the days with no rainfall, the PM2.5 concentration was bigger than the days when there was rainfall


skewness(no_rain)
skewness(rain)
# Both skewness are in a normal range. The samples of the days with rain have a bigger skewness: 1.18


# Checking the number of instances for deciding for normality tests and for degrees of freedom
length(no_rain) # 224
length(rain) # 91


# Normality test
# H0: they have normal distribution
# H1: they don't have normal distribution
ks.test(no_rain, "pnorm", mean(no_rain), sd(no_rain)) # p-value = 0.03 -> It hasn't normal distribution
ks.test(rain, "pnorm", mean(rain), sd(rain)) # p-value = 0.17 -> It has normal distribution

# Box-cox transformation for no_rain
b <- boxcox(lm(no_rain ~ 1))
b$x[which.max(b$y)] # 0.2626
tranform_no_rain <- no_rain^0.5
ks.test(tranform_no_rain, "pnorm", mean(tranform_no_rain), sd(tranform_no_rain)) # p-value = 0.26 -> It has normal distribution


# Variance homogeneity
# H0: var(no_rain) = var(rain)
# H1: var(no_rain) < var(rain)
var(tranform_no_rain)
var(rain)
fc <- var(rain)/var(tranform_no_rain)
fc # fc = 76.90
qf(0.05, 223, 90, lower.tail=FALSE) # ft = 1.35
# H0 rejected. Variances are different


# t-student test
# H0: mean(transform_no_rain) <= mean(rain)
# H1: mean(transform_no_rain) > mean(rain)
t.test(tranform_no_rain, rain, var.equal = FALSE, alternative = "greater")
# p-value = 1
# df = 90.952
# tc = -13.787
qt(0.95, 90.952) # tt = 1.66
# H0 accepted
# There is no enough evidence to demostrate that concentration of PM2.5 is bigger during the days with no rainfall


# With both samples tranformed
tranform_rain <- rain^0.5
# Variance homogeneity
# H0: var(transform_no_rain) = var(transform_rain)
# H1: var(transform_no_rain) < var(transform_rain)
var(tranform_no_rain)
var(tranform_rain)
fc <- var(tranform_rain)/var(tranform_no_rain)
fc # fc = 1.11
qf(0.05, 223, 90, lower.tail=FALSE) # ft = 1.35
# H0 accepted. Variances are equal
# t-student test
# H0: mean(transform_no_rain) <= mean(tranform_rain)
# H1: mean(transform_no_rain) > mean(tranform_rain)
t.test(tranform_no_rain, tranform_rain, var.equal = TRUE, alternative="greater")
# p-value = 0.002
# df = 313
# tc = 2.87
qt(0.95, 313) # tt = 1.64
# H0 rejected. PM2.5 concentration during the days when there is no rainfall is bigger


# With both samples without the transformation
# Variance homogeneity
# H0: var(no_rain) = var(rain)
# H1: var(no_rain) < var(rain)
var(no_rain)
var(rain)
fc <- var(rain)/var(no_rain)
fc # fc = 1.05
qf(0.05, 223, 90, lower.tail=FALSE) # 1.35
# H0 accepted. Variances are equal
# t-student test
# H0: mean(no_rain) <= meanrain)
# H1: mean(no_rain) > meanrain)
t.test(no_rain, rain, var.equal = TRUE, alternative="greater")
# p-value = 0.004
# df = 313
# tc = 2.62
qt(0.95, 313) # tt = 1.64
# H0 rejected. PM2.5 concentration during the days when there is no rainfall is bigger
