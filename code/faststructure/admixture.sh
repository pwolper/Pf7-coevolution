#!/usr/bin/env sh

cd ~/FP-coevolution/output/faststructure/admixture

# Paths
bed_file=$HOME/FP-coevolution/data/Pf7/bed/Pf3D7_02_v3.afr_samples_2014.renamed.qSNP.bed
output=$HOME/FP-coevolution/output/faststructure/admixture

for K in {2..6}; do
    admixture $bed_file $K --cv | tee log{$K}.out; done
