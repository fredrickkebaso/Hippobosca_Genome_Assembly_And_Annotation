#!/bin/bash

set -eu

# Initializing variables

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"
databasedir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_database"
query="${basedir}/results/braker/velvet/braker.aa"
results="${basedir}/results/blast_homologs/spades"

echo Activating conda environment if needed... 

# env_name="hippo"
# # if ! conda info --envs | grep -q "^$env_name"; then
# #     echo "Error: the environment '$env_name' does not exist."
# #     exit 1
# # fi
# # source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

# Remove output directory if it already exists

echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi

# Create required directories

mkdir -p "${results}"

# Constructing a protein database for the known chemosensory genes and searches the predicted genes against the databse

echo Performing Blast search using `blastp -version`

for datafile in "${databasedir}"/* ; do 
    file=${datafile}/*.fasta
    base=$(basename $file .fasta)
    echo ""
    echo Creating database for ${base} sequences... 

    makeblastdb \
    -in ${file} \
    -input_type 'fasta' \
    -dbtype prot \
    -title ${datafile}/${base}_db \
    -out ${datafile}/${base}.fa
done

echo Database created successfully!!!

# Performing blast search

for datafile in "${databasedir}"/* ; do 
    file="${datafile}/*.fasta"
    base="$(basename $file .fasta)"
    
    echo Query: $query
    echo Database: ${datafile}/${base}_db

    blastp \
    -query ${query} \
    -db ${datafile}/${base}.fa \
    -out ${results}/${base}_prot_homolog.txt \
    -num_threads 4 \
    -evalue 0.00000001 \
    -outfmt 7

    echo Blast results written to: "${results}/${base}_prot_homolog.txt"
done

echo Blasting completed successfully!!!


#-evalue 0.00001 \
#-title; specify the title of the BLAST database that will be created. 
#-out;specify the prefix of the output files that will be created.
#-dbtype type of sequences in the infile
# Includes: Drosophila genes
#-hash_index - Create index of sequence hash values.


#Blasting annotated hippoboscas genes against the constructed database.


#-query : is the input sequence file in FASTA format
#-db : is the database file in FASTA format
#-out : is the output file in tabular format
#-evalue : cutoff for reporting matches between the query sequence and the sequences in the BLAST database. The e-value is a measure of the statistical significance of a match, and it represents the number of matches expected to be found by chance with a similar score or better. A lower e-value indicates a more statistically significant match.
#-outfmt : output format (6 Tabular with comment lines)
#-html: 
#sorthits 3 = Sort by percent identity
#Scoring matrix name (normally BLOSUM62)# #!/bin/bash

############################### Reversed Blastp script ###################################################


# set -eu

# #Constructing a protein database for the known chemosensory genes and searches the predicted genes against the databse

# echo Performing Blast search using `blastp -version`

# mkdir -p results/blast_homologs/e_value-5

# dbdir="results/augustus_annotations/prot_database"

# makeblastdb \
# -in ${dbdir}/protein_seqs_masked.fa \
# -input_type 'fasta' \
# -dbtype prot 

# for datafile in /home/kebaso/Documents/projects/hippo/data/databases/prot_database/*
# do 

# file=${datafile}/*.fasta
# base=$(basename $file .fasta)

# echo ""
# echo Running Blastp...
# echo Query: $file
# echo Database: ${dbdir}/protein_seqs_masked.fa

# blastp \
# -query ${file} \
# -db ${dbdir}/protein_seqs_masked.fa \
# -out results/blast_homologs/e_value-5/${base}_prot_homolog.txt \
# -num_threads 4 \
# -evalue 0.00001 \
# -outfmt 7

# echo Blast results written to: results/blast_homologs/e_value-5/${base}_prot_homolog.txt

# done;

# echo Blasting completed successfully!!!

# #-evalue 0.00001 \
# #-title; specify the title of the BLAST database that will be created. 
# #-out;specify the prefix of the output files that will be created.
# #-dbtype type of sequences in the infile
# # Includes: Drosophila genes
# #-hash_index - Create index of sequence hash values.


# #Blasting annotated hippoboscas genes against the constructed database.


# #-query : is the input sequence file in FASTA format
# #-db : is the database file in FASTA format
# #-out : is the output file in tabular format
# #-evalue : cutoff for reporting matches between the query sequence and the sequences in the BLAST database. The e-value is a measure of the statistical significance of a match, and it represents the number of matches expected to be found by chance with a similar score or better. A lower e-value indicates a more statistically significant match.
# #-outfmt : output format (6 Tabular with comment lines)
# #-html: 
# #sorthits 3 = Sort by percent identity
# #Scoring matrix name (normally BLOSUM62)













