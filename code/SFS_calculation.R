library(data.table)

Load the data from the text file
allele_frequencies <- fread("~/Downloads/text_SFS.txt")

# Calculate the folded SFS
folded_sfs <- pmin(allele_frequencies, 1 - allele_frequencies)

# Count the occurrences of each folded frequency
folded_sfs_counts <- table(folded_sfs)

# Plot the folded SFS
plot(names(folded_sfs_counts), folded_sfs_counts, type = "h",
     xlab = "Folded Frequency", ylab = "Count",
     main = "Folded Site Frequency Spectrum")
