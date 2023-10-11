#### R script for plotting the population genetic stats from stats-pipline.R
#### 12.06.23 - Philip L. Wolper

library(tidyverse)
library(here)

source(here("code/PopGenome/functions/plots.R"))

file <- "Pf7.chr2.stats.10kb.GT_filtered"
file_txt <- paste0(file,".txt")
file_png <- paste0(file,".png")

## Pfsa1 <- 631190
## Pfsa2 <- 814288
## Pfsa3 <- 1058035

## Reading in data
stats <- read.csv(here("output/stats",file_txt), sep = "\t")
colnames(stats) <- c("S", "theta_W", "theta_pi", "TajD", "positions")
str(stats)

recomb <- read.csv(here("output/recomb/recomb_chr2_windows.txt"))
stats$recomb <- recomb$Hudson.Kaplan.RM
str(recomb)

str(stats)

TajD.plot <- ggplot(data = subset(stats,!is.na(TajD)), aes(x=positions/1000000, y = TajD)) +
    ## geom_line(colour = "red") +
    geom_line() +
    theme_light() +
    labs(y = "Tajima's D",
         x = "Genomic position in Mb")

S.plot <- ggplot(data = subset(stats,!is.na(S)), aes(x=positions/1000000, y = S)) +
    ## geom_line(colour = "green") +
    geom_line() +
    theme_light() +
    labs(y = "Segregating sites S",
         x = "Genomic position in Mb")

thetaW.plot <- ggplot(data = subset(stats, !is.na(theta_W)), aes(x = positions/1000000, y = theta_W)) +
  ## geom_line(colour = "blue") +
  geom_line() +
  #geom_line(aes(color = population)) +
  #geom_vline(xintercept = Pfsa1/1000000) +
  #geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
  #geom_vline(xintercept = Pfsa2/1000000) +
  #geom_text(aes(x=Pfsa2/1000000, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
  theme_light() +
  labs(y = "theta_W",
       x = "Genomic position in Mb")

thetaPi.plot <- ggplot(data = subset(stats, !is.na(theta_pi)), aes(x = positions/1000000, y = theta_pi)) +
  ## geom_line(colour = "orange") +
  geom_line() +
  ## geom_line(aes(color = population)) +
  ## geom_vline(xintercept = Pfsa1/1000000) +
  ## geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
  ## geom_vline(xintercept = Pfsa2/1000000) +
  ## geom_text(aes(x=Pfsa2/1000000, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
  theme_light() +
  labs(y = "theta_pi",
       x = "Genomic position in Mb")

stats_plot <- ggpubr::ggarrange(TajD.plot, S.plot, thetaW.plot, thetaPi.plot, nrow = 2, ncol = 2, common.legend = TRUE,
                  labels = c("A","B","C","D"))

png(here("output/stats",file_png), width = 1000, height = 500)
stats_plot
dev.off()

#ggsave(here("output/stats",file_png),device = "png", dpi = 300, height = 10, width = 15, bg = "white")

recomb.theta.window <- ggplot(data = subset(stats, !is.na(theta_W)), aes(x = recomb, y = theta_W)) +
    geom_point() +
    geom_smooth() +
    theme_light() +
    labs(x = "Hudson-Kaplan RM")


png(filename = here("output/recomb/theta_W_recomb_chr2.png"), width = 1080, height = 400)
recomb.theta.window
dev.off()

# ggsave(here("output/stats/theta_W_recomb_chr2.png"), device = "png", dpi = 300, height = 5, width = 20, bg = "white")
