## Calculating Tajima's D for Pf7 geomic regions using PopGenome
library(PopGenome)
library(tidyverse)

if(!require(here)){
    install.packages("here")
    library(here)
}

## Set variables here.
filename <- "Pf3D7_11_v3.SNP.vcf.gz"
data_dir <- "chr11" #vcf subfolder contaning the vcf data
output_filename <- "Pf7.chr2.DRC_GM_KE"

## Reading in the Sample data
Pf7_samples <- read.csv(here("data/Pf7/sample_ids/Pf7_multi_samples.txt"), sep = "\t")
str(Pf7_samples); unique(Pf7_samples$Country); unique(Pf7_samples$year)

## read vcf file
source(here("code/read_Pf7_vcf.R"))
vcf <- read_Pf7_vcf(data_dir,filename,start=1,end=2040000)

## Set Populations
source(here("code/set_populations.R"))
vcf <- set_populations(Pf7.vcf, Pf7_samples, population = Pf7_samples$Country)

# Neutrality stats
vcf.neutrality <- neutrality.stats(Pf7.vcf, FAST=TRUE)
get.neutrality(vcf.neutrality)[[1]]

# Sliding window with 10 Kb windows
sliding.vcf <- sliding.window.transform(Pf7.vcf,10000,2500, type=2)
sliding.vcf <- neutrality.stats(slide.vcf)

slide.vcf@region.names

print("Calculating Tajima's D...")
slide.vcf@Tajima.D

TajD <- slide.vcf@Tajima.D
colnames(TajD) <- names(populations)


# Extracting genomic positions
pos <- unname(sapply(slide.vcf@region.names, function(x){
  split <- strsplit(x," ")[[1]]
  vals <- as.numeric(split[c(1,3)])
  val <- mean(vals, na.rm = TRUE)
  return(val)
}))

vcf.TajD <- data.frame(TajD = TajD, position = pos)

write.table(vcf.TajD,
            file = here("output/TajD/data",str(output_filename,".txt")),
            sep = "\t", row.names = FALSE )
