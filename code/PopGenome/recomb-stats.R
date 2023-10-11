
library(tidyverse)
library(PopGenome)
library(here)

## Variables
filename <- "Pf3D7_11_v3.afr_samples.qSNP.GT_filtered.vcf.gz"
data_dir <- "chr11" #vcf subfolder contaning the vcf data
chr_tid <- "Pf3D7_11_v3"
chr_start <- 1
#chr_end <- 1000000
chr_end <- 2040000 #for chr11


#### CODE STARTS HERE ####
## Read Sample data
Pf7_samples <- read.csv(here("data/Pf7/sample_ids/Pf7_african_samples.txt"), sep = "\t")
str(Pf7_samples)

## Reading in the vcf data
source(here("code/PopGenome/functions/read_Pf7_vcf.R"))
vcf <- read_Pf7_vcf(dir = data_dir, file = filename, chr_tid, Pf7_samples, chr_start, chr_end)

get_gff_info(gff.file = here("data/Pf7/gff/Pfalciparum_replace_Pf3D7_MIT_v3_with_Pf_M76611.gff"),
             chr = "Pf3D7_02_v3", feature = "gene") %>% str()

# Neutrality stats
vcf.neutrality <- neutrality.stats(vcf, FAST=TRUE)
stats <- get.neutrality(vcf.neutrality, theta = TRUE)[[1]]
str(stats)

# recombination and split coding region stats
## vcf@n.biallelic.sites

## vcf.coding <- splitting.data(vcf, subsites = "gene")
## vcf.coding@n.sites
## vcf.coding@region.data@biallelic.sites %>% str()
## vcf.coding@n.biallelic.sites #why no sites?

## vcf.coding.linkage <- linkage.stats(vcf.coding)
## linkage.coding.values <- get.linkage(vcf.linkage)[[1]]
## linkage.coding.values

## vcf.coding.recomb <- recomb.stats(vcf.coding)
## recomb.coding.values <- get.recomb(vcf.recomb)[[1]]
## recomb.coding.values

## write.csv(recomb.coding.values, here("output/recomb/recomb_chr11_genes.txt"))
## write.csv(linkage.coding.values, here("output/recomb/linkage_chr11_genes.txt"))

# recombination in sliding windows 10 kb.

vcf.windows <- sliding.window.transform(vcf, width = 10000, jump = 2500, type = 2)

vcf.windows <- neutrality.stats(vcf.windows)
vcf.windows <- recomb.stats(vcf.windows)

recomb.vcf.windows <- as.data.frame(get.recomb(vcf.windows)[[1]])
str(recomb.vcf.windows)

pos <- unname(sapply(vcf.windows@region.names, function(x){
    split <- strsplit(x," ")[[1]][c(1,3)]
    val <- mean(as.numeric(split))
    return(val)
}))
str(pos)

recomb.vcf.windows$pos <- pos
str(recomb.vcf.windows)

write.csv(recomb.vcf.windows, here("output/recomb/recomb_chr11_windows.txt"), row.names = FALSE)
