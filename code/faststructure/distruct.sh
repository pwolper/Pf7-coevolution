#!/usr/bin/env sh

# script works in conda environment with faststructure installed.
# Arguments are to be given in the order: K, name of input model, name of output file.

# Paths
input=$HOME/FP-coevolution/output/faststructure
output=$HOME/FP-coevolution/output/faststructure/distruct

distruct.py -K 5 --input=$input/chr2_simple_II --output=$output/chr2_simple_II_K5
