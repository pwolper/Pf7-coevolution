## Script to calculate the overlapping snps between the outgroup and the vcf file.
library(dplyr); library(here)

ref <- read.csv(here("data/mummer_aln/chr2/Pf7_PrCDC_SNPs_formatted.txt"),sep = "\t",header = FALSE, skip = 1)[,c(1:4)]
colnames(ref) <- c("pos","N_Pf7","N_PrCDC","pos_PrCDC")
str(ref)

vcf <- read.table(here("data/Pf7/vcf/Pf7.02.vcf.qSNP.AF_AC_AN.txt"))
colnames(vcf) <- c("pos", "REF", "ALT","AF","AC","AN")
vcf$AC <- vcf$AC/2
vcf$AN <- vcf$AN/2
str(vcf)

## Common snps between REF-OUT align and vcf samples
snps_intersect <- intersect(ref$pos, vcf$pos)
str(snps_intersect)

vcf_common <- vcf[vcf$pos %in% snps_intersect,]
str(vcf_common)

ref_common <- ref[ref$pos %in% snps_intersect,]
ref_common[ref_common$pos %in% ref_common$pos[duplicated(ref_common$pos)],] ## check for duplicated but identical snps_intersect
ref_common <- ref_common %>% distinct(across(-pos_PrCDC)) ## remove duplicated rows with identical snps and Pr7 positions
str(ref_common)

identical(vcf_common$REF, ref_common$N_Pf7) ## REF and N_Pf7 are identical for the overlapping snps.

common_snps <- data.frame(pos = vcf_common$pos, REF = vcf_common$REF,
                   OUT = ref_common$N_PrCDC, ALT = vcf_common$ALT)
nrow(common_snps)

snps_to_repolarize <- common_snps[common_snps$ALT == common_snps$OUT, ]
str(snps_to_repolarize)

vcf_repol <- vcf[, c("pos", "REF", "ALT", "AC", "AN")]

for(i in 1:nrow(vcf_repol)){
  if(vcf_repol$pos[i] %in% snps_to_repolarize$pos) {
    # setting ALT to ANC if ALT is also OUT nuc
    vcf_repol$ANC[i] <- vcf_repol$ALT[i]
    vcf_repol$DRV[i] <- vcf_repol$REF[i]
    # recalculating the AC, AC and AF
    vcf_repol$AC[i] <- vcf_repol$AN[i] - vcf_repol$AC[i]
  } else {
    vcf_repol$ANC[i] <- vcf_repol$REF[i]
    vcf_repol$DRV[i] <- vcf_repol$ALT[i]
  }
}
str(vcf_repol)

# removing positions with either none or all ALT alleles.
vcf_repol_filtered <- vcf_repol %>%
  select(-c("REF", "ALT")) %>%
  filter(AC != 0, AN != AC)
str(vcf_repol_filtered)

# extrapolating site frequencies from allele frequencies.
vcf_repol_filtered$AF <- vcf_repol_filtered$AC/vcf_repol_filtered$AN
vcf_repol_filtered$SF <- vcf_repol_filtered$AF*1846
vcf_repol_filtered$SF <- round(vcf_repol_filtered$SF, 0)
str(vcf_repol_filtered)


write.csv(vcf_repol_filtered, here("output/sfs/unfolded/Pf7.chr11.snps.polarized.txt"), row.names = FALSE)
