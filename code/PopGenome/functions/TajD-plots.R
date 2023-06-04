library(tidyverse)
library(here)

## TajD.data <- "Pf7.chr2.DRC_GM_KE_MM.txt"

## ## Reading in data
## TajD <- read.csv(file = here("output/TajD/data/",TajD.data),
##                  sep = "\t")
## str(TajD)


## Formatting data for plotting
format_Popgenome_TajD <- function(vcf.TajD){
  # TajD: Popgenome array output; populations: vector of population identifiers.
  positions <- vcf.TajD$position
  vcf.TajD <- subset(vcf.TajD, select = -c(position))
  colnames(vcf.TajD) <- sapply(strsplit(colnames(vcf.TajD),'\\.'),function(x) x[[2]])
  TajD_total <- unname(unlist(vcf.TajD))
  df <- data.frame(population = rep(colnames(vcf.TajD), each = nrow(vcf.TajD)),
                   TajD = TajD_total)
  return(cbind(positions, df))
}

## DRC_GM_KE_MM <- format_Popgenome_TajD(TajD)
## DRC_GM_KE_MM %>% str()


# Plotting Taj-D functions per chromosome.

plot_TajD_chr2 <- function(TajD_formatted, fileName){
  TajD.plot <- ggplot(data = subset(TajD_formatted,!is.na(TajD)), aes(x=positions/1000000, y = TajD)) +
    geom_line(aes(color = population)) +
    geom_vline(xintercept = Pfsa1/1000000) +
    geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
    geom_vline(xintercept = Pfsa2/1000000) +
    geom_text(aes(x=Pfsa2/1000000, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
    theme_light() +
    labs(title = "Tajima's D calculated in a genomic region of Chr 2 of P. falciparum",
         subtitle = "Sliding window of 10 Kb in length",
         x = "Genomic position in Mb")

  ggsave(TajD.plot, file = here("output/TajD/png/",fileName),
         device = "png", dpi = 300,
         width = 14, height = 7)
}

plot_TajD_chr11 <- function(TajD_formatted, fileName){
  TajD.plot <- ggplot(data = subset(TajD_formatted,!is.na(TajD)), aes(x=positions/1000000, y = TajD)) +
    geom_line(aes(color = population)) +
    geom_vline(xintercept = Pfsa3/1000000) +
    geom_text(aes(x=Pfsa3/1000000, label="Pfsa3", y=1), angle=90, vjust = 1.2) +
    theme_light() +
    labs(title = "Tajima's D calculated in a genomic region of Chr 11 of P. falciparum",
         subtitle = "Sliding window of 10 Kb in length",
         x = "Genomic position in Mb")

  ggsave(TajD.plot, file = here("output/TajD/png/",fileName),
         device = "png", dpi = 300,
         width = 14, height = 7)
}

## # plot_TajD_chr11(DRC_GM_KE_MM[DRC_GM_KE_MM$population != "Myanmar",], "Pf7.chr11.full.TajD_DRC_GM_KE.png")
## plot_TajD_chr2(DRC_GM_KE_MM, "Pf7.chr2.TajD.DRC_GM_KE_MM.png")
