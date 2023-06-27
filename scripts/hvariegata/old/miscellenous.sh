#PBS -l select=10:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=48:00:00



#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00



echo "Loading required modules/Activating required environment..."

env_name="braker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi


#----------------------------GeneMark----------------------------------

export PATH="/mnt/lustre/users/fkebaso/hippo/genome_utility_tools/GeneMark-ETP/tools:$PATH"
export PATH="/mnt/lustre/users/fkebaso/hippo/genome_utility_tools/GeneMark-ETP/bin:$PATH"

#---------------------------Augustus_parallel---------------------------
export PATH="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/augustus_parallel:$PATH"
export PATH="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/augustus_parallel:$PATH"


#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/manase/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/manase/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_manase_basic_hv_f







grep "^>" S_calcitrans.fasta | grep -i "gene_product=ionotropic"

basedir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids"
gene_family=("(ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic)")

for file in $(ls "${basedir}*.fasta")
do
    count=$(grep -c "^>" "$file" | grep -iE "${gene_family[@]}"
    echo "Count for file $file: $count"
done


rsync -avz fkebaso@lengau.chpc.ac.za:/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/orthofinder/targeted_chemosensory .
