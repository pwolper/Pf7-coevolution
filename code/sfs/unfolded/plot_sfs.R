library(here); library(ggplot2); library(dplyr)

vcf_repol <- read.csv(here("output/sfs/unfolded/Pf7.chr2.snps.polarized.txt"))
vcf_repol$SF <- vcf_repol$AF*1846

round(vcf_repol$SF,0) %>% max()

str(vcf_repol)



png(here("output/sfs/unfolded/sfs_unfolded_chr2_afr_samples.png"), height = 500, width = 1000)
## plot(names(unfolded_sfs_vcf_repol), unfolded_sfs_vcf_repol, type = "h",
##      xlab = "Unfolded frequency", ylab = "Count",
##      main = "Unfolded site frequency for Pf7 chr2 snps polarized with P. reichenowi")

hist(vcf_repol$SF, breaks = 1846, xlim = c(0,50), xlab = "Unfolded frequency", ylab = "Count",
     main = "Unfolded site frequency for Pf7 chr2 snps polarized with P. reichenowi",
     sub = paste(nrow(vcf_repol),"sites from 1846 individuals"))

dev.off()
