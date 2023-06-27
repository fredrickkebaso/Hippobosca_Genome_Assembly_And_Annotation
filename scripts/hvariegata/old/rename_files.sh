#!/bin/bash

set -eu

workdir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database"

for file in ${workdir}/*.fasta

do
filename=$(basename ${file} .fasta)
newfile=${filename}_nucl.fasta
mv $file ${workdir}/$newfile

ls $workdir
# base=$(basename $file .fasta)

done

