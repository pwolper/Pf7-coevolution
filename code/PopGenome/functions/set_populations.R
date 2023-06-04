## R function to set the populations of GENOME object in popgenome
## samples columns: id, population (eg. Country)
library(PopGenome)

set_populations <- function(vcf,samples,population){
  populations <- split(samples$id, population)
  str(populations)

  vcf <- set.populations(vcf, populations, diploid = FALSE)
  str(vcf@populations)

  return(vcf)
}
