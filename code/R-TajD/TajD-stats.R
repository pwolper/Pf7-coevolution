## Calculating Tajima's D for Pf7 geomic regions using PopGenome
library(PopGenome)
library(tidyverse)

if(!require(here)){
    install.packages("here")
    library(here)
}


## Reading in the Sample data
Pf7_populations <- read.csv(here("data/Pf7/sample_ids/Pf7_multi_samples.txt"), sep = "\t")
str(Pf7_populations)

populations <- split(Pf7_populations$id, Pf7_populations$Country)
str(populations)


# Reading in the vcf data
Pf7.chr2.vcf <- readVCF(here("data/Pf7/vcf/chr2/Pf3D7_02_v3.SNP.vcf.gz"),
                        numcols = 10000, samplenames=Pf7_populations$id,
                        tid='Pf3D7_02_v3',
                        frompos=1,topos=1000000,
                        include.unknown = TRUE,
                        gffpath=here("data/Pf7/gff/Pfalciparum_replace_Pf3D7_MIT_v3_with_Pf_M76611.gff"))

get.sum.data(Pf7.chr2.vcf)

# Set Populations
Pf7.chr2.vcf <- set.populations(Pf7.chr2.vcf, populations, diploid = FALSE)
Pf7.chr2.vcf@populations

# Neutrality stats
Pf7.chr2.vcf.neutrality <- neutrality.stats(Pf7.chr2.vcf, FAST=TRUE)

get.neutrality(Pf7.chr2.vcf.neutrality)[[1]]

# Sliding window with 10 Kb windows
slide.Pf7.chr2.vcf <- sliding.window.transform(Pf7.chr2.vcf,10000,2500, type=2)
slide.Pf7.chr2.vcf <- neutrality.stats(slide.Pf7.chr2.vcf)

slide.Pf7.chr2.vcf@region.names

print("Calculating Tajima's D...")
slide.Pf7.chr2.vcf@Tajima.D


TajD <- slide.Pf7.chr2.vcf@Tajima.D
colnames(TajD) <- names(populations)

pos <- seq(from=500000, to=1000000, by=2500) + 5000

## genome.pos <- sapply(slide.Pf7.chr2.vcf@region.names, function(x){
##   split <- strsplit(x," ")[[1]][[c(1,3)]]
##   val <- mean(as.numeric(split))
##   return(val)
## })

## TajD.chr2 <- cbind(TajD, genome.pos)
TajD.chr2 <- data.frame(TajD = TajD, position = head(pos,-4))

write.table(TajD.chr2, file = here("output/TajD/data/Pf7.chr2.full.TajD_DRC_Gambia_Kenya.txt"), sep = "\t", row.names = FALSE )
