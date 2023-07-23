#!/usr/bin/env sh

# script works in conda environment with faststructure installed.
# Arguments are to be given in the order: K, name of input model, name of output file.

# Paths
input=$HOME/FP-coevolution/output/faststructure
output=$HOME/FP-coevolution/output/faststructure/distruct
sample_info=$HOME/FP-coevolution/data/Pf7/sample_ids/Pf7_african_samples.txt
popfile_countries=$HOME/FP-coevolution/data/Pf7/sample_ids/Pf7_african_samples_countries.txt
popfile_locations=$HOME/FP-coevolution/data/Pf7/sample_ids/Pf7_african_samples_locations.txt

distruct.py -K 2 \
    --input=$input/chr2_logistic_I --output=$output/chr2_logistic_I_K2
    #--popfile=$popfile_countries \
