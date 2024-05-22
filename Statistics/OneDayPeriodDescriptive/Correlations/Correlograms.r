library(corrplot)
library(RColorBrewer)

# Pearson correlation
cor(m, method = 'pearson', use = 'pairwise.complete.obs')
m_corr <- cor(m, method = 'pearson', use = 'pairwise.complete.obs')
write.csv(m_corr, "Peason correlation for all variables.csv", row.names=TRUE)

# Plotting correlogram
png("Correlogram.png", width = 800, height = 800)
corrplot(m_corr, type = 'upper', order = 'original', col = brewer.pal(n=8, name = 'RdBu'))
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

p.mat <- cor.mtest(m_corr, method = 'pearson', use = 'pairwise.complete.obs')
png("Significant_correlations.png", width = 800, height = 800)
corrplot(m_corr, type = 'upper', order = 'original', p.mat = p.mat, sig.level = 0.01, insig = 'blank')
dev.off()
