#!/bin/python3

#Counts the number of genes per family in the hit files

import os

basedir = "/home/kebaso/Documents/projects/hippo/hvariegata_female"
infile=f"{basedir}/results/blast_homologs/spades"
gene_dict={}
for file in os.listdir(infile):
    if file.endswith ("_longest_isoform_gene_seqs.fa"):
        gene_file=os.path.join(infile,file)
        with open (gene_file,'r') as seq:
            count=0
            lines=seq.readlines()
            for line in lines:
                if line.startswith(">"):
                    count +=1
            fam_name=file.split('_')[0]
            gene_dict[fam_name]=int(count)
print(gene_dict)

