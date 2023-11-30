## Calculation of theta_W for the sliding windows of Pf7 chromosomes.
##

library(tidyverse)
library(PopGenome)
library(here)

## Variables
filename <- "Pf3D7_11_v3.gambian_samples.qSNP.GT_filtered.vcf.gz"
data_dir <- "chr11" #vcf subfolder contaning the vcf data
chr_tid <- "Pf3D7_11_v3"
chr_start <- 1
#chr_end <- 1000000
chr_end <- 2040000 #for chr11

output_filename <- "Pf7.chr11.gambia.stats.10kb.GT_filtered"
output_txt <- paste0(output_filename,".txt")
output_png <- paste0(output_filename,".png")

#### CODE STARTS HERE ####
## Read Sample data
Pf7_samples <- read.csv(here("data/Pf7/sample_ids/Pf7_gambia_samples.txt"), sep = "\t")
str(Pf7_samples)

## Reading in the vcf data
source(here("code/PopGenome/functions/read_Pf7_vcf.R"))
vcf <- read_Pf7_vcf(dir = data_dir, file = filename, chr_tid, Pf7_samples, chr_start, chr_end)

get_gff_info(gff.file = here("data/Pf7/gff/Pfalciparum_replace_Pf3D7_MIT_v3_with_Pf_M76611.gff"),
             chr = "Pf3D7_02_v3", feature = "non-coding") %>% str()

## Set Populations
#source(here("code/PopGenome/functions/set_populations.R"))
#vcf <- set_populations(vcf, Pf7_samples, population = Pf7_samples$Country)

# Neutrality stats
vcf.neutrality <- neutrality.stats(vcf, FAST=TRUE)
stats <- get.neutrality(vcf.neutrality, theta = TRUE)[[1]]
str(stats)
stats
stats[[11]]

# recombination and split coding region stats
vcf@n.biallelic.sites

vcf.coding <- splitting.data(vcf, subsites = "gene")
vcf.coding@n.sites
vcf.coding@region.data@biallelic.sites %>% str()
vcf.coding@n.biallelic.sites #why no sites?

vcf.linkage <- linkage.stats(vcf.coding)
linkage.values <- get.linkage(vcf.linkage)[[1]]

vcf.recomb <- recomb.stats(vcf.coding)
recomb.values <- get.recomb(vcf.recomb)[[1]]
recomb.values

# Segregating sites on sliding window
source(here("code/PopGenome/functions/calc_stats_sliding_window.R"))
sliding.stats <- calc_stats_sliding_window(vcf, 10000, 2500)

write.table(sliding.stats, file = here("output/stats",output_txt), sep = "\t", row.names = FALSE)

# Plotting the segregating sites
## source(here("code/PopGenome/functions/plots.R"))
## sliding.stats.formatted <- format_Popgenome_stats(sliding.stats, output_txt)

## plot_S_chr11(vcf.S.formatted,output_png)
