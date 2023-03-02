#!/bin/bash

set -eu

#Constructing a protein database for the known chemosensory genes and searches the predicted genes against the databse

echo Performing Blast search using `blastp -version`

mkdir -p results/blast_homologs/e_value-5

for datafile in /home/kebaso/Documents/projects/hippo/databases/prot_database/*
do 

file=${datafile}/*.fasta
base=$(basename $file .fasta)
query="results/augustus_annotations/protein_seqs_masked.fa"

echo ""
echo Creating database for ${base} sequences... 

makeblastdb \
-in ${file} \
-input_type 'fasta' \
-dbtype prot \
-title ${datafile}/${base}_db \
-out ${datafile}/${base}.fa

echo Running Blastp...
echo Query: $query
echo Database: ${datafile}/${base}_db

blastp \
-query ${query} \
-db ${datafile}/${base}.fa \
-out results/blast_homologs/e_value-5/${base}_homolog.txt \
-num_threads 4 \
-evalue 0.00001 \
-outfmt 7

echo Blast results written to: results/blast_homologs/e_value-5/${base}_homolog.txt

done;

echo Blasting completed successfully!!!

#-evalue 0.00001 \
#-title; specify the title of the BLAST database that will be created. 
#-out;specify the prefix of the output files that will be created.
#-dbtype type of sequences in the infile
# Includes: Drosophila genes
#-hash_index - Create index of sequence hash values.


#Blasting annotated hippoboscas genes against the constructed database.


#-query : is the input sequence file in FASTA format
#-db : is the database file in FASTA format
#-out : is the output file in tabular format
#-evalue : cutoff for reporting matches between the query sequence and the sequences in the BLAST database. The e-value is a measure of the statistical significance of a match, and it represents the number of matches expected to be found by chance with a similar score or better. A lower e-value indicates a more statistically significant match.
#-outfmt : output format (6 Tabular with comment lines)
#-html: 
#sorthits 3 = Sort by percent identity
#Scoring matrix name (normally BLOSUM62)





