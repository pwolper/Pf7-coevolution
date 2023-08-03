## Subsetting the samples of the Pf7-samples.txt file

library(dplyr)
library(ggplot2)
library(here)
# setwd("/data/home/students/p.wolper/FP-coevolution/")
setwd(here())

Pf7_samples <- read.csv(file="data/Pf7/sample_ids/Pf7_samples-full-info.txt", sep = "\t")
Pf7_samples %>% str()

names(Pf7_samples);unique(Pf7_samples$Population)

Pf7 <- subset(Pf7_samples,select = c("Sample", "Country", "Year", "Population", "Sample.type", "Admin.level.1", "QC.pass"))

## write.table(Pf7, file="data/Pf7/sample_ids/Pf7_samples.txt", sep = "\t", row.names = FALSE)

Pf7_samples <- read.csv(file="data/Pf7/sample_ids/Pf7_samples.txt", sep = "\t")
Pf7_samples %>% str()


# Sort populations to use
unique(Pf7_samples$Admin.level.1[Pf7_samples$Country == "Gambia"])
unique(Pf7_samples$Admin.level.1[Pf7_samples$Country == "Kenya"])
unique(Pf7_samples$Admin.level.1[Pf7_samples$Country == "Democratic Republic of the Congo"])
unique(Pf7_samples$Admin.level.1[Pf7_samples$Country == "Tanzania"])


Pf7_samples_Kenya <- Pf7_samples[Pf7_samples$Country == "Kenya" &
                                 Pf7_samples$Year %in% c(2010,2011,2012,2013,2014) &
                                 Pf7_samples$QC.pass == "True" ,]
Pf7_samples_Kenya %>% str()
Pf7_samples_Kenya %>% summary()


Pf7_samples_Gambia <- Pf7_samples[Pf7_samples$Country == "Gambia" &
                                             Pf7_samples$QC.pass == "True" &
                                             Pf7_samples$Admin.level.1 == "Upper River",]
Pf7_samples_Gambia %>% str()
Pf7_samples_Gambia %>% summary()

Pf7_samples_DRC <- Pf7_samples[Pf7_samples$Country == "Democratic Republic of the Congo" &
                               Pf7_samples$QC.pass == "True",]
Pf7_samples_DRC %>% str()
Pf7_samples_DRC %>% summary()

Pf7_samples_Myanmar <- Pf7_samples[Pf7_samples$Country == "Myanmar" &
                                   Pf7_samples$QC.pass == "True" &
                                   Pf7_samples$Admin.level.1 == "Kayin",]
Pf7_samples_Myanmar %>% str()
Pf7_samples_Myanmar %>% summary()

Pf7_samples_Tanzania <- Pf7_samples[Pf7_samples$Country == "Tanzania" &
                                             Pf7_samples$QC.pass == "True",]
Pf7_samples_Tanzania %>% str()
Pf7_samples_Tanzania %>% summary()


samples_as_dataframe <- function(samples,Name){
  df <- data.frame(id = samples$Sample,
                   Country = rep(Name, times = nrow(samples)),
                   year = samples$Year,
                   location = samples$Admin.level.1)
  return(df)}

Kenya <- samples_as_dataframe(Pf7_samples_Kenya,"Kenya")
Gambia <- samples_as_dataframe(Pf7_samples_Gambia,"Gambia")
DRC <- samples_as_dataframe(Pf7_samples_DRC, "DRC")
Myanmar <- samples_as_dataframe(Pf7_samples_Myanmar, "Myanmar")
Tanzania <- samples_as_dataframe(Pf7_samples_Tanzania, "Tanzania")

Pf7_multi_samples <- rbind(Kenya, Gambia, DRC, Myanmar, Tanzania)
Pf7_multi_samples %>% str()
Pf7_multi_samples %>% summary()


Pf7_african_samples <- rbind(Kenya, Gambia, DRC, Tanzania)
Pf7_african_samples %>% str()
Pf7_african_samples %>% summary()

write.table(Pf7_african_samples$id, file = "data/Pf7/sample_ids/Pf7_african_samples_ids.txt", sep = "\t", row.names = FALSE, quote=FALSE, col.names = FALSE)

write.table(Pf7_multi_samples, file = "data/Pf7/sample_ids/Pf7_multi_samples.txt", sep = "\t", row.names = FALSE, quote=FALSE)

write.table(Pf7_african_samples, file = "data/Pf7/sample_ids/Pf7_african_samples.txt", sep = "\t", row.names = FALSE, quote=FALSE)
