#!/bin/bash
#PBS -l select=1:ncpus=48:mpiprocs=48:mem=700gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/velvet/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/velvet/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_velvet_hv_f

# ---------------- braker Gene Prediction ----------------

# Ab inition gene prediction

# ---------------- Requirements ------------------

# Load Singularity module
module load chpc/singularity/3.5.3

# Set path to BRAKER Singularity container
export BRAKER_SIF="/apps/chpc/bio/BRAKER-3.0.3/braker3.sif"

echo "Initializing variables..."

orthoDB="/mnt/lustre/users/fkebaso/hippo/data/databases/close_sp_genome_databases/orthoDB"
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results="${basedir}/results/braker/velvet"
genome="${basedir}/results/repeatmasker/velvet/hvariegata_f_genome_masked_renamed.fa"
protein_file="${orthoDB}/Arthropoda.fa"
threads=48
contig_size=100
email="fredrickkebaso@gmail.com"

# remove output directory if it already exists

if [ -d ${results} ]; then
    rm -r ${results}
fi

echo Creating output dirs...

mkdir -p "${results}"
touch "${results}/braker.err" "${results}/braker.out"

# ---------------- Run -----------------------

echo "Running braker..."

singularity exec -B ${PWD}:${PWD} ${BRAKER_SIF} braker.pl \
--genome="${genome}" \
--prot_seq="${protein_file}" \
--gff3 \
--workingdir="${results}" \
--min_contig="${contig_size}" \
--augustus_args="--species=fly" \
--threads "${threads}" \
--softmasking \
--makehub \
--email "${email}" 

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

