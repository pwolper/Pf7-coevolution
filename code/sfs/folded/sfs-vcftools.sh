#!/usr/bin/env sh

vcftools --gzvcf ../data/Pf7/vcf/chr11/Pf3D7_11_v3.afr_samples.SNP.vcf.gz \
	--freq --out afr_freq_chr11

awk '{print $NF}' afr_freq_chr11.frq > afr_freq_min_chr11.txt
