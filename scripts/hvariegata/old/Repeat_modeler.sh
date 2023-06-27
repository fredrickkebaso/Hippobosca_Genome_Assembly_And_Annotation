#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmodeler/velvet/repeatmodeler.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmodeler/velvet/repeatmodeler.err
#PBS -m abe
#PBS -M "fredrickkebaso@gmail.com"
#PBS -N repeatmodeler.spades

echo "Loading required modules/Activating required environment..."

env_name="repeatmodeler"

# if ! mamba env list | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi

# source "$(mamba info --base)/etc/profile.d/mamba.sh"
mamba activate "$env_name"

# Set input variables
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
assembly_type="velvet"
assembly_file="${basedir}/pilon/velvet/velvet_hv_f_pilon_genome_filtered_assembly_renamed.fasta"
num_threads=24
results="${basedir}/repeatmodeler/${assembly_type}"

echo Create output directory

mkdir -p "${results}"

# Create log and error files
touch "${results}/repeatmodeler.out" "${results}/repeatmodeler.err"

#Create a repeatmodeler database

echo Creating RepeatModeler database

db_name="$(basename $assembly_file )"

echo "${db_name}"

RepeatModeler BuildDatabase -name "${results}/${db_name}" "${assembly_file}"

echo Modelling Repeats...

RepeatModeler -database "${results}/${db_name}"  -threads 24 -LTRStruct > "${results}/${db_name}.log"

echo Modelling completed successfully !!!


echo RepeatMasking the genome....

RepeatMasker -lib <database_name>-families.fa mySequence.fa 


# RepeatModeler \
# -pa ${num_threads} \
# -e rmblast \
# -noisy \
# -dir ${results} \
# -a \
# -small \
# -poly \
# -source \
# -species drosophila \
# -gff \ 
# ${assembly_file}

