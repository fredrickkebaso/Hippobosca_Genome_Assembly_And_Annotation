#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/kraken/kraken2.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/kraken/kraken2.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N kraken2
set -eu
echo "Loading required modules..."

echo "Initialize required variables..."

basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male"
database="/mnt/lustre/users/fkebaso/hippo/data/databases/kraken2/kraken_db"
results="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/kraken"
species="hcamelina_male"
threads=56
forward_read="${basedir}/results/clean_reads/S4-Hcamelina-M2.R1_val_1.fq.gz"
reverse_read="${basedir}/results/clean_reads/S4-Hcamelina-M2.R2_val_2.fq.gz"

#genome=${basedir}/results/repeatmasker/spades_pilon/hv_f_spades_genome_filtered_assembly_renamed_pilon/hv_f_genome.fa

echo "Loading required modules/Activating required environment..."

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/kraken2

# Remove output directory if it already exists

echo "Removing old output directory (if exists)..."


echo "Creating working directory and required files..."
mkdir -p "${results}"

touch "${results}/kraken2.err" "${results}/kraken2.out"

echo "Running Kraken2..."

kraken2 \
--db "${database}" \
--threads "${threads}" --use-names \
--report "${results}/kraken_report_2.txt" \
--classified-out "${results}/${species}_classified_reads#.fq" \
--unclassified-out "${results}/${species}_unclassified_reads#.fq" \
--minimum-hit-groups 5 \
--confidence 0.7 \
--paired "${forward_read}" "${reverse_read}" 

echo "Kraken2 execution completed."

echo compress the outputs....

pigz ${results}/${species}*.fq

echo Read compression completed successfully !!!
