## Analysis and plotting of fastSTRUCTURE results using pophelper package
##

library(pophelper); library(here); library(dplyr)

faststructure_dir <- here("output/faststructure/qSNP")
admix_dir <- here("output/faststructure/admixture")

country_labels <- here("data/Pf7/sample_ids/Pf7_african_samples_countries.txt")
countries <- read.table(file = country_labels, stringsAsFactors = FALSE)
countries <- data.frame(countries = countries$V1, stringsAsFactors = FALSE)
countries %>% str()

#read in dapc with grouping designation
dapc <- readRDS(here("output/pca/Pf7_chr11_GT_filtered_dapc_with_Kmeans.rds"))
dapc_grp <- as.character(dapc$assign)
dapc_grp <- as.data.frame(dapc_grp, stringsAsFactors = FALSE)
str(dapc_grp)

# faststructure files
ffiles <- list.files(path=faststructure_dir, pattern = "2014_logistic.+.meanQ", full.names = TRUE)
ffiles

flist <- readQ(files=ffiles)
str(flist)

head(flist[[1]])

tab_flist <- tabulateQ(qlist = flist)
sum_flist <- summariseQ(tab_flist)
tab_flist; sum_flist

## sort_flist <- sortQ(flist, by = "ind")
## alg_flist <- alignK(sort_flist)


# admixture files
afiles <- list.files(path=admix_dir, pattern = "*11.+.GT_filtered.+.Q", full.names = TRUE)
index <- c(9,1,2,3,4,5,6,7,8)
afiles <- afiles[order(index)]
afiles

alist <- readQ(files = afiles)
str(alist)

head(alist[[1]])

tabulateQ(qlist = alist)
summariseQ(tabulateQ(qlist = alist))

alist_K <- alignK(alist)

## Distruct plots
## # unsorted
## plotQ(qlist = flist, sortind = "all", sharedindlab = FALSE,
##       exportpath = here("output/faststructure/distruct/"),
##       outputfilename = "Distruct_chr2_qSNP_2014_logistic_nonsorted_join",
##       imgoutput = "join")

## # sorted by countries
## plotQ(qlist = flist, sortind = "Cluster1", grplab = countries, sharedindlab = FALSE,
##       exportpath = here("output/faststructure/distruct/"),
##       outputfilename = "Distruct_chr2_qSNP_2014_logistic_join",
##       imgoutput = "join")

# unsorted admixture plot
plotQ(qlist = alist, sortind = "all", sharedindlab = FALSE,
      exportpath = here("output/faststructure/admixture/GT_filtered/chr11/"),
      outputfilename = "Admixture_chr11_qSNP_GT_filtered_nonsorted",
      imgoutput = "join")

# sorted by dapc groupings admixture plot
plotQ(qlist = alist, sortind = "label", grplab = dapc_grp, sharedindlab = FALSE,
      ordergrp = TRUE, splab = c("K=2", "K=3", "K=4", "K=5", "K=6", "K=7", "K=8", "K=9", "K=10"),
      splabsize = 7,
      exportpath = here("output/faststructure/admixture/GT_filtered/chr11/"),
      outputfilename = "Admixture_chr11_qSNP_GT_filtered_sorted_dapc",
      imgoutput = "join")

# sorted by country admixture plot
plotQ(qlist = alist, sortind = "label", grplab = countries, sharedindlab = FALSE,
      ordergrp = TRUE, splab = c("K=2", "K=3", "K=4", "K=5", "K=6", "K=7", "K=8", "K=9", "K=10"),
      splabsize = 7, splabangle = -90,
      exportpath = here("output/faststructure/admixture/GT_filtered/chr11/"),
      outputfilename = "Admixture_chr11_qSNP_GT_filtered_sorted_countries",
      imgoutput = "join")
