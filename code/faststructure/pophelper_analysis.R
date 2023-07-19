## Analysis and plotting of fastSTRUCTURE results using pophelper package
##

library(pophelper); library(here)

faststructure_dir <- here("output/faststructure")

## readQ(files = here(faststructure_dir, "chr2_simple.2"))

ffiles <- list.files(path=faststructure_dir, pattern = ".meanQ", full.names = TRUE)
ffiles


flist <- readQ(files=ffiles)
str(flist)

attributes(flist[[1]])
head(flist[[1]])

tab_flist <- tabulateQ(qlist = flist)
sum_flist <- summariseQ(tab_flist)

sort_flist <- sortQ(flist)
alg_flist <- alignK(sort_flist)

plotQ(qlist = alg_flist, returnplot = TRUE,
      exportpath = here("output/faststructure/"), outputfilename = "Distruct_chr2_simple",
      imgoutput = "join")
