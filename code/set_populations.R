## R function to set the populations of GENOME object in popgenome
## samples columns: id, population (eg. Country)
library(PopGenome)

set_populations <- function(vcf,samples,population){
  populations <- split(Pf7_samples$id, population)
  str(populations)

  Pf7.chr2.vcf <- set.populations(Pf7.chr2.vcf, populations, diploid = FALSE)
  str(Pf7.chr2.vcf@populations)

  return(Pf7.chr2.vcf.pop)
}
