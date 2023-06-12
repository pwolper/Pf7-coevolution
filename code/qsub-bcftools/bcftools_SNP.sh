#!/usr/bin/env bash

vcf_dir=$HOME/FP-coevolution/data/Pf7/vcf/chr2
samples_dir=$HOME/FP-coevolution/data/Pf7/sample_ids
output=$HOME/FP-coevolution/output/vcf.stats

echo STARTED on $(date)

## bcftools
bcftools view \
    --include 'FILTER="PASS" && N_ALT=1 && TYPE="snp"'\
    --samples-file $samples_dir/Pf7_african_samples_ids.txt \
    --output-type z\
    --output-file  $vcf_dir/Pf3D7_02_v3.afr_samples.SNP.vcf.gz \
    $vcf_dir/Pf3D7_02_v3.pf7.vcf.gz

echo FINISHED writing output file on $(date)

bcftools index -t $vcf_dir/Pf3D7_02_v3.afr_samples.SNP.vcf.gz

echo FINISHED indexing on $(date)
echo FINISHED task on$(date)
