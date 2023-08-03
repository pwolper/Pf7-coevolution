## Script to calculate the overlapping snps between the outgroup and the vcf file.

library(dplyr); library(here)

ref <- read.csv(here("data/mummer_aln/Pf7_PrCDC_snps_filtered.txt"),sep = "\t",header = FALSE, skip = 1)[,c(1:4)]
colnames(ref) <- c("pos","N_Pf7","N_PrCDC","pos_PrCDC")
str(ref)

vcf <- read.table(here("data/Pf7/vcf/Pf7.vcf.chr2.afr.qSNP.positions.txt"))
colnames(vcf) <- "pos"
str(vcf)

common_snps <- intersect(ref$pos, vcf$pos)
str(common_snps)
