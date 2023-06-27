#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/kraken/kraken2.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/kraken/kraken2.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N kraken2_hcf
set -eu
echo "Loading required modules..."

# Load required modules (uncomment if necessary)
# module load chpc/BIOMODULES
# module add kraken2/2.0.8-beta

echo "Initialize required variables..."

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
database="/mnt/lustre/users/fkebaso/hippo/data/databases/kraken2/kraken_db"
results="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/kraken/cleaned_reads"
species="hvariegata_female"
threads=56
forward_read="${basedir}/results/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz"   # Path to the forward read file
reverse_read="${basedir}/results/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz"   # Path to the reverse read file
#genome=${basedir}/results/repeatmasker/spades_pilon/hv_f_spades_genome_filtered_assembly_renamed_pilon/hv_f_genome.fa

echo "Loading required modules/Activating required environment..."

# Check if the Conda environment exists
env_name="kraken2"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
# if [ -d "${results}" ]; then
#     rm -r "${results}"
# fi

echo "Creating working directory and required files..."
mkdir -p "${results}"

touch "${results}/kraken2.err" "${results}/kraken2.out"

echo "Running Kraken2..."

kraken2 \
--db "${database}" \
--threads "${threads}" --use-names \
--output "${results}/kraken_stdout_report_1.txt" \
--report "${results}/kraken_report_2.txt" \
--classified-out "${results}/${species}_classified_reads#.fq.gz " \
--unclassified-out "${results}/${species}_unclassified_reads#.fq.gz " \
--minimum-hit-groups 5 \
--confidence 0.7 \
--paired "${forward_read}" "${reverse_read}" 

# --paired "${forward_read}" "${reverse_read}" \
# --memory-mapping 

echo "Kraken2 execution completed."


echo Read Classification completed successfully !!!

# --memory-mapping: Avoids loading database into RAM.
# --db: specifies the Kraken 2 database to use for classification.
# --threads: specifies the number of threads to use for classification.
# --use-names: outputs taxonomy names instead of taxonomy IDs in the output report.
# --memory-mapping: Avoids loading database into RAM.
# --report-zero-counts: includes counts of taxa with zero reads in the output report.
# --output:  Print output to filename (default: stdout); "-" will  suppress normal output
# --report: Print a report with aggregrate counts/clade to file .
# --classified-out: specifies the path and filename prefix for the output files containing reads classified by Kraken 2.
# --unclassified-out: specifies the path and filename prefix for the output files containing reads that were not classified by Kraken 2.
# --paired: specifies that the input reads are paired-end.

#he choice of values for --minimum-hit-groups and --confidence levels in the context of contamination checks for eukaryotes can vary 
#depending on the specific requirements of the analysis and the characteristics of the data. However, there are some common values that 
#are often used as starting points:

#--minimum-hit-groups: For eukaryotic contamination checks, common values for --minimum-hit-groups can range from 5 to 10. This means that at 
#least 5 to 10 similar hits are required to form a hit group and be considered a valid detection. These values help reduce false positives by 
#ensuring a certain level of consistency in the identified hits.

#--confidence: The choice of --confidence level depends on the desired balance between sensitivity and specificity. For eukaryotic contamination 
#checks, common values for --confidence can range from 0.7 to 0.9. A higher confidence level, such as 0.8 or 0.9, helps reduce false positives by
#requiring a higher certainty in the identified detections.
