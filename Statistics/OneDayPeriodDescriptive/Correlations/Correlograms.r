library(corrplot)
library(RColorBrewer)

cor(m, method = 'pearson', use = 'pairwise.complete.obs')
m_corr <- cor(m, method = 'pearson', use = 'pairwise.complete.obs')
write.csv(m_corr, "Peason correlation for all variables.csv", sep= ',', row.names=TRUE)
