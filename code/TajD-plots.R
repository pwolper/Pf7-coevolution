library(tidyverse)
library(here)

TajD.chr2 <- read.csv(file = here("output/Pf7_Kenya_2014_Taj.D_pos500000-1000000.txt"), sep = "\t")
str(TajD.chr2)

Pfsa1 <- 631190
Pfsa2 <- 814288

# Plotting Taj-D
TajD.plot <- ggplot(data = subset(TajD.chr2,!is.na(pop.1)), aes(x=position, y = pop.1)) +
  geom_line() +
  geom_vline(xintercept = Pfsa1, colour = 'red') +
  geom_vline(xintercept = Pfsa2, colour = 'blue')

ggsave(TajD.plot, file = here("output/Pf7_Kenya_2014_Taj.D_pos500000-1000000.png"),
       device = "png", dpi = 300)
