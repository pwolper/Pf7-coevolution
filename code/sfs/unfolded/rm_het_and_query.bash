#!/usr/bin/env bash

#removing heterozygous genotypes of quality filtered vcf file

bcftools filter -S . -e 'GT=="het"'
