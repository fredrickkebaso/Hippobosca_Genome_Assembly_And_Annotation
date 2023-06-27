#!/bin/bash

# PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
# PBS -q bigmem
# PBS -W group_list=bigmemq
# PBS -l walltime=48:00:00
# PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/ntedit/ntedit.out
# PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/ntedit/ntedit.err
# PBS -m abe
# PBS -M fredrickkebaso@gmail.com
# PBS -N ntedit_hv_f

# ---------------- ntEdit ----------------

# Genome assembly polishing

# ---------------- Requirements ------------------

echo "Creating output variables..."


basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
genome="${basedir}/results/spades/scaffolds.fasta"
results_dir="${basedir}/results/ntedit"
reads="${basedir}/results/clean_reads"

mkdir -p "${results_dir}"
touch "${results_dir}/ntedit.out" "${results_dir}/ntedit.err"

# ---------------- Modules -----------------------

echo "Loading required modules/Activating required environment..."

env_name="ntedit"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo Running ntcard to generate kmer frequency histograms...

ntcard --threads 56 --kmer=51 \
--pref="ntcard_" \
--output="${results_dir}/hvariegata_f_reads.txt" \
"${genome}"

echo Done

echo "Running ntHits..."

nthits -c 2 --outbloom -p \
--kmer=51 --threads 56 --solidBF \
-b 36 --pref="${results_dir}/nthits_hv_f_" \
"${reads}/S1-Hvariegata-F.R1_val_1.fq.gz" \
"${reads}/S1-Hvariegata-F.R2_val_2.fq.gz"


echo Done


echo Running ntEdit....
ntedit -f  -r  -b  -t 

ntedit -t 60 -f "${genome}" -r ${results_dir}/nthits__k51.bf -b ${results_dir}/hvariegata_f_genome_

echo "Done"

# 	-t,	number of threads [default=1]
# 	-f,	draft genome assembly (FASTA, Multi-FASTA, and/or gzipped compatible), REQUIRED
# 	-r,	Bloom filter file (generated from ntHits), REQUIRED
# 	-e,	secondary Bloom filter with kmers to reject (generated from ntHits), OPTIONAL. EXPERIMENTAL
# 	-b,	output file prefix, OPTIONAL
# 	-z,	minimum contig length [default=100]
# 	-i,	maximum number of insertion bases to try, range 0-5, [default=4]
# 	-d,	maximum number of deletions bases to try, range 0-5, [default=5]
# 	-x,	k/x ratio for the number of kmers that should be missing, [default=5.000]
# 	-y, 	k/y ratio for the number of editted kmers that should be present, [default=9.000]
# 	-X, 	ratio of number of kmers in the k subset that should be missing in order to attempt fix (higher=stringent), [default=0.5]
# 	-Y, 	ratio of number of kmers in the k subset that should be present to accept an edit (higher=stringent), [default=0.5]
# 	-c,	cap for the number of base insertions that can be made at one position, [default=k*1.5]
# 	-j, 	controls size of kmer subset. When checking subset of kmers, check every jth kmer, [default=3]
# 	-m,	mode of editing, range 0-2, [default=0]
# 			0: best substitution, or first good indel
# 			1: best substitution, or best indel
# 			2: best edit overall (suggestion that you reduce i and d for performance)
# 	-s,     SNV mode. Overrides draft kmer checks, forcing reassessment at each position (-s 1 = yes, default = 0, no. EXPERIMENTAL)
# 	-a,	Soft masks missing kmer positions having no fix (-v 1 = yes, default = 0, no)
# 	-v,	verbose mode (-v 1 = yes, default = 0, no)

# 	--help,		display this message and exit 
# 	--version,	output version information and exit

# 	If one of X/Y is set, ntEdit will use those parameters instead. Otherwise, it uses x/y by default.





# # ntcard [OPTIONS] ... FILE(S) ...
# # Parameters:
# # -t, --threads=N: use N parallel threads [1] (N>=2 should be used when input files are >=2)
# # -k, --kmer=N: the length of k-mer
# # -c, --cov=N: the maximum coverage of k-mer in output [1000]
# # -p, --pref=STRING: the prefix for output file names
# # -o, --output=STRING: the name for single output file name (can be used only for single compact output file)
# # FILE(S): input file or set of files seperated by space, in fasta, fastq, sam, and bam formats.
# # The files can also be in compressed (.gz, .bz2, .xz) formats . 
# # A list of files containing file names in each row can be passed with @ prefix.