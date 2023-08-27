#!/bin/bash

basedir="/home/kebaso/Documents/projects/hippo/hcamelina_male/results"
predicted_genes="${basedir}/orthofinder/spades/total_proteins_hcamelina.faa"
validated_files="${basedir}/validated_genes"
results="${validated_files}/sequences"
prefix=("hcGR_" "hcOR_" "hcIR_" "hcCSP_" "hcOBP_" "hcSNMP_")
pattern="hcs_"


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

# Concatenate all the six chemosensory gene families to one file

cat "${results}"/*_renamed.fa >> ${results}/hc_total_validated_chem_genes.fa


cat /home/kebaso/Documents/projects/hippo/hvariegata_female/results/validated_genes/sequences/hv_total_validated_chem_genes.fa > ${results}/total_validated_chem_genes.fa

cat ${results}/hc_total_validated_chem_genes.fa >> ${results}/total_validated_chem_genes.fa

# Specify a specific pattern to search for with grep -c.
grep -c ">" "${results}"/*.fa

grep -c ">" "${results}/total_validated_chem_genes.fa"
