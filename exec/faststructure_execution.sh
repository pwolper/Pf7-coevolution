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
#$-N admixture

source ~/.bashrc

source ../code/faststructure/admixture.sh
#conda activate faststructure
#
## Paths
#bed_file=$HOME/FP-coevolution/data/Pf7/bed/Pf3D7_02_v3.afr_samples_2014.qSNP
#output=$HOME/FP-coevolution/output/faststructure/qSNP
#
## faststructure
#structure.py \
#    -k 5 \
#    --prior=logistic \
#    --input=$bed_file \
#    --output=$output/chr2_qsnp_2014_logistic_i
