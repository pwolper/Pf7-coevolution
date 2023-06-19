## R function to calculate Tajima's D on a sliding window transform using PopGenome
## width and jump specify the window sizes.
library(PopGenome)

calc_TajD_sliding_window <- function(vcf, width, jump, output_filename){
  ## Apply sliding window transform
  sliding.vcf <- sliding.window.transform(vcf ,width, jump, type=2)
  sliding.vcf <- neutrality.stats(sliding.vcf)

  ## Extract Tajima's D
  print("Calculating Tajima's D...")
  # print(sliding.vcf@Tajima.D)
  TajD <- sliding.vcf@Tajima.D
  colnames(TajD) <- names(vcf@populations)

  ## Extracting genomic positions
  pos <- unname(sapply(sliding.vcf@region.names, function(x){
    split <- strsplit(x," ")[[1]]
    vals <- as.numeric(split[c(1,3)])
    val <- mean(vals, na.rm = TRUE)
    return(val)
  }))

  ## Write output data
  vcf.TajD <- data.frame(TajD = TajD, position = pos)
  write.table(vcf.TajD,
              file = here("output/TajD/data",output_filename),
              sep = "\t", row.names = FALSE )

  return(vcf.TajD)
}

calc_stats_sliding_window <- function(vcf, width, jump){
  ## Apply sliding window transform
  sliding.vcf <- sliding.window.transform(vcf ,width, jump, type=2)
  sliding.vcf <- neutrality.stats(sliding.vcf)
  sliding.vcf <- recomb.stats(sliding.vcf)

  ## Extract stats
  S <- sliding.vcf@n.segregating.sites
  theta_W <- sliding.vcf@theta_Watterson
  theta_pi <- sliding.vcf@theta_Tajima
  TajD <- sliding.vcf@Tajima.D
  r <- vcf.neutrality@region.statsQ@Hudson.RM

  colnames(S) <- names(vcf@populations)
  colnames(theta_W) <- names(vcf@populations)
  colnames(theta_pi) <- names(vcf@populations)
  colnames(TajD) <- names(vcf@populations)
  colnames(r) <- names(vcf@populations)

  ## Extracting genomic positions
  pos <- unname(sapply(sliding.vcf@region.names, function(x){
    split <- strsplit(x," ")[[1]]
    vals <- as.numeric(split[c(1,3)])
    val <- mean(vals, na.rm = TRUE)
    return(val)
  }))

  ## Combined dataframe
  vcf.stats <- data.frame(S = S,
                          theta_W = theta_W,
                          theta_pi = theta_pi,
                          TajD = TajD,
                          r = r,
                          position = pos)

  return(vcf.stats)
}
