#!/usr/bin/env bash

#$-cwd 
# This option tells gridware to change to the current directory before executing the job
# (default is the home of the user).

#$-pe serial 1
# Specify this option only for multithreaded jobs that use more than one cpu core.
# IMPORTANT! Don't use more than 4 cores to keep free space for other students!

#$-l vf=2g
# This option declares the amount of memory the job will use. Specify this value as accurate as possible.
# IMPORTANT! memory request is multiplied by the number of requested CPU cores specified with the -pe.
# Thus, you should divide the overall memory consumption of your job by the number of parallel threads.

#$-j yes

#$-q all.q
#$-N vcf-snp-stats

source ~/.bashrc

vcf_dir=$HOME/FP-coevolution/data/Pf7/vcf
output=$HOME/FP-coevolution/output

echo STARTED on $(date)

## bcftools
bcftools stats $vcf_dir/Pf3D7_11_v3.SNP.vcf.gz > $output/vcf.stats/Pf3D7_11_v3.SNP.stats

echo FINISHED writing output file on $(date)

echo FINISHED task on$(date)
