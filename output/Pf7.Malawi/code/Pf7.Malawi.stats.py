## Population Genetic analysis of Pf7 Malawi Samples
## Calculation of Tajima's D at various loci
## by Philip Wolper, 15.05.2023

import os, io, requests
from pathlib import Path
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Setting paths, script filenames and outputs
path = "/data/home/students/p.wolper/FP-coevolution/"

# Reading Sample meta_data
samples_metadata = pd.read_csv(path+"data/Pf7/Pf7_samples.txt", sep="\t")

# Subset of Malawi
country = "Malawi"

samples_metadata_mask = [True if criteria in country.split() else False for criteria in samples_metadata.Country]
samples_metadata = samples_metadata[samples_metadata_mask]

# Quality control filtering
samples_metadata = samples_metadata[samples_metadata["QC pass"]]

# gDNA filtering
samples_metadata_mask = [True if criteria in ["gDNA"] else False for criteria in samples_metadata["Sample type"]]
samples_metadata = samples_metadata[samples_metadata_mask]

# resetting tables indices
samples_metadata = samples_metadata.reset_index(drop=True)

print(f"Number of gDNA samples in Kenya with QC pass True {len(samples_metadata.index)}")
print(samples_metadata.info)

# Saving Sample ids to txt file
samples_ids = samples_metadata.Sample.tolist()
print(samples_ids)

sample_id_file = "Pf7."+country+"_ids"

with open(path+"output/Pf7.Malawi/"+sample_id_file+".txt","w") as file:
    for id in samples_ids:
        file.write(id + "\n")
