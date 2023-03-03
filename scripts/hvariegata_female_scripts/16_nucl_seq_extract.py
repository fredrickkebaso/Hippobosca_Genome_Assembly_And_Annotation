#!/bin/python3

import os

#Extracts gene sequences for the identified chemosensory gene homologs from a genome file

print("Extracting gene sequences from genome file...")

#Extracts raw genome node/queries to a dictionery
sequences = {}
with open('results/velvet_out/hvariegata_f_genome.fa','r') as file:
    genome_seq_id = ""
    genome_seq = ""
    for genome_line in file:
        if genome_line.startswith(">"):
            if genome_seq_id:
                sequences[genome_seq_id] = genome_seq
                genome_seq = ""
            genome_seq_id = genome_line 
        else:
            genome_seq += genome_line.strip()
# Add the last sequence
sequences[genome_seq_id] = genome_seq
#open and extract hit headers or identifiers and add them to a list, gene-query_list
infile_path= "results/blast_homologs/e_value-5"
for file in os.listdir(infile_path):
    if file.endswith("hits.txt"):
        hit_file=os.path.join(infile_path, file)
        gene_file,extension=os.path.splitext(os.path.basename(hit_file))
        gene_file=gene_file.split('_')[0]
        # print(gene_file)
        gene_seq_file=os.path.join(infile_path,gene_file + "_homolog_gene_seqs.fa") #creates new files to append extracted sequences
        # print(gene_seq_file)
        with open (hit_file,'r') as prot_seq:
            with open(gene_seq_file,'w') as seq_file:
                gene_query=[]
                gene_line=prot_seq.readlines()
                for gene_node in gene_line:
                    if gene_node.startswith ('# Query:'):
                        #print(gene_node)
                        gene_query_node= int(gene_node.split("_")[1])
                        if gene_query_node not in gene_query:
                            gene_query.append(gene_query_node)
                for node in gene_query:
                    for seq_id, seq in sequences.items():
                        gene_id = seq_id.strip().split("_")[1]
                        # print(node)
                        if int(gene_id)==node:
                            line=f"{seq_id}\n{seq}\n"
                            seq_file.write(line)
            print(f"Extracted sequences written to {gene_seq_file}")