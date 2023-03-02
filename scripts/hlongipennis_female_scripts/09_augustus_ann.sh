#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hlongipennis_female_genome_genes using Augustus.Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

augustus \
--strand=both \
--uniqueGeneId=true \
--UTR=on \
--gff3=on \
--alternatives-from-sampling=true \
--outfile=results/augustus_annotations/hlongipennis_f_genome_ann.gff \
--species=fly \
results/repeatmasker/hlongipennis_f_genome.fa.masked

echo Completed annotation successfully !!!
