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

calc_S_sliding_window <- function(vcf, width, jump, output_filename){
  ## Apply sliding window transform
  sliding.vcf <- sliding.window.transform(vcf ,width, jump, type=2)
  sliding.vcf <- neutrality.stats(sliding.vcf)

  S <- sliding.vcf@n.segregating.sites
  colnames(S) <- names(vcf@populations)

  ## Extracting genomic positions
  pos <- unname(sapply(sliding.vcf@region.names, function(x){
    split <- strsplit(x," ")[[1]]
    vals <- as.numeric(split[c(1,3)])
    val <- mean(vals, na.rm = TRUE)
    return(val)
  }))

  ## Write output data
  vcf.S <- data.frame(S = S, position = pos)
  write.table(vcf.S,
              file = here("output/sites/data",output_filename),
              sep = "\t", row.names = FALSE )

  return(vcf.S)
}
