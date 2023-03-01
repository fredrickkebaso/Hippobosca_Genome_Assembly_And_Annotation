#!/bin/bash
#masks repeats in the assembled genome 

set -eu

echo Masking repeats: Reccomended, RepeatMasker version 4.1.4
echo Found `RepeatMasker -v`
echo Proceeding with masking...

mkdir -p results/repeatmasker

RepeatMasker \
-e ncbi \
-noisy \
-dir results/repeatmasker \
-a \
-small \
-poly \
-source \
-gff results/velvet_out/hcamelina_genome.fa
#-e- search engine, 
#-noisy-prints progress to the stdout, 
#-a produces alignment file, 
#-small-Returns complete .masked sequence in lower case
#-source-Includes for each annotation the HSP "evidence"., 
#-gff-Creates an additional Gene Feature Finding format output

echo Repeat masking completed successfully !!!