## Analysis and plotting of fastSTRUCTURE results using pophelper package
##

library(pophelper); library(here)

faststructure_dir <- here("output/faststructure")

country_labels <- here("data/Pf7/sample_ids/Pf7_african_samples_countries.txt")
countries <- read.table(file = country_labels, stringsAsFactors = FALSE)
countries <- data.frame(countries = countries$V1, stringsAsFactors = FALSE)

## readQ(files = here(faststructure_dir, "chr2_simple.2"))

ffiles <- list.files(path=faststructure_dir, pattern = "logistic.+.meanQ", full.names = TRUE)
ffiles


flist <- readQ(files=ffiles)
str(flist)

attributes(flist[[1]])
head(flist[[1]])

tab_flist <- tabulateQ(qlist = flist)
sum_flist <- summariseQ(tab_flist)

tab_flist; sum_flist

sort_flist <- sortQ(flist, by = "ind")
alg_flist <- alignK(sort_flist)

## Distruct plots
# unsorted
plotQ(qlist = flist, sortind = "all", sharedindlab = FALSE,
      exportpath = here("output/faststructure/distruct/"),
      outputfilename = "Distruct_chr2_logistic_all_nonsorted_join",
      imgoutput = "join")

# sorted by countries
plotQ(qlist = flist, sortind = "Cluster1", grplab = countries, sharedindlab = FALSE,
      exportpath = here("output/faststructure/distruct/"),
      outputfilename = "Distruct_chr2_logistic_all_join",
      imgoutput = "join")
