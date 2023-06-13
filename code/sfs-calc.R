library(data.table)
library(here)
library(tidyverse)

# Load the data from the text file
allele_frequencies <- read.csv(here("output/sfs/afr_freq_min.txt"))
allele_frequencies <- allele_frequencies[,1] %>% unname()
allele_frequencies %>% str()

# Extract frequecies
f <- allele_frequencies %>% strsplit(.,":") %>% sapply(function(x) {x[2]}) %>% as.numeric()
str(f)

# Remove monomorphic sites, f = 0
f_snp <- f %>% subset(., . !=0)

# Distribution of sites
plot(f_snp)


# Calculate the folded SFS
folded_sfs <- pmin(f_snp, 1 - f_snp)

# Count the occurrences of each folded frequency
folded_sfs_counts <- table(folded_sfs)

# Plot the folded SFS
png(here("output/sfs/","Pf2.chr2.folded_sfs.png"),  height = 300, width = 600)
plot(names(folded_sfs_counts), folded_sfs_counts, type = "h",
            xlab = "Folded Frequency", ylab = "Count",
            main = "Folded Site Frequency Spectrum for Pf7 chr2")
dev.off()
