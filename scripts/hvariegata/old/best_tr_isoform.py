#!/bin/python3

print("Extracting longest transcript isoform gene sequences... ")
#The script groups the transcript into their respective isoforms and writes the longest isoform to another file.
import os
from Bio import SeqIO

# Set the directory path where the input files are located
basedir = "/home/kebaso/Documents/projects/hippo/hvariegata_female"
hits_file=f"{basedir}/results/blast_homologs/spades"

# Set the output directory path where the output files will be saved
results = hits_file

# Iterate through each file in the input directory that has the '_homolog_hits_gene_seqs.fa' extension
for file_name in os.listdir(hits_file):
    if file_name.endswith("_homolog_hits_gene_seqs.fa"):
        # print(file_name)
        # Construct the full path of the input and output files
        input_file = os.path.join(hits_file, file_name)
        new_ext=file_name.replace("_homolog_hits", "_longest_isoform")
        output_file = os.path.join(results, new_ext)
        # print(input_file)
        # Open the input and output files
        with open(input_file, "r") as handle, open(output_file, "w") as out_handle:
            # Read the sequences from the input file and group them by their headers
            records_by_header = {}
            for record in SeqIO.parse(handle, "fasta"):
                # print(record)
                header_parts = record.id.split(".")
                header = header_parts[0]
                if header not in records_by_header:
                    records_by_header[header] = []
                records_by_header[header].append(record)
                        # Select the longest sequence for each header and write it to the output file
            for header, records in records_by_header.items():
                longest_record = max(records, key=len)
                SeqIO.write(longest_record, out_handle, "fasta")
            print(f"Longest isoform written to {output_file} ")





