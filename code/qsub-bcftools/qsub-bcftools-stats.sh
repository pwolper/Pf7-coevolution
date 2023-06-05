#!/usr/bin/env bash

vcf_dir=$HOME/FP-coevolution/data/Pf7/vcf
output=$HOME/FP-coevolution/output

echo STARTED on $(date)

## bcftools
bcftools stats $vcf_dir/Pf3D7_11_v3.SNP.vcf.gz > $output/vcf.stats/Pf3D7_11_v3.SNP.stats

echo FINISHED writing output file on $(date)

echo FINISHED task on$(date)
