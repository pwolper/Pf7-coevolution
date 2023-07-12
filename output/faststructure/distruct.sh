#!/usr/bin/env sh

# script works in conda environment with faststructure installed.
# Arguments are to be given in the order: K, name of input model, name of output file.

# Paths
input=$HOME/FP-coevolution/output/faststructure
output=$HOME/FP-coevolution/output/faststructure/distruct

distruct.py -K 2 --input=$input/chr2_simple --output=$output/chr2_simple_K2
