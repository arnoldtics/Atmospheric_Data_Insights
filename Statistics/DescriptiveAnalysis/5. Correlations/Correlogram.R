library(corrplot)
library(RColorBrewer)

m1 <- read.table("ComparisonVariables.csv", header = TRUE, sep = ',')
print(names(m1))

# Person correlation
cor(m1, method = 'pearson', use = 'pairwise.complete.obs')
M_corr <- cor(m1, method = 'pearson', use = 'pairwise.complete.obs')
write.csv(M_corr, "Person correlation for all variables.csv", sep = ',', row.names = TRUE)

# Plotting correlogram
png("Correlogram.png", width = 800, height = 800)
corrplot(M_corr, type = 'upper', order='original', col=brewer.pal(n = 8, name='RdBu'))
dev.off()

# Plotting significant correlations
cor.mtest <- function(mat, ...) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat<- matrix(NA, n, n)
  diag(p.mat) <- 0
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], ...)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
    }
  }
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
  p.mat
}
p.mat <- cor.mtest(M_corr, method='pearson', use='pairwise.complete.obs')
png("Significant_correlations.png", width = 800, height = 800)
corrplot(M_corr, type = 'upper', order='original', p.mat = p.mat, sig.level=0.01, insig = 'blank')
dev.off()
