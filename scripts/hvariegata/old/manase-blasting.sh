#!/bin/bash


echo "Creating output variables..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/manase/"
results="${basedir}/assembly/arabiensis/blast"

# Define input files (unmasked genomes)

reference="${basedir}/assembly/arabiensis/arabiensis.fna.gz"
query="${basedir}/assembly/results/lilian/MB_draft.fasta"
# genome_files=("${basedir}/assembly/results/lilian/MB_draft.fasta")

num_threads=40

# Raw reads
# forward_read="${basedir}/raw-reads/Pool_J4-LB_1.fq.gz"
# reverse_read="${basedir}/raw-reads/Pool_J4-LB_2.fq.gz"

# Initializing variables

# basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"
# databasedir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_database"
# query="${basedir}/results/braker/velvet/braker.aa"
# results="${basedir}/results/blast_homologs/spades"

echo Activating conda environment if needed... 

env_name="ncbi-blast"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi
# source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Remove output directory if it already exists

# echo "Removing old output directory (if exists)..."
# if [ -d ${results} ]; then
#     rm -r ${results}
# fi

# Create required directories

mkdir -p "${results}"

# Constructing a protein database for the known chemosensory genes and searches the predicted genes against the databse

echo Performing Blast search using `blastp -version`

# for datafile in "${databasedir}"/* ; do 
#     file=${datafile}/*.fasta
#     base=$(basename $file .fasta)
#     echo ""
echo Creating database for sequences... 

makeblastdb -in "${reference}" -input_type 'fasta' -dbtype nucl -title "${results}_arabiensis_db" -out "${results}_arabiensis.fa"

echo Database created successfully!!!

# Performing blast search

# for datafile in "${databasedir}"/* ; do 
#     file="${datafile}/*.fasta"
#     base="$(basename $file .fasta)"
    
echo Query: $query
    # echo Database: ${datafile}/${base}_db

blastp -query ${query} -db "${results}_arabiensis.fa" -out "${results}_MB_homolog.txt" -num_threads 40 -evalue 0.00001 -outfmt 7

echo Blast results written to: "${results}"

echo Blasting completed successfully!!!



