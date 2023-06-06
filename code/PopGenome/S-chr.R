## Calculation of theta_W for the sliding windows of Pf7 chromosomes.
##

library(tidyverse)
library(PopGenome)
library(here)

## Variables
filename <- "Pf3D7_11_v3.SNP.vcf.gz"
data_dir <- "chr11" #vcf subfolder contaning the vcf data
chr_tid <- "Pf3D7_11_v3"

output_filename <- "Pf7.chr11.S.DRC_GM_KE_MM"

output_txt <- paste0(output_filename,".txt")
output_png <- paste0(output_filename,".png")

## Read Sample data
Pf7_samples <- read.csv(here("data/Pf7/sample_ids/Pf7_multi_samples.txt"), sep = "\t")

## Reading in the vcf data
source(here("code/PopGenome/functions/read_Pf7_vcf.R"))
vcf <- read_Pf7_vcf(dir = data_dir, file = filename, chr_tid, Pf7_samples, 1, 2040000)

## Set Populations
source(here("code/PopGenome/functions/set_populations.R"))
vcf <- set_populations(vcf, Pf7_samples, population = Pf7_samples$Country)

# Neutrality stats
vcf.neutrality <- neutrality.stats(vcf, FAST=TRUE)
print(get.neutrality(vcf.neutrality)[[1]])

# Segregating sites on sliding window
source(here("code/PopGenome/functions/calc_TajD_sliding_window.R"))
sliding.S <- calc_S_sliding_window(vcf, 10000, 2500, output_txt)


# Plotting the segregating sites
source(here("code/PopGenome/functions/TajD-plots.R"))
vcf.S.formatted <- format_Popgenome_S(sliding.S)

plot_S_chr11(vcf.S.formatted,output_png)
