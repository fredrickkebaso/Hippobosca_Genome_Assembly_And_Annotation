#!/bin/bash

#masks repeats in the assembled genome 

set -eu

echo Masking repeats: Reccomended, RepeatMasker version 4.1.4
echo Found `RepeatMasker -v`
echo Proceeding with masking...

mkdir -p results/repeatmasker

RepeatMasker \
-pa 5 \
-e rmblast \
-noisy \
-dir results/repeatmasker \
-a \
-small \
-poly \
-source \
-gff results/velvet_out/hlongipennis_f_genome.fa

#-pa-(rallel) [number],The number of sequence batch jobs [50kb minimum] to run in parallel.RepeatMasker will fork off this number of parallel jobs, each running the search engine specified. 
#-e- search engine, RepeatMasker-specific version of the NCBI BLAST search engine.It is a fast and sensitive tool for detecting repeated elements by aligning them to a repeat database. 
#-noisy-prints progress to the stdout, 
#-a produces alignment file, 
#-small-Returns complete .masked sequence in lower case
#-source-Includes for each annotation the HSP "evidence"., 
#-gff-Creates an additional Gene Feature Finding format output


echo Repeat masking completed successfully !!!
