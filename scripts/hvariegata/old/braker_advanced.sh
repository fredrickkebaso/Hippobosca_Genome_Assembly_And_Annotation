#!/bin/bash
#PBS -l select=1:ncpus=30:mpiprocs=30:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=18:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker_advanced/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker_advanced/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_advanced_hv_f

# ---------------- braker_advanced Gene Prediction ----------------

# Ab inition gene prediction

# ---------------- Requirements ------------------

echo "Creating output variables..."

orthoDB="/mnt/lustre/users/fkebaso/hippo/data/databases/close_sp_genome_databases/orthoDB"
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results_dir="${basedir}/results/braker_advanced"
email="fredrickkebaso@gmail.com"

mkdir -p "${results_dir}"
touch "${results_dir}/braker.err" "${results_dir}/braker.out"

genome="${basedir}/results/repeatmasker/hvariegata_f_genome.fa.masked"
protein_file="${orthoDB}/Arthropoda.fa"

# ---------------- Modules -----------------------

echo "Loading required modules/Activating required environment..."

env_name="braker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# ---------------- Run -----------------------

echo "Braker version: $(braker.pl --version)"

echo "Running braker..."

braker.pl \
--genome="${genome}" \
--prot_seq="${protein_file}" \
--gff3 \
--workingdir="${basedir}/results/braker_advanced" \
--min_contig=200 \
--augustus_args="--species=fly" \
--threads 40 \
--makehub \
--email "${email}" \
--verbosity=4

echo "Braker completed successfully !!!"

# --genome=:input genome assembly file to be used for gene prediction
# --prot_seq=input protein sequences file for evidence-based gene prediction
# --AUGUSTUS_ab_initio: enables gene prediction using the ab initio gene predictor AUGUSTUS
# --augustus_args="--species=fly": provides arguments to the AUGUSTUS gene predictor, specifying the species as "fly"
# --useexisting: enables the use of existing gene prediction files from a previous run of braker.pl
# --workingdir=specifies the output directory where results will be saved
# --threads 50: specifies the number of threads to be used for the gene prediction process
# --makehub: generates a UCSC Genome Browser hub to visualize the gene predictions and annotation results
# --email "${email}": specifies an email address to which notifications will be sent after the completion of the job
# --checksoftware: checks that all required software and dependencies are available on the system before running braker.pl.
#--verbosity=n ,0 -> run braker.pl quiet (no log), 1 -> only log warnings, 2 -> also log configuration, 3 -> log all major steps, 4 -> very verbose, log also small steps
#--min_contig=INT, Minimal contig length for GeneMark-EX, could, for example be set to 10000 if transmasked_fasta
# option is used because transmasking might introduce many very short contigs.
#--gff3   Output in GFF3 format (default is gtf format)

