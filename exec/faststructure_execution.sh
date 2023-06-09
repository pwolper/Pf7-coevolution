#!/usr/bin/env bash

#$-cwd 
# This option tells gridware to change to the current directory before executing the job
# (default is the home of the user).

#$-pe serial 8
# Specify this option only for multithreaded jobs that use more than one cpu core.
# IMPORTANT! Don't use more than 4 cores to keep free space for other students!

#$-l vf=4g
# This option declares the amount of memory the job will use. Specify this value as accurate as possible.
# IMPORTANT! memory request is multiplied by the number of requested CPU cores specified with the -pe.
# Thus, you should divide the overall memory consumption of your job by the number of parallel threads.

#$-j yes

#$-q bigmem
#$-N fastSTRUCTURE

source ~/.bashrc

conda activate faststructure

# Paths
bed_file=$HOME/FP-coevolution/data/Pf7/bed/Pf3D7_02_v3.afr_samples.SNP
output=$HOME/FP-coevolution/output/faststructure

# fastSTRUCTURE
structure.py \
    -K 3 \
    --full \
    --input=$bed_file \
    --output=$output/chr2_simple_full

# distruct.py \
#     -K 3 \
#     --input=$output/chr2_simple#     --output=$output/chr2_simple.svg
