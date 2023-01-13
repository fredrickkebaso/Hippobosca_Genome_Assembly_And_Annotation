#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hvariegata_f_genome_genes...

augustus \
--strand=both \
--uniqueGeneId=true \
--UTR=on \
--gff3=on \
--alternatives-from-sampling=true \
--outfile=results/augustus_annotations/hvariegata_f_genome_ann.gff \
--species=fly \
results/repeatmasker/hvariegata_f_genome_masked/k51_contigs.fa.masked

echo Done
