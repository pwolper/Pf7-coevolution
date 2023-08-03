## Analysis and plotting of fastSTRUCTURE results using pophelper package
##

library(pophelper); library(here); library(dplyr)

faststructure_dir <- here("output/faststructure/qSNP")
admix_dir <- here("output/faststructure/admixture")

country_labels <- here("data/Pf7/sample_ids/Pf7_african_samples_2014_countries.txt")
countries <- read.table(file = country_labels, stringsAsFactors = FALSE)
countries <- data.frame(countries = countries$V1, stringsAsFactors = FALSE)
countries %>% str()

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
afiles <- list.files(path=admix_dir, pattern = "samples_2014.+.Q", full.names = TRUE)
afiles

alist <- readQ(files = afiles)
str(alist)

head(alist[[1]])

tabulateQ(qlist = alist)
summariseQ(tabulateQ(qlist = alist))


## Distruct plots
# unsorted
plotQ(qlist = flist, sortind = "all", sharedindlab = FALSE,
      exportpath = here("output/faststructure/distruct/"),
      outputfilename = "Distruct_chr2_qSNP_2014_logistic_nonsorted_join",
      imgoutput = "join")

# sorted by countries
plotQ(qlist = flist, sortind = "Cluster1", grplab = countries, sharedindlab = FALSE,
      exportpath = here("output/faststructure/distruct/"),
      outputfilename = "Distruct_chr2_qSNP_2014_logistic_join",
      imgoutput = "join")

# unsorted admixture plot
plotQ(qlist = alist, sortind = "all", sharedindlab = FALSE,
      exportpath = here("output/faststructure/distruct/"),
      outputfilename = "Admixture_chr2_qSNP_2014_logistic_nonsorted_join",
      imgoutput = "join")

# sorted by country admixture plot
plotQ(qlist = alist, sortind = "Cluster1", grplab = countries, sharedindlab = FALSE,
      exportpath = here("output/faststructure/distruct/"),
      outputfilename = "Admixture_chr2_qSNP_2014_logistic_join",
      imgoutput = "join")
