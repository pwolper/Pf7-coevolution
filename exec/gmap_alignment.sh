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

#$-q bigmem@node09
#$-N gmap-t-alignment

data=$HOME/FP-coevolution/data

source ~/.bashrc

gmap -g $data/P.reichenowi/embl.PrCDC/PrCDC_02_v3.fasta -A --nosplicing -t 8 -f sampe $data/Pf7/seqs/Pf3D7_02_v3.fasta
