#!/bin/bash

set -eu

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results"
predicted_genes="${basedir}/orthofinder/spades/hvariegata_pred_genes_renamed.fasta" #total_proteins_hvariegata_seqs.faa"
validated_files="${basedir}/validated_genes"
results="${validated_files}/sequences"
prefix=("hvGR_" "hvOR_" "hvIR_" "hvCSP_" "hvOBP_" "hvSNMP_")
pattern="hvs_"


# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d "${results}" ]; then
    rm -r "${results}"
fi

# Create the output directory
mkdir -p "${results}"

# Activate the required Conda environment
echo "Loading required modules/Activating the required environment..."
source /home/kebaso/mambaforge/bin/activate 
echo "Conda environment activated!"

for file in "${validated_files}"/*.txt; do
    file_name=$(basename "${file}" .txt)

    # Use the correct file variable and provide a pattern file for seqkit grep.
    seqkit grep -f "${file}" "${predicted_genes}" > "${results}/${file_name}.fa"

    #Rename the genes

    if [[ $file_name == "validated_grs" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[0]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"
    elif [[ $file_name == "validated_ors" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[1]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"
    
    elif [[ $file_name == "validated_Irs_ANF" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[2]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"
    
    elif [[ $file_name == "validated_Irs_PBP_iGRS" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[2]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"

    elif [[ $file_name == "validated_csps_osd_like" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[3]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"

    elif [[ $file_name == "validated_csps_DUF_1091" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[3]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"
    elif [[ $file_name == "validated_csps_DM_11" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[3]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"
    
    elif [[ $file_name == "validated_obps" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[4]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"

    elif [[ $file_name == "validated_minus_c_obps" ]]; then

        seqkit replace -p ^${pattern} -r ${prefix[4]} "${results}/${file_name}.fa" > "${results}/${file_name}_renamed.fa"
    fi
done


# Concatenate all the six chemosesnory gene families to one file

cat "${results}"/*_renamed.fa >> ${results}/hv_total_validated_chem_genes.fa


cat /home/kebaso/Documents/projects/hippo/hcamelina_male/results/validated_genes/sequences/hc_total_validated_chem_genes.fa >> \
    ${results}/total_validated_chem_genes.fa
cat ${results}/hv_total_validated_chem_genes.fa >> ${results}/total_validated_chem_genes.fa

# Specify a specific pattern to search for with grep -c.
grep -c ">" "${results}"/*.fa
