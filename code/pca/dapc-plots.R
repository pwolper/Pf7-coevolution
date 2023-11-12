## R script that visualizes the results of the dapc analysis
## 22.06.2023, Philip Wolper
library(here)
library(tidyverse)
library(adegenet)

rds_file <- here("output/pca/Pf7_chr02_GT_filtered_dapc_with_9_pop.rds")

outfile <- here("output/pca/Pf7.chr2.qSNP.GT_filtered_with_9_pops")
outfile.txt <- paste0(outfile, ".txt")
outfile.png <- paste0(outfile, ".png")

## Country metadata
Pf7.metadata <- read.csv(here("data/Pf7/sample_ids/Pf7_african_samples.txt"), sep = "\t")
country_grp <- setNames(as.factor(Pf7.metadata$Country), Pf7.metadata$id)
str(country_grp)

year_grp <- setNames(as.factor(Pf7.metadata$year), Pf7.metadata$id)
str(year_grp)

## Read in the rst file saved in dapc-analysis.R
dapc <- readRDS(rds_file)
clust <- readRDS(here("output/pca/Kmeans_clustering.rds"))
clust$grp %>% str()

dapc$prior %>% str()


scatter(dapc, grp = country_grp, cstar = 0, scree.da = TRUE, legend = TRUE)

scatter(dapc, grp = year_grp, cstar = 0, scree.da = TRUE, legend = TRUE)


png(outfile.png)

scatter(dapc, cstar = 0, scree.da = TRUE, legend = TRUE)

dev.off()

## Choose indivduals from each population for the further analysis with MMC
