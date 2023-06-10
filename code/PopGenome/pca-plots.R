## R script for plotting the results if the pca-analysis script

library(tidyverse)
library(here)

## Load Files 
pca.scores <- read.csv(here("output/pca/Pf7.pca.scores.txt"), sep = "\t")
pca.eigenvalues <- read.csv(here("output/pca/Pf7.pca.eigenvalues.txt"), sep = "\t")
pca.loading <- read.csv(here("output/pca/Pf7.pca.loadings.txt"), sep = "\t")

str(pca.scores)

## Plotting the pca
Pf7.plot12 <- ggplot(pca.scores, aes(PC1,PC2)) + geom_point(aes(col=Country, shape = as.factor(Year)))


ggsave(Pf7.plot12, file = here("output/pca/","Pf7.chr2.pca.png"),
         device = "png", dpi = 300,
         width = 7, height = 7)
