library(here); library(ggplot2); library(dplyr)


vcf_repol <- read.csv(here("output/sfs/unfolded/Pf7.chr2.snps.polarized.txt"))
str(vcf_repol)

vcf_repol$SF %>% max()

# calculating the expected sfs under neutrality using theta_W from PopGenome::neutrality.stats().
# for 1846 afr_samples theta_W is calculated as 667.966 and 1712.087 for chromosome 2 and 11, respectively. The expected sfs is theta_W/i

neutral_sfs <- data.frame(f = c(1:1846))
for(i in c(1:1846)){neutral_sfs$count[i] <- 667.966/i}
str(neutral_sfs)


# plot the sfs together with the expected one.
lower_tail <- ggplot() +
    geom_histogram(data = vcf_repol, mapping = aes(x = SF), binwidth = 1,
                   colour = "black", fill = "white") +
    geom_point(data = neutral_sfs, aes(x = f, y = count), colour = "red", size = 1) +
    geom_line(data = neutral_sfs, aes(x = f, y = count), colour = "red") +
    coord_cartesian(xlim = c(0,50)) +
    labs(x = NULL, y = NULL, title = "Lower tail") +
    theme_light()

upper_tail <- ggplot() +
    geom_histogram(data = vcf_repol, mapping = aes(x = SF), binwidth = 1,
                   colour = "black", fill = "white") +
    geom_point(data = neutral_sfs, aes(x = f, y = count), colour = "red", size = 1) +
    geom_line(data = neutral_sfs, aes(x = f, y = count), colour = "red") +
    coord_cartesian(xlim = c(1830,1847),ylim = c(0,150)) +
    labs(x = NULL, y = NULL, title = "Upper tail") +
    theme_light()

full <- ggplot() +
    geom_histogram(data = vcf_repol, mapping = aes(x = SF), binwidth = 1,
                   colour = "black", fill = "white") +
    #geom_point(data = neutral_sfs, aes(x = f, y = count), colour = "red", size = 1) +
    #geom_line(data = neutral_sfs, aes(x = f, y = count), colour = "red") +
    theme_bw() +
    labs(x = "Site frequencies")
         #title = "Unfolded site frequency spectrum of polarized SNPs on P. falciparum chromosome 11",
         #subtitle = paste(nrow(vcf_repol),"sites from 1846 individuals"))

sfs_unfolded <- full +
    annotation_custom(ggplotGrob(lower_tail), xmin = 50, xmax = 1200, ymin = 750, ymax = 2000) +
    annotation_custom(ggplotGrob(upper_tail), xmin = 1300, xmax = 1850, ymin = 750, ymax = 2000)
sfs_unfolded

## sfs_unfolded <- full +
##     annotation_custom(ggplotGrob(lower_tail), xmin = 50, xmax = 1200, ymin = 2000, ymax = 5300) +
##     annotation_custom(ggplotGrob(upper_tail), xmin = 1300, xmax = 1850, ymin = 2000, ymax = 5300)
## sfs_unfolded

png(here("output/sfs/unfolded/sfs_unfolded_chr2_afr_samples_unlabeled.png"), height = 500, width = 1000)
sfs_unfolded
dev.off()


## plot(names(unfolded_sfs_vcf_repol), unfolded_sfs_vcf_repol, type = "h",
##      xlab = "Unfolded frequency", ylab = "Count",
##      main = "Unfolded site frequency for Pf7 chr2 snps polarized with P. reichenowi")


