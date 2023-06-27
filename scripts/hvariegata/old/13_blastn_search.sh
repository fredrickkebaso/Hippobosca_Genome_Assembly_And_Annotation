#!/bin/bash

set -eu

#Constructing a nucleotide database for the known chemosensory genes and searches the predicted genes against the databse

echo Performing Blast search using `blastn -version`...

mkdir -p results/blast_homologs/e_value-5

dbdir=results/augustus_annotations/nucl_database

echo ""
echo Creating blastn database ... 

makeblastdb \
-in ${dbdir}/nucleotide_db_seqs.fa \
-input_type 'fasta' \
-dbtype nucl 


for datafile in /home/kebaso/Documents/projects/hippo/data/databases/nucleotide_database/*
do 

file=${datafile}/*.fasta
base=$(basename $file .fasta)

echo Running Blastn...
echo Query: $file
echo Database: $dbdir

blastn \
-query $file \
-db ${dbdir}/nucleotide_db_seqs.fa \
-out results/blast_homologs/e_value-5/${base}_nucl_homolog.txt \
-evalue 0.00001 \
-num_threads 4 \
-outfmt 7

# echo Blastn results written to: results/blast_homologs/e_value-5/${base}_nucl_homolog.txt

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






