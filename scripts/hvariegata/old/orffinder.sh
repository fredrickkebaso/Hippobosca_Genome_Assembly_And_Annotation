#!/bin/bash

set -eu

#Searching open reading frames in a sequence

echo Running orffinder...

mkdir -p results/orffinder

ORFfinder \
-logfile results/orffinder/orffinder-log.txt \
-in results/blast_homologs/e_value-5/csps_homolog_gene_seqs.fa \
-ml 75 \
-out results/orffinder/orf.txt 

echo Open Reading Frame search completed successfully !!!

# -logfile <File_Out>   File to which the program log should be redirected
# -dryrun - Dry run the application: do nothing, only test all preconditions
# -in <File_In> name of file with the nucleotide sequence in FASTA format
# -ml <Integer> Minimal length of the ORF (nt) Value less than 30 is automatically changed by 30. Default = `75'
# -out <File_Out> Output file name



   

