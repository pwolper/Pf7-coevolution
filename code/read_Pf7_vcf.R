## R function for reading in the vcf files of Plasmodium falciparum
## Variables:
## dir: vcf/dir; file: file.vcf.gz; start: frompos; end: topos
library(PopGenome)

read_Pf7_vcf <- function(dir,file,tid,start,end){
  Pf7.vcf <- readVCF(here("data/Pf7/vcf",dir,file),
                     numcols = 10000, samplenames=Pf7_samples$id,
                     tid=tid,
                     frompos=start,topos=end,
                     include.unknown = TRUE,
                     approx = TRUE,
                     gffpath=here("data/Pf7/gff/Pfalciparum_replace_Pf3D7_MIT_v3_with_Pf_M76611.gff"))
  print(get.sum.data(Pf7.vcf))
  return(Pf7.vcf)
}
