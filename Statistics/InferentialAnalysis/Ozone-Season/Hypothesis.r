library(moments)
m_autumn_winter <- read.table("Ozone_Autumn_Winter.csv", header=TRUE, sep = ',')
m_spring_summer <- read.table('Ozone_Spring_Summer.csv', header = TRUE,  sep = ',')

print(names(m_autumn_winter))
print(names(m_spring_summer))

hot_season <- m_spring_summer$O3
cold_season <- m_autumn_winter$O3


# Checking the distribution with a boxplot
png("boxplot.png", width=800, height=1200)
boxplot(hot_season, cold_season)
dev.off()
# It is possible that during the cold season the ozone concentration decreases


skewness(hot_season)
skewness(cold_season)
# Both skewness are in a normal range


# Checking the number of instances for deciding for normality tests and for degrees of freedom
length(hot_season)
length(cold_season)


# Over than 150 instances: Kolmogorov-Smirnov needed
# H0: they have normal distribution
# H1: they don't have normal distribution
ks.test(hot_season, "pnorm", mean(hot_season), sd(hot_season)) # p-value = 0.28 -> it has nomal distribution
ks.test(cold_season, "pnorm", mean(cold_season), sd(cold_season)) # p-value = 0.46 -> it has normal distrution


# Variance homogeneity
# H0: var(hot_season) = var(cold_season)
# H1: var(hot_season) < var(cold_season)
var(hot_season)
var(cold_season)
fc <- var(cold_season)/var(hot_season)
fc # Fc = 1.17
qf(0.05, 158, 155, lower.tail=FALSE)
# H0 accepted -> H0 accepted, variances are equal


# t-student test
# H0: mean(hot_season) <= mean(cold_season)
# H1: mean(hot_season) > mean(cold_season)
t.test(hot_season, cold_season, var.equal = TRUE, alternative = "greater")
# p-value = 2.2e-16
# df = 313
# tc = 8.6816
qt(0.95, 313) # tt = 1.64 
# Alternative hypothesis accepted. 
# Ozone concentration is bigger during the summer and spring