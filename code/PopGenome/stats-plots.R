#### R script for plotting the population genetic stats from stats-pipline.R
#### 12.06.23 - Philip L. Wolper

library(tidyverse)
library(here)

source(here("code/PopGenome/functions/plots.R"))

file <- "Pf7.chr2.stats.DRC_GM_KE_MM"
file_txt <- paste0(file,".txt")
file_png <- paste0(file,".png")

Pfsa1 <- 631190
Pfsa2 <- 814288
Pfsa3 <- 1058035

## Reading in data
stats <- read.csv(here("output",file_txt), sep = "\t")
str(stats)

plot_1 <- plot_TajD_chr2(stats)
plot_2 <- plot_S_chr2(stats)

plot_3 <- ggplot(data = subset(stats, !is.na(theta_W)), aes(x = positions/1000000, y = theta_W)) +
  geom_line(aes(color = population)) +
  geom_vline(xintercept = Pfsa1/1000000) +
  geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
  geom_vline(xintercept = Pfsa2/1000000) +
  geom_text(aes(x=Pfsa2/1000000, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
  theme_light() +
  labs(y = "theta_W",
       x = "Genomic position in Mb")

plot_4 <- ggplot(data = subset(stats, !is.na(theta_pi)), aes(x = positions/1000000, y = theta_pi)) +
  geom_line(aes(color = population)) +
  geom_vline(xintercept = Pfsa1/1000000) +
  geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
  geom_vline(xintercept = Pfsa2/1000000) +
  geom_text(aes(x=Pfsa2/1000000, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
  theme_light() +
  labs(y = "theta_pi",
       x = "Genomic position in Mb")

stats_plot <- ggpubr::ggarrange(plot_1, plot_2, plot_3, plot_4, nrow = 2, ncol = 2, common.legend = TRUE,
                  labels = c("A","B","C","D"))

ggsave(here("output/",file_png),device = "png", dpi = 300, height = 10, width = 15, bg = "white")
