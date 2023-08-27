#!/bin/bash

#Renames the predicted gene ids by adding a prefix that corresponds to the species and assembly tool

set -eu

#Setting variables
proteindb="/mnt/lustre/users/fkebaso/hippo/data/databases/close_sp_genome_databases/Dme_Glossi_db"
basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results"
predicted_genes=${basedir}/braker/spades_restart/braker.aa
orthofinder_dir="${basedir}/orthofinder/proteindb"
prefix="hcs_"
species="hcamelina"

#Create outputdir

mkdir -p ${orthofinder_dir}

#Rename the predicted genes to match the organism and assembly tool
echo Renaming predicted genes...

seqkit replace -p ^ -r ${prefix} ${predicted_genes} > ${orthofinder_dir}/${species}.faa

echo Done 

echo Renamed genes in ${orthofinder_dir}/${species}.faa

echo Obtaining close species protein files...copying from database...

cp ${proteindb}/*.faa ${orthofinder_dir}

echo Copying files done.



# replace: This option specifies that the operation to be performed is a replacement of text.
# -p: This option specifies the regular expression pattern to match. In this case, ^ is used as the pattern, which matches the beginning of each line.
# -r: This option specifies the replacement text. In the command, "hcv_" is provided as the replacement, which will be added at the beginning of each matched line.
# hcamelina_velvet.faa: This is the input file name. It refers to the multifasta file from which you want to modify the sequence headers.


