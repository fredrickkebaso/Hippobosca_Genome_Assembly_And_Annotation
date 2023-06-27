#!/bin/bash

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/blast_homologs/spades/orthofinder"

for file in "${basedir}"/*.gff3
do
    gffread   -E "${file}" 
done
