#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hvariegata_f_genome_genes using Augustus.Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

augustus \
--strand=both \
--uniqueGeneId=true \
--UTR=on \
--gff3=on \
--alternatives-from-sampling=true \
--outfile=results/augustus_annotations/hvariegata_f_genome_ann_25_25.gff \
--species=fly \
results/repeatmasker/hvariegata_f_genome_masked/contigs_25_25.fa.masked

echo Completed annotation successfully !!!
