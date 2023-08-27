#!/bin/bash

# The script filters orthogroups to obtain genes of interest it outputs: gene ids of chemosensory genes per 
#family, sequences, annotation file per family, contigs where eac gene is located within the genome and other intermediary files

set -eu

#-------------------------------Orthofinder version 2.5.5 Results filtering-----------------------------

# Set the base directory path
basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results"
ortho_files="${basedir}/orthofinder/spades"

# Specify the input files
orthogroups_txt=${ortho_files}/Results_Jul04/Orthogroups/Orthogroups.txt
orthogroup_Seqs=${ortho_files}/Results_Jul04/Orthogroup_Sequences
protein_file=${ortho_files}/prot_genome_proteins_faa_filtered_ids #Files used to run orthofinder 

codingseq=${ortho_files}/hvariegata_pred_genes_codingseq
ann_file=${ortho_files}/hvariegata_f_spades_genome.gtf
genome_file=${ortho_files}/genome.fa
predicted_genes=${ortho_files}/hvariegata_pred_genes_renamed.fasta
predicted_species_name="hvariegata_f_spades"
gene_group="chemosensory_genes"
combined_gene_file="all_predicted_chemosensory_genes.fa"
gene_rename_pattern="hvs_"
results=${basedir}/orthofinder_analysis/${gene_group}


# Specify the species and gene families to process

species=("D_melanogaster.fasta"
    "G_brevipalpis.fasta"
    "G_morsitans.fasta"
    "A_gambiae.fasta"
    "G_fuscipes.fasta")
gene_name=(
    "odorant receptor"
    "(ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic)"
    "gustatory receptor"
    "odorant-binding protein"
    "sensory neuron membrane protein"
    "chemosensory protein"
    "gustatory and odorant receptor"
)

# Specify control genes
control_genes=("FBpp0111921" "GBRI004368-PA" "GMOY004222-PA" "GFUI18_012955.P21290" "FBpp0079371" "GBRI036342-PA" "GMOY004392-PA" 
"GFUI18_011542.P18799" "FBpp0071782" "GMOY006081-PA" "GMOY005400-PA" "GFUI18_008313.P12793" "FBpp0077386" "GBRI039848-PA" 
"GMOY011615-PA" "GFUI18_005954.P8780" "FBpp0079291" "GBRI029095-PA" "GMOY005284-PA" "GFUI18_006381.P9508" "GBRI029848-PA" "GMOY013276-PA" 
"FBpp0306711" "FBpp0091011" "FBpp0091039" "FBpp0311291" "GBRI011414-PA" "GBRI020682-PA" "FBpp0070028" "FBpp0070069""FBpp0070381" "FBpp0071134" 
"FBpp0071396" "FBpp0073938" "FBpp0312370" "GBRI002179-PA" "GBRI028428-PA" "GBRI036341-PA" "GBRI036342-PA" "GBRI036522-PA" "GBRI041284-PA" 
"GMOY012276-PA" "GMOY011399-PA" "GMOY011902-PA" "GMOY012255-PA" "AGAP004974.P45" "AGAP005495-PA" "AGAP005760-PA" "AGAP006167-PA" "AGAP006666-PA"
"AGAP006667-PA" "FBpp0073395" "FBpp0113007" "FBpp0289461" "FBpp0312371" "GBRI014933-PA" "GBRI016968-PA" "GBRI016977-PA""GBRI039848-PA" "GBRI043822-PA" 
"GMOY011615-PA" "GMOY011903-PA" "GMOY013297-PA" "GMOY013298-PA" "AGAP004727-PA" "AGAP005047-PA" "AGAP005514-PA" "AGAP006143-PA" "AGAP010195-PA"
"AGAP028572-PA" "AGAP029169-PA" "AGAP012713-PA" "GFUI18_005954.P8780" "GFUI18_003676.P4780" "GFUI18_008191.P12578" "GFUI18_000234.P24870")


# Activate the required Conda environment
echo "Loading required modules/Activating the required environment..."

source /home/kebaso/mambaforge/bin/activate 

echo "Conda environment activated!"



# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi

# Create the output directory
mkdir -p "${results}"

# Extract the predicted gene_ids
echo "Extracting predicted gene IDs..."
# Use grep to extract lines starting with ">" (sequence headers) from the predicted_genes file
# Then use sed to remove the ">" symbol and save the gene IDs in the predicted_species_name_ids.txt file
grep "^>" "${predicted_genes}" | sed 's/>//g' > "${results}/${predicted_species_name}_predicted_gene_ids.txt"

# Add control genes to the predicted_species_name_ids.txt file
for sample in "${control_genes[@]}"
do
    echo $sample >> "${results}/${predicted_species_name}_predicted_gene_ids.txt"
done

# Loop through the gene names
for name in "${gene_name[@]}"
do
    # Replace spaces with underscores in the gene name and save it in the family_name variable
    family_name="${name// /_}"

    # Concatenate chemosensory sequence headers
    echo "Extracting chemosensory gene IDs for gene family: ${name}..."

    # Loop through each species
    for sp in "${species[@]}"
    do
        if [[ "${name}" == "odorant receptor" ]]; then
            # Use grep to filter lines starting with ">" from the protein_file file
            # Exclude lines containing "gustatory and odorant receptor" and select lines matching "odorant receptor" case-insensitively
            # Use cut to extract the first field (gene ID) delimited by " "
            # Use sed to remove the ">" symbol and save the gene IDs in the family_name.txt file
            grep "^>" "${protein_file}/${sp}" | grep -v "gustatory and odorant receptor" | grep -iwE "odorant receptor" | cut -d " " -f1 | sed 's/>//g' >> "${results}/${family_name}_known_gene_ids.txt"
        else
            # Use grep to filter lines starting with ">" from the protein_file/sp file
            # Select lines matching the gene name case-insensitively
            # Use cut to extract the first field (gene ID) delimited by " "
            # Use sed to remove the ">" symbol and save the gene IDs in the family_name.txt file
            grep "^>" "${protein_file}/${sp}" | grep -iwE "${name}" | cut -d " " -f1 | sed 's/>//g' >> "${results}/${family_name}_known_gene_ids.txt"
        fi
    done

    # Extracting gene IDs from the headers
     echo "Extracting orthogroup ids containing genes of interest ${name}s..."

    # Use grep to filter lines matching the gene IDs in the family_name.txt file from the Orthogroups.txt file
    # Use cut to extract the first field (gene ID) delimited by ":"
    # Save the gene IDs in the family_name_ids.txt file
    grep -f "${results}/${family_name}_known_gene_ids.txt" "${orthogroups_txt}" | cut -f1 -d ":" > "${results}/${family_name}_orthogroup_ids.txt"

    # Extracting sequences from orthogroups
    echo "Extracting sequences from orthogroups for gene family: ${name}..."

    # Read the orthogroup IDs from the family_name_ids.txt file
    og=$(cat "${results}/${family_name}_orthogroup_ids.txt")

    # Loop through each orthogroup ID
    for i in $og
    do
        echo "Processing orthogroup: ${i}..."

        # Use seqkit grep to extract sequences from the orthogroup file based on the predicted_species_name_ids.txt file
        # Append the extracted sequences to the family_name.fa file
        seqkit grep -f "${results}/${predicted_species_name}_predicted_gene_ids.txt" ${orthogroup_Seqs}/${i}.fa >> "${results}/${family_name}.fa"       
    done

    #Concatenate all predicted gene family sequences to a single file

    cat "${results}/${family_name}.fa" >> "${results}/${combined_gene_file}"

    #Remove duplicates

    seqkit rmdup "${results}/${combined_gene_file}" > "${results}/all_predicted_chemosensory_genes_deduplicated.fa"

    echo "Extract Contig IDs from the gene annotations GTF file"

    # Check if the naming pattern is given...

    if [ -n ${gene_rename_pattern} ]; then
        grep ">" "${results}/${family_name}.fa" | sed -e 's/>//' -e "s/${gene_rename_pattern}//"  > "${results}/${family_name}_predicted_gene_ids.txt"
    else 
        grep "^>" "${results}/${family_name}.fa"|sed 's/>//g' > "${results}/${family_name}_predicted_gene_ids.txt"
    fi

    # Use grep to filter lines matching the gene IDs in the family_name_predicted_gene_ids.txt file from the ann_file
    # Save the filtered lines (contig IDs) in the family_name_ids.txt file
    
    grep -f "${results}/${family_name}_predicted_gene_ids.txt" "${ann_file}" > "${results}/${family_name}.gtf"
    
    echo Deduplicating the gene family specific gtf file
    # Use cut to extract the first field (contig ID) from the family_name.gff3 file
    # Sort and remove duplicate contig IDs
    # Save the unique contig IDs in the family_name_contig_ids.txt file
    cut -f1 "${results}/${family_name}.gtf"|sort|uniq >"${results}/${family_name}_deduplicated_contig_ids.txt"

    echo Extracting gene family specific contigs....

    # Use seqkit grep to extract sequences from the genome_file based on the family_name_contig_ids.txt file
    # Save the extracted sequences in the family_name.contigs.fa file
    seqkit grep -f "${results}/${family_name}_deduplicated_contig_ids.txt" "${genome_file}" > "${results}/${family_name}.contigs.fasta"
    
    echo Extracting gene DNA sequences...

    seqkit grep -f "${results}/${family_name}_predicted_gene_ids.txt" "${codingseq}" > "${results}/${family_name}_codingseq.fa"

    
    echo Done
done

# Count the number of sequences in each generated family_name.fa file

grep -c "^>" ${results}/*.fa
