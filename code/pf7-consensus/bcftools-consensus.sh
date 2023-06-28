#!/bin/bash

# Input file names
vcf_file="multisample.vcf"
reference_file="reference.fasta"

# Create a directory to store the output consensus sequences
mkdir -p consensus_sequences

# Get a list of sample names from the VCF file
sample_names=$(bcftools query -l "$vcf_file")

# Iterate over each sample
for sample in $sample_names; do
  # Generate the consensus sequence for the current sample
  bcftools consensus -f "$reference_file" -s "$sample" "$vcf_file" > "consensus_sequences/${sample}_consensus.fasta"
done




