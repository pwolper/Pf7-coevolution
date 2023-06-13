## R script for plotting the results if the pca-analysis script

library(tidyverse)
library(here)

## Load Files 
pca.scores <- read.csv(here("output/pca/Pf7.pca.african.scores.txt"), sep = "\t")
pca.eigenvalues <- read.csv(here("output/pca/Pf7.pca.african.eigenvalues.txt"), sep = "\t")
pca.loading <- read.csv(here("output/pca/Pf7.pca.african.loadings.txt"), sep = "\t")

str(pca.scores)
str(as.vector(pca.eigenvalues$x))
str(pca.loading)

eig_percent <- round((pca.eigenvalues$x/sum(pca.eigenvalues$x))*100,2)
str(eig_percent)


barplot(100*pca.eigenvalues$x/sum(pca.eigenvalues$x))


## Plotting the pca
Pf7.plot12 <- ggplot(pca.scores, aes(PC1,PC2)) + geom_point(aes(col=Country))  +
  theme_light()
Pf7.plot12


ggsave(Pf7.plot12, file = here("output/pca/","Pf7.chr2.pca.african.png"),
         device = "png", dpi = 300,
         width = 7, height = 7)
