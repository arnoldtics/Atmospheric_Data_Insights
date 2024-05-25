library(moments)
m_autumn_winter <- read.table("PM2.5_Autumn_Winter.csv", header=TRUE, sep = ',')
m_spring_summer <- read.table('PM2.5_Spring_Summer.csv', header = TRUE,  sep = ',')

print(names(m_autumn_winter))
print(names(m_spring_summer))

hot_season <- m_spring_summer$PM2.5
cold_season <- m_autumn_winter$PM2.5


# Checking the distribution with a boxplot
png("boxplot.png", width = 800, height = 1200)
boxplot(hot_season, cold_season)
dev.off()
# It is possible that during the cold season the PM2.5 concentration decreases


skewness(hot_season)
skewness(cold_season)
# Both skewness are in a normal range. In fact, both have very similar values, so they have almost the same skewness


# Checking the number of instances for deciding for normality tests and for degrees of freedom
length(hot_season)
length(cold_season)
# hot_season = 159
# cold_season = 156


# Over than 150 instances: Kolmogorov-Smirnov needed
# H0: they have normal distribution
# H1: they don't have normal distribution
ks.test(hot_season, "pnorm", mean(hot_season), sd(hot_season)) # p-value = 0.23 -> it has nomal distribution
ks.test(cold_season, "pnorm", mean(cold_season), sd(cold_season)) # p-value = 0.30 -> it has normal distrution


# Variance homogeneity
# H0: var(hot_season) = var(cold_season)
# H1: var(hot_season) > var(cold_season)
var(hot_season)
var(cold_season)
fc <- var(hot_season)/var(cold_season)
fc # Fc = 2.31
qf(0.05, 158, 155, lower.tail=FALSE) # Ft = 1.30
# H0 rejected. Var(hot_season) > var(cold_season)


# t-student test
# H0: mean(hot_season) <= mean(cold_season)
# H1: mean(hot_season) > mean(cold_season)
t.test(hot_season, cold_season, var.equal = FALSE, alternative = "greater")
# p-value = 4.93e-14
# df = 273.67
# tc = 7.84
qt(0.95, 273.67) # tt = 1.65
# Alternative hypothesis accepted
# PM2.5 concentration is bigger during the summer and spring

