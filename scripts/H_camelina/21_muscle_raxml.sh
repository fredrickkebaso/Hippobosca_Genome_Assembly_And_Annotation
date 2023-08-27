#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=900gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/muscle_raxml/muscle_raxml.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/muscle_raxml/muscle_raxml.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N muscle_raxml

set -eu


# For alignment of amino acids

basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results"
sequences="${basedir}/validated_genes/sequences"
concatenated_seqs="total_validated_chem_genes.fa"
results="${basedir}/muscle_raxml"

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi


echo "Activating relevant environment..."

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/muscle

echo "Mamba environment activated!"

# Create output directory

mkdir -p "${results}"

touch ${results}/align.out ${results}/align.err

echo "Output directory created."

echo "Total sequences: $(grep -c ">" "${sequences}/${concatenated_seqs}")"

echo Replacing "*" with ""

sed 's/\*//g' "${sequences}/${concatenated_seqs}" > ${results}/edited_${concatenated_seqs}

echo Done

echo "Aligning amino acids using muscle..."

aln_file_name="${concatenated_seqs%.fa}_aln.fa"

muscle -align "${results}/edited_${concatenated_seqs}" -output "${results}/${aln_file_name}" -consiters 50 -threads 54 

echo "Alignment completed successfully."

echo Trimming alignment....

echo Activating environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/trimal

echo Environment activated successfully !

trimal -in "${results}/${aln_file_name}" -out ${results}/trimal_edited_${aln_file_name}  -htmlout ${results}/trimal_stats_${aln_file_name}.html -automated1

echo Trimming done.

echo Running tree construction using raxml..

echo activating raxml environment

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/raxml

echo Done

echo starting RaxML tree search....

raxml-ng --all \
--msa "${results}/${aln_file_name}" \
--threads 54 \
--workers 9 \
--model LG+FC+G8m \
--tree pars{10} \
--bs-trees 1000 
--check \
--ancestral \
--redo

echo Done