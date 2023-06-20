#### DAPC analyis of Plasmodium genomic snps

library(here)
library(tidyverse)
library(parallel)
library(adegenet)
library(vcfR)

vcf_path <- here("data/Pf7/vcf/chr2","Pf3D7_02_v3.afr_samples.SNP.vcf.gz")

## Step 1: Reading vcf file and converting it to a genlight object using vcfR::vcfR2genlight
Pf7.metadata <- read.csv(here("data/Pf7/sample_ids/Pf7_african_samples.txt"), sep = "\t")

Pf7.snp <- read.vcfR(vcf_path, verbose = TRUE)

Pf7.snp.gl <- vcfR2genlight(Pf7.snp, n.cores = 8) #add n.cores for parallelization

pop(Pf7.snp.gl) <- Pf7.metadata$Country
ploidy(Pf7.snp.gl) <- 1

Pf7.snp.gl

Pf7.snp.gl@pop

## Performing dapc analyis
dapc1 <- dapc(Pf7.snp.gl, var.contrib = TRUE, scale = FALSE, n.da =nPop(Pf7.snp.gl) -1)
