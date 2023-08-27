#!/bin/bash

# Set the base directory path
basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/spades"

# Specify the input files
gft_file="${basedir}/braker.gtf"
genome_file="${basedir}/genome.fa"
results="${basedir}/cleaned_braker.gft"

# Print message indicating the script is starting
echo "Starting the script..."

# Activate the required Conda environment
echo "Loading required modules/Activating the required environment..."

source /home/kebaso/mambaforge/bin/activate /home/kebaso/micromamba/envs/agat
echo "Conda environment activated!"

# Run the agat_sq_stat_basic.pl script with specified parameters
echo "Running agat_sq_stat_basic.pl..."
# agat_sq_stat_basic.pl --file "${gft_file}" --genome "${genome_file}" --inflate --output "${results}"


#Removes redundant entries

# agat_sq_remove_redundant_entries.pl -i "${gft_file}" #[-o <output file>]


#Check a GTF/GFF annotation file to find cases where different gene features have CDS that overlap. 
#In this case the gene features will be merged in only one. One gene is chosen as reference, and the mRNA from the other gene will be linked to it. So, it creates isoforms.

agat_sp_fix_overlaping_genes.pl -f "${gft_file}" --output "${results}"

# Print message indicating the script has finished
echo "Script execution completed!"
