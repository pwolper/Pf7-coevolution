#!/usr/bin/env sh

cd ~/FP-coevolution/output/faststructure/admixture

# Paths
bed_file=$HOME/FP-coevolution/data/Pf7/bed/Pf3D7_11_v3.afr_samples.qSNP.GT_filtered.renamed.bed
output=$HOME/FP-coevolution/output/faststructure/admixture/chr11

for K in {2..10}; do
    admixture $bed_file $K --cv | tee log{$K}.out; done
