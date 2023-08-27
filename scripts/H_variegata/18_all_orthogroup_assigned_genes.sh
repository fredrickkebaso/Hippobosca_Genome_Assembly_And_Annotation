#!/bin/bash

# Set the base directory path
basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results"
ortho_files="${basedir}/orthofinder/spades"
orthogroups_txt=${ortho_files}/Results_Jul04/Orthogroups/Orthogroups_UnassignedGenes.tsv
predicted_genes=${ortho_files}/hvariegata_pred_genes_renamed.fasta
ann_file=${ortho_files}/hvariegata_f_spades_genome.gtf
predicted_species_name="hvariegata_f_spades"
gene_rename_pattern="hvs_"
results="${basedir}/orthofinder_analysis/filtered_genes"

# Activate the required Conda environment
echo "Loading required modules/Activating the required environment..."

source /home/kebaso/mambaforge/bin/activate 

echo "Conda environment activated!"

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi

echo creating output file...

mkdir -p ${results}

echo "Extracting predicted gene IDs..."
grep "^>" "${predicted_genes}" | sed -e 's/>//' -e "s/${gene_rename_pattern}//"  > "${results}/${predicted_species_name}_predicted_gene_ids.txt"

echo Extracting unassigned genes...

grep -o "${gene_rename_pattern}[^[:space:]]*" ${orthogroups_txt} | sed -e "s/${gene_rename_pattern}//" > "${results}/${predicted_species_name}_unassigned_gene_ids.txt"

echo Filtering orthogroup assigned genes from the total predicted genes...

grep  -v -f "${results}/${predicted_species_name}_unassigned_gene_ids.txt" \
    "${results}/${predicted_species_name}_predicted_gene_ids.txt" > "${results}/${predicted_species_name}_predicted_assigned_gene_ids.txt"

echo Extracting gene sequences for the assigned genes

seqkit grep -f "${results}/${predicted_species_name}_predicted_assigned_gene_ids.txt" ${predicted_genes} > "${results}/${predicted_species_name}_predicted_assigned_gene.fa"

echo Filtering the annotation file for assigned genes...

grep -f "${results}/${predicted_species_name}_predicted_assigned_gene_ids.txt" ${ann_file} > "${results}/${predicted_species_name}_predicted_assigned_gene.gtf"

echo Total predicted genes : $(cat "${results}/${predicted_species_name}_predicted_gene_ids.txt" | wc -l)
echo Predicted and orthogroup assigned genes : $(cat "${results}/${predicted_species_name}_predicted_assigned_gene_ids.txt" | wc -l)
echo Predicted but unassigned genes : $(cat "${results}/${predicted_species_name}_unassigned_gene_ids.txt" | wc -l )
