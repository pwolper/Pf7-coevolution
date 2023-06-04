## Calculating Tajima's D for Pf7 geomic regions using PopGenome
library(PopGenome)
library(tidyverse)

if(!require(here)){
    install.packages("here")
    library(here)
}

## Set variables here.
filename <- "Pf3D7_02_v3.SNP.vcf.gz"
data_dir <- "chr2" #vcf subfolder contaning the vcf data
output_filename <- "Pf7.chr2.DRC_GM_KE_MM.txt"

## Reading in the Sample data
Pf7_samples <- read.csv(here("data/Pf7/sample_ids/Pf7_multi_samples.txt"), sep = "\t")
str(Pf7_samples); unique(Pf7_samples$Country); unique(Pf7_samples$year)

## read vcf file
source(here("code/read_Pf7_vcf.R"))
vcf <- read_Pf7_vcf(data_dir,filename,"Pf3D7_02_v3",start=1,end=1000000)

## Set Populations
source(here("code/set_populations.R"))
vcf <- set_populations(vcf, Pf7_samples, population = Pf7_samples$Country)

# Neutrality stats
vcf.neutrality <- neutrality.stats(vcf, FAST=TRUE)
print(get.neutrality(vcf.neutrality)[[1]])

# Sliding window with 10 Kb windows
sliding.vcf <- sliding.window.transform(vcf,10000,2500, type=2)
sliding.vcf <- neutrality.stats(sliding.vcf)

# print(sliding.vcf@region.names)

print("Calculating Tajima's D...")
print(sliding.vcf@Tajima.D)
TajD <- sliding.vcf@Tajima.D

colnames(TajD) <- names(vcf@populations)

# Extracting genomic positions
pos <- unname(sapply(sliding.vcf@region.names, function(x){
  split <- strsplit(x," ")[[1]]
  vals <- as.numeric(split[c(1,3)])
  val <- mean(vals, na.rm = TRUE)
  return(val)
}))

vcf.TajD <- data.frame(TajD = TajD, position = pos)

write.table(vcf.TajD,
            file = here("output/TajD/data",output_filename),
            sep = "\t", row.names = FALSE )
