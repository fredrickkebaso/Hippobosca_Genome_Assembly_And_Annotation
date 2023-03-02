#!/bin/bash

set -eu

#Cleaning up the gff file 

gffread \
-g results/velvet_out/hlongipennis_f_genome.fa \
results/augustus_annotations/hlongipennis_f_genome_ann.gff \
-y \
results/augustus_annotations/protein_seqs.fa 


# -g file containing the genome sequences,
#-w  file where the protein sequences will be saved,( w-write in the FASTA defline all the exon  coordinates projected onto the spliced sequence)
# input.gff is the GFF file from which the sequences will be extracted and 
# -y option will extract the CDS and translate them to proteins sequences.
