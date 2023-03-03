#!/bin/bash

#Extracts or filters a protein fasta file with the translation of CDS for each record using the augustus prediction file

set -eu

#Cleaning up the gff file 

gffread \
-g results/velvet_out/hvariegata_f_genome.fa \
results/augustus_annotations/hvariegata_f_genome_ann.gff \
-y \
results/augustus_annotations/protein_seqs.fa 


# -g file containing the genome sequences,
# input.gff is the GFF file from which the sequences will be extracted and 
# -y option will extract the CDS and translate them to proteins sequences.
