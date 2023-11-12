# Script to plot the delta K for the faststructure output

library(here); library(dplyr)

logfiles <- list.files(here("output/faststructure"), pattern ="chr2_logistic_I..?.log")
logfiles

logfiles.K <- sapply(logfiles, function(x) as.integer(strsplit(x, split ="\\.")[[1]][2]))
logfiles.K <- logfiles.K %>% unname() %>% as.factor()

log_n <- list()
for(i in 1:length(logfiles)){
log_n[[i]] <- read.csv(logfiles[[i]], sep = " ", skip = 5, stringsAsFactors = FALSE) %>% tail(n=4) %>% .[1, 1:4]
}


log_n_df <- do.call("rbind",log_n)
str(log_n_df)

log_n_df <- log_n_df %>% mutate_all(as.numeric)
log_n_df <- cbind(log_n_df, logfiles.K)
str(log_n_df)

## Plot the log marginal likelihood for different K

plot(log_n_df$logfiles.K, log(abs(log_n_df$Marginal_Likelihood)))

plot(log_n_df$logfiles.K, log(abs(log_n_df$delta_Marginal_Likelihood)))

# CV error from admixture analysis
CV_error <- read.table(here("output/faststructure/admixture/CV_error_GT_with_priors.txt"), col.names = c("K","CV error"))
#, sep = " ", col.names = c("K", "CV error"))
CV_error$K <- as.factor(CV_error$K)
str(CV_error)

png(here("output/faststructure/admixture/CV_error_GT_with_priors.png"))

plot(CV_error$K, CV_error$CV.error, ylab = "CV error", xlab = "K", main = "Admixture CV error for african qSNP samples with GT filter")

dev.off()
