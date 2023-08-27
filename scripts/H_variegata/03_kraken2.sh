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
results="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/kraken"
species="hvariegata_female"
threads=56
forward_read="${basedir}/results/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz"
reverse_read="${basedir}/results/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz"
#genome=${basedir}/results/repeatmasker/spades_pilon/hv_f_spades_genome_filtered_assembly_renamed_pilon/hv_f_genome.fa

echo "Loading required modules/Activating required environment..."

# Check if the Conda environment exists
echo "Loading required modules/Activating required environment..."

# Check if the Conda environment exists
env_name="kraken2"

source /home/fkebaso/miniconda3/bin/activate /home/fkebaso/miniconda3/envs/${env_name}
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
--classified-out "${results}/${species}_classified_reads#.fq.gz" \
--unclassified-out "${results}/${species}_unclassified_reads#.fq.gz" \
--minimum-hit-groups 5 \
--confidence 0.7 \
--paired "${forward_read}" "${reverse_read}" 

echo "Kraken2 execution completed."


echo Read Classification completed successfully !!!
