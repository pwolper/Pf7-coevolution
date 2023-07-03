#!/bin/bash

# Input file names
vcf_file=$HOME/FP-coevolution/data/Pf7/vcf/chr2/Pf3D7_02_v3.afr_samples.SNP.vcf.gz
reference_file=$HOME/FP-coevolution/data/Pf7/seqs/Pf3D7_02_v3.fasta
consensus_output=$HOME/FP-coevolution/data/Pf7/consensus_sequences

# Create a directory to store the output consensus sequences
mkdir -p $consensus_output 
cd $consensus_output

# Reference header
ref_header=$(awk '/>/ {print; exit}' "$reference_file")

# Get a list of sample names from the VCF file
sample_names=$(bcftools query -l "$vcf_file")

# Iterate over each sample
for sample in $sample_names; do
  # output file name
  output_file="$consensus_output/${sample}_consensus.fasta"

  # Reference and sample in fasta header
  combined_header="${ref_header} Sample: ${sample}"
  echo "$combined_header" > "$output_file"

  # Generate the consensus sequence for the current sample
  bcftools consensus -f "$reference_file" -s "$sample" "$vcf_file" | tail -n +2 >> "$output_file"

  echo "$sample consensus generated!"
done




