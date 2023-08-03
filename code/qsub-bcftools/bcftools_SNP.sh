#!/usr/bin/env bash

vcf_dir=$HOME/FP-coevolution/data/Pf7/vcf/chr2
samples_dir=$HOME/FP-coevolution/data/Pf7/sample_ids
output=$HOME/FP-coevolution/output/vcf.stats

echo STARTED on $(date)

## bcftools
bcftools view \
    --include 'FILTER="PASS" && N_ALT=1 && TYPE="snp" && VQSLOD> 5.0'\
    --samples-file $samples_dir/Pf7_african_samples_2014_ids.txt \
    --output-type z\
    --output-file  $vcf_dir/Pf3D7_02_v3.afr_samples_2014.qSNP.vcf.gz \
    $vcf_dir/Pf3D7_02_v3.afr_samples.qSNP.vcf.gz

echo FINISHED writing output file on $(date)

bcftools index -t $vcf_dir/Pf3D7_02_v3.afr_samples_2014.qSNP.vcf.gz

echo FINISHED indexing on $(date)
echo FINISHED task on$(date)
