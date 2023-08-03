#!/usr/bin/env sh
#read -p "File to save overlapping snps under: " output_file
output_file=Pf7.PrCDC.overlap.snp.txt

ref=$HOME/FP-coevolution/data/mummer_aln/Pf7_PrCDC_snps_filtered_positions.txt
vcf=$HOME/FP-coevolution/data/Pf7/vcf/Pf7.vcf.chr2.afr.qSNP.positions.txt

overlap=$(comm -12 $ref $vcf)

echo $overlap > $output_file

echo "Number of overlapping values: " $(echo $overlap | wc -l)
