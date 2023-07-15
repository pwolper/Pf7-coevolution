#!/usr/bin/env sh

# script works in conda environment with faststructure installed.
# Arguments are to be given in the order: K, name of input model, name of output file.

# Paths
input=$HOME/FP-coevolution/output/faststructure
output=$HOME/FP-coevolution/output/faststructure/distruct

distruct.py -K 3 --input=$input/chr2_simple_full --output=$output/chr2_simple_full_K3
