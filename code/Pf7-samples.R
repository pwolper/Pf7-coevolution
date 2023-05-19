## Subsetting the samples of the Pf7-samples.txt file
##

library("tidyverse")
setwd("/data/home/students/p.wolper/FP-coevolution/")


Pf7_samples <- read.csv(file="data/Pf7/Pf7_samples_full-info.txt", sep = "\t")
Pf7_samples %>% str()

names(Pf7_samples);unique(Pf7_samples$Population)

Pf7 <- subset(Pf7_samples,select = c("Sample", "Country", "Year", "Population", "Sample.type"))
Pf7 %>% str()

write.table(Pf7, file="data/Pf7/Pf7_samples.txt", sep = "\t", row.names = FALSE)
