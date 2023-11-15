#### DAPC analyis of Plasmodium genomic snps

library(here)
library(tidyverse)
library(parallel)
library(adegenet)
library(vcfR)

vcf_path <- here("data/Pf7/vcf/chr2","Pf3D7_02_v3.afr_samples.qSNP.GT_filtered.vcf.gz")
filename <- "Pf7_chr2_GT_filtered_dapc_with_Kmeans.rds"

## Step 1: Reading vcf file and converting it to a genlight object using vcfR::vcfR2genlight
Pf7.metadata <- read.csv(here("data/Pf7/sample_ids/Pf7_african_samples.txt"), sep = "\t")

Pf7.snp <- read.vcfR(vcf_path, verbose = TRUE)

Pf7.snp.gl <- vcfR2genlight(Pf7.snp, n.cores = 8) #add n.cores for parallelization

pop(Pf7.snp.gl) <- Pf7.metadata$Country
ploidy(Pf7.snp.gl) <- 1

Pf7.snp.gl

#Pf7.snp.gl@pop

## Performing dapc analyis

clust <- find.clusters(Pf7.snp.gl, max.n.clust = 30)
clust

saveRDS(clust, here("output/pca", "Kmeans_clustering_chr11.rds"))

dapc <- dapc(Pf7.snp.gl, n.pca = 3, n.da = 3)
dapc

## #dapc1 <- dapc(Pf7.snp.gl, var.contrib = TRUE, scale = FALSE, n.pca = 500, n.da = nPop(Pf7.snp.gl)-1)

## Save dapc object to .rds file to load later
saveRDS(dapc, here("output/pca", filename))
