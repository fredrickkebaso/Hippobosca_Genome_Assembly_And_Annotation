#! /usr/bin/bash
#Filters longest gene isoform

echo Initailizing variables

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"
gff_file="${basedir}/results/braker/spades/braker.gff3"
gtf_file="${basedir}/results/braker/spades/braker.gtf"
results="${basedir}/results/braker/spades"

# activate mamba cgat-env check if it exists first

mamba activate "cgat"

#Removes duplicates -``crop-unique``-  remove non-unique features from gff file.

cgat gff2gff  -I "${gff_file}" --method=crop-unique  --stdout "${results}/gff3_de_duplicated"
