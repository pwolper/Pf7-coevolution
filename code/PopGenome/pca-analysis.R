## R script for PCA analysis of the Pf7 populations

library(tidyverse)
if(!require(adegenet)){
    install.packages("adegenet")
    library(adegenet)}
if(!require(here)){
    install.packages("here")
    library(here)}
if(!require(vcfR)){
    install.packages("vcfR")
    library(vcfR)}

## Step 1: Reading vcf file and converting it to a genlight object using vcfR::vcfR2genlight

## Step 2: Plotting PCA using dapc(). How do the populations cluster? By geographic location? Can we see effects of the years?
