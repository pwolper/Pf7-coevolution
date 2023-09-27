
png(here("output/sfs/unfolded/sfs_unfolded_chr2_afr_samples.png"), height = 500, width = 1000)
## plot(names(unfolded_sfs_vcf_repol), unfolded_sfs_vcf_repol, type = "h",
##      xlab = "Unfolded frequency", ylab = "Count",
##      main = "Unfolded site frequency for Pf7 chr2 snps polarized with P. reichenowi")

hist(vcf_repol_filtered$AF, breaks = 300, ylim = c(0,1000), xlab = "Unfolded frequency", ylab = "Count",
     main = "Unfolded site frequency for Pf7 chr2 snps polarized with P. reichenowi",
     sub = paste(nrow(vcf_repol_filtered),"sites from 1846 individuals"))

dev.off()
