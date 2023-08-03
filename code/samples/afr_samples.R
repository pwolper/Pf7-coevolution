## Script to visualize the sampling distribution of the chosen african plasmodium samples
library(dplyr)
library(ggplot2)
library(here)

afr_samples <- read.csv(file="data/Pf7/sample_ids/Pf7_african_samples.txt", sep = "\t")
afr_samples$year <- afr_samples$year %>% as.factor()
afr_samples %>% str()

p <- ggplot(data = afr_samples) +
  geom_bar(aes(x = year, fill = Country), stat = "count")

png(here("data/Pf7/sample_ids/plots/afr_samples_years.png"))
print(p)
dev.off()
