#!/bin/bash

#PBS -l select=6:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=30:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/soapdenovo2/soapdenovo2.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/soapdenovo2/soapdenovo2.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N soapdenovo2_hv_f

# ---------------- soapdenovo Assembly ----------------

# De novo genome assembly of short reads

# ---------------- Requirements ------------------

# Define output directory and create it if it does not exist

results_dir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/soapdenovo2/spades_corrected"

echo "Creating output directory $results_dir..."

mkdir -p "${results_dir}"

# Create empty log and error files
touch "${results_dir}/soapdenovo2.out"
touch "${results_dir}/soapdenovo2.err"

# Define other variables
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
config_file="${basedir}/scripts/SOAPdenovo2_configfile.txt"
assembly_name="hvariegata_f_spades_genome.fa"
log_file="${results_dir}/hvariegata_f.log"
err_file="${results_dir}/hvariegata_f.err"

# ---------------- Modules -----------------------

# Load required modules and activate conda environment
echo "Loading required modules and activating conda environment..."


env_name="soapdenovo"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# ---------------- Run -----------------------

# Assemble reads using SOAPdenovo-63mer
echo "Assembling reads using SOAPdenovo-63mer..."
SOAPdenovo-63mer \
all \
-s "${config_file}" \
-k 51 \
-R \
-N \
-V \
-o  "${results_dir}" \
1> "${log_file}" \
2> "${err_file}"

#SOAPdenovo-63mer: specifies the command to run SOAPdenovo assembler with a k-mer size of 63.
#all: specifies that SOAPdenovo should run both the contig and scaffold construction.
#-s SOAPdenovo2_configfile.txt: specifies the configuration file for SOAPdenovo, which contains the parameters for the assembly process.
#-k 21: specifies the k-mer size to be used in the assembly process.
#-R: specifies to use the read error correction module in SOAPdenovo to correct sequencing errors.
#-p 50: specifies the number of CPU threads to be used in the assembly process.
#-a 800G: specifies the maximum memory usage for the assembly process.
#-F: specifies to use the fast clustering module in SOAPdenovo to speed up the assembly process.
#-N:  genomeSize: genome size for statistics, [0]
#-V: output visualization information of assembly.
#-0: specifies the output directory for the assembly results.
#1 > :specifies the output file for the assembly log.
#2 > : specifies the output file for any errors that may occur during the assembly process.
