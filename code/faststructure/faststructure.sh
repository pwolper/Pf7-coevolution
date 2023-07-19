#!/usr/bin/env sh

conda activate faststructure

# Paths
bed_file=$HOME/FP-coevolution/data/Pf7/bed/Pf3D7_02_v3.afr_samples.SNP
output=$HOME/FP-coevolution/output/faststructure

# fastSTRUCTURE
structure.py \
    -K 2 \
    --prior=logistic
    --input=$bed_file \
    --output=$output/chr2_logistic_I

# distruct.py \
#     -K 3 \
#     --input=$output/chr2_simple \
#     --output=$output/chr2_simple.svg
