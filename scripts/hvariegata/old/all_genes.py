#!/bin/python3

#Counts the number of genes per family

import os
import pandas as pd

sample_list=["hlongipennis_female","hcamelina_female","hvariegata_female","hcamelina_male"]
base="/home/kebaso/Documents/projects/hippo"
sample_file="results/blast_homologs/e_value-5"
all_gene_dict={}
# gene_dict={}

for file in sample_list:
    infile= os.path.join(base,file,sample_file)
    if os.path.exists(infile):
        gene_dict={}
        all_gene_dict[file]=gene_dict
        for file_2 in os.listdir(infile):
                if file_2.endswith("_longest_isoform_gene_seqs.fa"):
                    gene_file=os.path.join(infile,file_2)
                    with open (gene_file,'r') as seq:
                        count=0
                        lines=seq.readlines()
                        for line in lines:
                            if line.startswith(">"):
                                count +=1
                        fam_name=file_2.split('_')[0]
                        gene_dict[fam_name]=int(count)
        # print(gene_dict)
    else:
        print(file,"path does not exist in the working directory.")

df=pd.DataFrame.from_dict(all_gene_dict)
print(df)



