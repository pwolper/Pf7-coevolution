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

format_Popgenome_S <- function(vcf.S){
  # TajD: Popgenome array output; populations: vector of population identifiers.
  positions <- vcf.S$position
  vcf.S <- subset(vcf.S, select = -c(position))
  colnames(vcf.S) <- sapply(strsplit(colnames(vcf.S),'\\.'),function(x) x[[2]])
  S_total <- unname(unlist(vcf.S))
  df <- data.frame(population = rep(colnames(vcf.S), each = nrow(vcf.S)),
                   S = S_total)
  return(cbind(positions, df))
}
## DRC_GM_KE_MM <- format_Popgenome_TajD(TajD)
## DRC_GM_KE_MM %>% str()

Pfsa1 <- 631190
Pfsa2 <- 814288
Pfsa3 <- 1058035

#### Plotting Taj-D functions per chromosome.

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

plot_TajD_Pfsa1_region <- function(TajD_formatted, fileName){
  TajD.plot <- ggplot(data = subset(TajD_formatted,!is.na(TajD)), aes(x=positions/1000000, y = TajD)) +
    geom_line(aes(color = population)) +
    geom_vline(xintercept = Pfsa1/1000000) +
    geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
    theme_light() +
    labs(title = "Tajima's D calculated in a genomic region of PfACS8 of P. falciparum",
         subtitle = "Sliding window of 1 Kb in length",
         x = "Genomic position in Mb")

  ggsave(TajD.plot, file = here("output/TajD/png/",fileName),
         device = "png", dpi = 300,
         width = 14, height = 7)
}

## # plot_TajD_chr11(DRC_GM_KE_MM[DRC_GM_KE_MM$population != "Myanmar",], "Pf7.chr11.full.TajD_DRC_GM_KE.png")
## plot_TajD_chr2(DRC_GM_KE_MM, "Pf7.chr2.TajD.DRC_GM_KE_MM.png")

#### Plotting other sliding window stats

plot_S_chr2 <- function(S_formatted, fileName){
  S.plot <- ggplot(data = subset(S_formatted,!is.na(S)), aes(x=positions/1000000, y = S)) +
    geom_line(aes(color = population)) +
    geom_vline(xintercept = Pfsa1/1000000) +
    geom_text(aes(x=Pfsa1/1000000, label="Pfsa1", y=1), angle=90, vjust = 1.2) +
    geom_vline(xintercept = Pfsa2/1000000) +
    geom_text(aes(x=Pfsa2/1000000, label="Pfsa2", y=1), angle=90, vjust = 1.2) +
    theme_light() +
    labs(title = "Number of segregating sites per 10 Kb on Chr 2 of P. falciparum",
         subtitle = "Sliding window of 10 Kb in length, stepwise 2.5 Kb",
         y = "Segregating sites S per 10 Kb",
         x = "Genomic position in Mb")

  ggsave(S.plot, file = here("output/sites/png/",fileName),
         device = "png", dpi = 300,
         width = 14, height = 7)
}

plot_S_chr11 <- function(S_formatted, fileName){
  S.plot <- ggplot(data = subset(S_formatted,!is.na(S)), aes(x=positions/1000000, y = S)) +
    geom_line(aes(color = population)) +
    geom_vline(xintercept = Pfsa3/1000000) +
    geom_text(aes(x=Pfsa3/1000000, label="Pfsa3", y=1), angle=90, vjust = 1.2) +
    theme_light() +
    labs(title = "Number of segregating sites per 10 Kb on Chr 11 of P. falciparum",
         subtitle = "Sliding window of 10 Kb in length, stepwise 2.5 Kb",
         y = "Segregating sites S per 10 Kb",
         x = "Genomic position in Mb")

  ggsave(S.plot, file = here("output/sites/png/",fileName),
         device = "png", dpi = 300,
         width = 14, height = 7)
}
