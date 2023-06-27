#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=900gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/orthofinder/targeted_chemosensory/targeted_orthofinder.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/orthofinder/targeted_chemosensory/targeted_orthofinder.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N orthofinder_hv_f_targeted_chemosensory

# ----------------------Orthofinder------------------------

#  Gene clustering

# ---------------- Requirements ------------------

echo "Initilizing variables..."

basedir="/mnt/lustre/users/fkebaso/hippo"
prot_sequences="${basedir}/data/databases/close_sp_genome_databases/prot_gene_cds_database"
results="${basedir}/hvariegata_female/results/orthofinder/targeted_chemosensory"
error_files="${basedir}/hvariegata_female/results/orthofinder"

# Remove output directory if it already exists

echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi

echo Creating required directories...

touch "${error_files}/targeted_orthofinder.err" "${error_files}/targeted_orthofinder.out"

# ---------------- Modules -----------------------

echo "Loading required modules/Activating required environment..."

env_name="orthofinder"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# ---------------- Run -----------------------


echo Finding orthologs... 

#OrthoFinder script for fast, accurate and comprehensive for performing comparative genomics

orthofinder \
-M msa \
-f "${prot_sequences}" \
-t 56 \
-y \
-a 8 \
-S blast \
-o "${results}"


echo OrthoFinder Completed successfully !!! 

#-t - Number of parallel sequence search threads [Default = 64]
#-a - Number of parallel analysis threads(Resource intensive consider using 4-8 times lower -t cpus or cores)
#-d - Input is DNA sequences
#-f - protein sequences
#-M - Method for gene tree inference. Options 'dendroblast' & 'msa'
#                [Default = dendroblast]
#  -S <txt>        Sequence search program [Default = diamond]
#                  Options: blast, diamond, diamond_ultra_sens, blast_gz, mmseqs, blast_nucl
#  -A <txt>        MSA program, requires '-M msa' [Default = mafft]
#                  Options: mafft, muscle
#  -T <txt>        Tree inference method, requires '-M msa' [Default = fasttree]
#                  Options: fasttree, raxml, raxml-ng, iqtree
#  -s <file>       User-specified rooted species tree
#  -I <int>        MCL inflation parameter [Default = 1.5]
#  -x <file>       Info for outputting results in OrthoXML format
#  -p <dir>        Write the temporary pickle files to <dir>
#  -1              Only perform one-way sequence search
#  -X              Don't add species names to sequence IDs
#  -y              Split paralogous clades below root of a HOG into separate HOGs
#  -z              Don't trim MSAs (columns>=90% gap, min. alignment length 500)
#  -n <txt>        Name to append to the results directory
#  -o <txt>        Non-default results directory


# OrthoFinder is a fast, accurate and comprehensive platform for comparative genomics. 
#It finds orthogroups and orthologs, infers rooted gene trees for all orthogroups and identifies all 
#of the gene duplication events in those gene trees. It also infers a rooted species tree for the species
# being analysed and maps the gene duplication events from the gene trees to branches in the species tree.
# OrthoFinder also provides comprehensive statistics for comparative genomic analyses. 
