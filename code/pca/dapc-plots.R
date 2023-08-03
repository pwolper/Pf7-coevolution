## R script that visualizes the results of the dapc analysis
## 22.06.2023, Philip Wolper
library(here)
library(tidyverse)
library(adegenet)

rds_file <- here("output/pca/Pf7_chr02_2014_qSNP_dapc.rds")

outfile <- here("output/pca/Pf7.chr2.2014.qSNP.dapc.african")
outfile.txt <- paste0(outfile, ".txt")
outfile.png <- paste0(outfile, ".png")

## Read in the rst file saved in dapc-analysis.R
dapc <- readRDS(rds_file)

dapc$prior %>% str()

png(outfile.png)

scatter(dapc, cell = 0, pch = 18:23, cstar = 0, lwd = 2, lty = 2, legend = TRUE, scree.pca = TRUE)

dev.off()

## Choose indivduals from each population for the further analysis with MMC
