#!/usr/bin/env sh


cd $HOME/FP-coevolution/data/Pf7/

diff <(awk '{print $1}' sample_ids/Pf7_african_samples.txt | tail -n +2) <(awk '{print $2}' bed/Pf3D7_02_v3.afr_samples.SNP.fam)
