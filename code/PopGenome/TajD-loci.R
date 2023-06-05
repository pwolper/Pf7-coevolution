## Calculating Tajima's D for Pf7 geomic regions using PopGenome
library(PopGenome)
library(tidyverse)

if(!require(here)){
    install.packages("here")
    library(here)}

## Set variables here.
filename <- "Pf3D7_02_v3.SNP.vcf.gz"
data_dir <- "chr2" #vcf subfolder contaning the vcf data
chr_tid <- "Pf3D7_02_v3"

## Sliding window with 1 Kb windows
width = 1000; jump = 250

## Loci of interest in Megabases
Pfsa1 <- 631190
Pfsa2 <- 814288
Pfsa3 <- 1058035

## Output files
output_filename <- "Pf7.chr2.Pfsa1.DRC_GM_KE_MM"

output_txt <- paste0(output_filename,".txt")
output_png <- paste0(output_filename,".png")


#### Start of script
## Important: Uncomment the relative plotting functiong (chr2, chr11 or region)

## Reading in the Sample data
Pf7_samples <- read.csv(here("data/Pf7/sample_ids/Pf7_multi_samples.txt"), sep = "\t")
str(Pf7_samples); unique(Pf7_samples$Country); unique(Pf7_samples$year)

## read vcf file
source(here("code/PopGenome/functions/read_Pf7_vcf.R"))
vcf <- read_Pf7_vcf(data_dir,filename,"Pf3D7_02_v3",start=625000,end=635000)

## Set Populations
source(here("code/PopGenome/functions/set_populations.R"))
vcf <- set_populations(vcf, Pf7_samples, population = Pf7_samples$Country)

# Neutrality stats
vcf.neutrality <- neutrality.stats(vcf, FAST=TRUE)
print(get.neutrality(vcf.neutrality)[[1]])

## Tajima's D from sliding window
source(here("code/PopGenome/functions/calc_TajD_sliding_window.R"))
vcf.TajD <- calc_TajD_sliding_window(vcf, width, jump, output_txt)

## Plotting Taj'D across chromosomal regions.
source(here("code/PopGenome/functions/plotting.R"))
vcf.TajD.formatted <- format_Popgenome_TajD(vcf.TajD)

## plot_TajD_chr2(vcf.TajD.formatted, output_png)
## plot_TajD_chr11(vcf.TajD.formatted, ouput_png)
