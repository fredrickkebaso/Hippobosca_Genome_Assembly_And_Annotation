#!/usr/bin/env python3

# This script takes an input fasta file and splits it into multiple fasta files, each containing multiple fasta records.
# The script is written in Python3 and uses the Biopython library for fasta parsing and writing.

import os
import math
from Bio import SeqIO

# Define base directory
basedir = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results"

# Define input and output directories and files
input_file = os.path.join(basedir, "velvet_out", "hvariegata_f_genome.fa")
output_dir = os.path.join(basedir, "pilon")
split_dir = os.path.join(output_dir, "split_files")

# Define the number of files to split the input fasta file into
no_of_files = 50

# Create output directories if they don't exist
os.makedirs(os.path.join(output_dir, "pilon"), exist_ok=True) # make directory for pilon output
os.makedirs(split_dir, exist_ok=True) # make directory for split fasta files
open(os.path.join(output_dir, "pilon", "pilon.err"), "a").close() # create empty pilon error file
open(os.path.join(output_dir, "pilon", "pilon.out"), "a").close() # create empty pilon output file

# Split the input fasta file into multiple files with multiple fasta records in each file
print("Splitting the input fasta file into multiple files with multiple fasta records in each file...")
with open(input_file) as f:
    records = list(SeqIO.parse(f, "fasta")) # read all fasta records from the input file
    records_per_file = math.ceil(len(records) / no_of_files) # calculate the number of records per file
    for i in range(no_of_files):
        start_index = i * records_per_file # calculate the start index for the current file
        end_index = min((i + 1) * records_per_file, len(records)) # calculate the end index for the current file
        output_file = os.path.join(split_dir, f"split_{i+1:03d}.fa") # define the output file name
        with open(output_file, "w") as out:
            SeqIO.write(records[start_index:end_index], out, "fasta") # write the fasta records to the output file
        print(f"Split {len(records[start_index:end_index])} records to {output_file}") # print the number of records and the output file name for the current file
print("Done.")
