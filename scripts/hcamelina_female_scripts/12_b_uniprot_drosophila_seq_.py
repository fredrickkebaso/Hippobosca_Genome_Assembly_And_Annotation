#!/usr/bin/python3
#Used to retrieve chemosensory protein sequences from Uniprot using accession numbers

import requests

with open('/home/kebaso/Documents/projects/hippo/hvariegata/data/chemosensory_genes_data/drosophila.txt', 'r') as f:
    lines = f.read().split(',')

for acc in lines :

# make an HTTP request to the UniProt API to retrieve the protein sequence in FASTA format
    response = requests.get(f'https://www.uniprot.org/uniprot/{acc}.fasta')

# print the FASTA sequence
    with open('/home/kebaso/Documents/projects/hippo/hvariegata/data/chemosensory_genes_data/drosophila_seqs.fa', "a") as f:
        f.write(response.text)
