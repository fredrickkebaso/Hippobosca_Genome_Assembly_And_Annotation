#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hcamelina_f_genome_genes using Augustus.Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

augustus \
--strand=both \
--uniqueGeneId=true \
--UTR=on \
--gff3=on \
--alternatives-from-sampling=true \
--outfile=results/augustus_annotations/hcamelina_f_genome_ann.gff \
--species=fly \
results/repeatmasker/hcamelina_f_genome.fa.masked

echo Completed annotation successfully !!!
