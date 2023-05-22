## Subsetting the samples of the Pf7-samples.txt file
##

library("tidyverse")
library(here)
setwd("/data/home/students/p.wolper/FP-coevolution/")
here()

## Pf7_samples <- read.csv(file="data/Pf7/sample_ids/Pf7_samples-full-info.txt", sep = "\t")
## Pf7_samples %>% str()

## names(Pf7_samples);unique(Pf7_samples$Population)

## Pf7 <- subset(Pf7_samples,select = c("Sample", "Country", "Year", "Population", "Sample.type", "Admin.level.1"))
## Pf7 %>% str()

## write.table(Pf7, file="data/Pf7/sample_ids/Pf7_samples.txt", sep = "\t", row.names = FALSE)

Pf7_samples <- read.csv(file="data/Pf7/sample_ids/Pf7_samples.txt", sep = "\t")


# Sort populations to use
unique(Pf7_samples$Admin.level.1[Pf7_samples$Country == "Gambia"])

Pf7_samples_Kenya_2014 <- Pf7_samples$Sample[Pf7_samples$Country == "Kenya" &
                                             Pf7_samples$Year == 2014 &
                                             Pf7_samples$QC.pass == "True" &
                                             Pf7_samples$Admin.level.1 == "Kisumu"]
Pf7_samples_Kenya %>% length()

Pf7_samples_Gambia_UpperRiver <- Pf7_samples$Sample[Pf7_samples$Country == "Gambia" &
                                                    Pf7_samples$QC.pass == "True" &
                                                    Pf7_samples$Admin.level.1 == "Upper River"]
Pf7_samples_Gambia_UpperRiver %>% length()

samples_as_dataframe <- function(samples,Name){
  df <- data.frame(id = samples, Country = rep(Name, times = length(samples)))
  return(df)
}

Kenya <- samples_as_dataframe(Pf7_samples_Kenya,"Kenya")
Gambia <- samples_as_dataframe(Pf7_samples_Gambia_UpperRiver,"Gambia")

Pf7_multi_samples <- rbind(Kenya, Gambia)

write.table(Pf7_multi_samples, file = "data/Pf7/sample_ids/Pf7_multi_samples.txt", sep = "\t", row.names = FALSE, quote=FALSE)
