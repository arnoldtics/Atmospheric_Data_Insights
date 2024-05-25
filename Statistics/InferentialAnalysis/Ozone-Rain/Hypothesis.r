library(moments)
m_rain <- read.table('Ozone_With_Rain.csv', header = TRUE,  sep = ',')
m_no_rain <- read.table('Ozone_no_rain.csv', header = TRUE,  sep = ',')

print(names(m_rain))
print(names(m_no_rain))

rain <- m_rain$O3
no_rain <- m_no_rain$O3


# Checking the distribution with a boxplot
png("boxplot.png", width = 800, 1200)
boxplot(no_rain, rain)
dev.off()
# It is possible that the days with no rainfall, the ozone concentration was bigger than the days when there was rainfall


skewness(no_rain)
skewness(rain)
# Both skewness are in a normal range. In fact, no rainfall samples have almost symetry distribution. skewness = 0.01


# Checking the number of instances for deciding for normality tests and for degrees of freedom
length(no_rain) # 224
length(rain) # 91


# Normality test
# H0: they have normal distribution
# H1: they don't have normal distribution
ks.test(no_rain, "pnorm", mean(no_rain), sd(no_rain)) # p-value = 0.55 -> It has normal distribution
ks.test(rain, "pnorm", mean(rain), sd(rain)) # p-value = 0.98 -> It has normal distribution


# Variance homogeneity
# H0: var(no_rain) = var(rain)
# H1: var(no_rain) > var(rain)
var(no_rain)
var(rain)
fc <- var(no_rain)/var(rain)
fc # fc = 1.11
qf(0.05, 223, 90, lower.tail=FALSE) # ft = 1.35
# H0 accepted. Variances have homogenuity


# t-student test
# H0: mean(no_rain) <= mean(rain)
# H1: mean(no_rain) > mean(rain)
t.test(no_rain, rain, var.equal = TRUE, alternative = "greater")
# p-value = 0.02
# df = 313
# tc = 2.05
qt(0.95, 313) # tt = 1.64
# Alternative hypothesis accepted
# Ozone concentration is bigger during the days when there is not rainfall
