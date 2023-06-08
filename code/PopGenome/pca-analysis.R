## R script for PCA analysis of the Pf7 populations
library(here)
library(tidyverse)
library(parallel)

if(!require(adegenet)){
    install.packages("adegenet")
    library(adegenet)}
if(!require(here)){
    install.packages("here")
    library(here)}
if(!require(vcfR)){
    install.packages("vcfR")
    library(vcfR)}

vcf_path <- here("data/Pf7/vcf/chr2","Pf3D7_02_v3.samples.SNP.vcf.gz")

## Step 1: Reading vcf file and converting it to a genlight object using vcfR::vcfR2genlight
Pf7.metadata <- read.csv(here("data/Pf7/sample_ids/Pf7_multi_samples.txt"), sep = "\t")

Pf7.snp <- read.vcfR(vcf_path, verbose = TRUE)

Pf7.snp.gl <- vcfR2genlight(Pf7.snp, n.cores = 8) #add n.cores for parallelization

pop(Pf7.snp.gl) <- Pf7.metadata$Country
ploidy(Pf7.snp.gl) <- 1

Pf7.snp.gl

Pf7.snp.gl@pop

## Step 2: Calculating PCA using adegenet::glPca(). How do the populations cluster? By geographic location? Can we see effects of the years?
Pf7.pca <- glPca(Pf7.snp.gl, nf = 10, parallel = TRUE, n.cores = 8) #add parallel=TRUE, n.cores for parallelization
Pf7.pca

Pf7.pca.scores <- as_tibble(Pf7.pca$scores)
Pf7.pca.scores$Country <- Pf7.metadata$Country
Pf7.pca.scores$Year <- Pf7.metadata$year
Pf7.pca.scores$id <- Pf7.metadata$id
Pf7.pca.scores

## Extracting eigenvalues
eig.total <- sum(Pf7.pca$eig)

write.table(here("output/pca/Pf7.pca.eigenvalues.txt"), eig.total , sep = "\t")
write.table(here("output/pca/Pf7.pca.scores.txt"), Pf7.pca.scores, sep = "\t")
write.table(here("output/pca/Pf7.pca.loadings.txt"), Pf7.pca$loadings, sep = "\t")

## Plotting the pca
Pf7.plot12 <- ggplot(Pf7.pca.scores, aes(PC1,PC2)) + geom_point()


ggsave(Pf7.plot12, file = here("output/pca/","Pf7.chr2.pca.parallel.samples.png"),
         device = "png", dpi = 300,
         width = 7, height = 7)
