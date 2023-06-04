#!/usr/bin/env bash

vcf_dir=$HOME/FP-coevolution/data/Pf7/vcf
output=$HOME/FP-coevolution/output

bcftools index -t $vcf_dir/chr11/Pf3D7_11_v3.SNP.vcf.gz
