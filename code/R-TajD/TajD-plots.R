library(tidyverse)
library(here)

## Reading in data
TajD.chr2 <- read.csv(file = here("output/TajD/data/Pf7.chr2.full.TajD_DRC_Gambia_Kenya.txt"), sep = "\t")
str(TajD.chr2)

## TajD.chr2.Pfsa12-region.Kenya_Gambia <- read.csv(file = here("output/TajD/data/Pf7.chr2.Pfsa12-region_Kenya_Gambia.txt"), sep = "\t")
## str(TajD.chr2.Pfsa12-region.Kenya_Gambia)

## TajD.chr2.Kenya_Gambia <- read.csv(file = here("output/TajD/data/Pf7.chr2_Kenya_Gambia.txt"), sep = "\t")
## str(TajD.chr2.Kenya_Gambia)

## Formatting data for plotting
format_Popgenome_TajD <- function(TajD, populations){
  # TajD: Popgenome array output; populations: vector of population identifiers.
  positions <- TajD$position
  TajD <- subset(TajD, select = -c(position))
  colnames(TajD) <- populations
  TajD_total <- unname(unlist(TajD))
  df <- data.frame(population = rep(populations, each = nrow(TajD)), TajD = TajD_total)
  return(cbind(positions, df))
}

DRC_GM_KE <- format_Popgenome_TajD(TajD.chr2, c("DRC", "Gambia", "Kenya"))
DRC_GM_KE %>% str()

# Kenya_Gambia <- format_Popgenome_TajD(TajD.chr2.Kenya_Gambia, c("Kenya", "Gambia"))

# Loci of interest
Pfsa1 <- 631190/1000000
Pfsa2 <- 814288/1000000

# Plotting Taj-D function

plot_TajD <- function(TajD_formatted, fileName){
  TajD.plot <- ggplot(data = subset(TajD_formatted,!is.na(TajD)), aes(x=positions/1000000, y = TajD)) +
    geom_line(aes(color = population)) +
    geom_vline(xintercept = Pfsa1) +
    geom_text(aes(x=Pfsa1, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
    geom_vline(xintercept = Pfsa2) +
    geom_text(aes(x=Pfsa2, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
    theme_light() +
    labs(title = "Tajima's D calculated in a genomic region of Chr 2 of P. falciparum",
         subtitle = "Sliding window of 10 Kb in length",
         x = "Genomic position in Mb")

  ggsave(TajD.plot, file = here("output/TajD/png/",fileName),
         device = "png", dpi = 300,
         width = 14, height = 7)
}

plot_TajD(DRC_GM_KE, "Pf7.chr2.full.TajD_DRC_Gambia_Kenya.png")
