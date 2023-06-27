#!/bin/python3

# set -eu

# # This script assesses the accuracy of a genome assembly using BWA read mapping.

# workdir="/scratch/fkebaso/hippo/hvariegata_female/results"

# mkdir -p ${workdir}/mappings

# # Step 1: Index the assembly

# bwa index ${workdir}/velvet_out/hvariegata_f_genome.fa

# # Step 2: Map the paired-end reads to the assembly

# bwa mem -t 64 ${workdir}/velvet_out/hvariegata_f_genome.fa \
# ${workdir}/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz \
# ${workdir}/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz > ${workdir}/mappings/hv_f_genome_mapped_reads.sam

# # Step 3: Convert the SAM file to a BAM file, sort it, and index it

# samtools view -bS ${workdir}/mappings/hv_f_genome_mapped_reads.sam | samtools sort > ${workdir}/mappings/hv_f_genome_mapped_reads.bam

# #-bS options specify the output format as BAM and the input format as SAM, respectively.

# # Step 4: Calculate the read coverage and other stats across the assembly

# samtools depth -a ${workdir}/mappings/hv_f_genome_mapped_reads.bam > ${workdir}/mappings/hv_f_genome_mapped_reads_coverage.txt

samtools stats --threads 64 ${workdir}/mappings/hv_f_genome_mapped_reads.bam > ${workdir}/mappings/hv_f_genome_mapped_reads_stats.txt

# Step 5: Analyze the coverage data and identify regions with high or low coverage

# Explanation:
# This script first indexes the assembly with BWA, then maps the paired-end reads to the assembly using BWA's `mem` algorithm.
# The resulting SAM file is converted to a BAM file, sorted, and indexed using samtools.
# Finally, the script calculates the read coverage across the assembly using samtools depth, and outputs the results to a text file.
# You can then use tools like R or Python to analyze the coverage data and identify regions with high or low coverage.

# #...............................Using python to analyse the coverage......................................

# # Import required libraries
# import pandas as pd
# import matplotlib.pyplot as plt

# # Set working directory
# workdir = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results"

# # Define chunksize for reading in the file
# chunksize = 10 ** 6  # 1 million rows at a time

# # Initialize empty dataframe to store concatenated chunks
# coverage = pd.DataFrame()

# # Loop over chunks and append to coverage dataframe
# for chunk in pd.read_csv(workdir + "/mappings/hv_f_genome_mapped_reads_coverage.txt", sep="\t", header=None, names=["chrom", "pos", "cov"], chunksize=chunksize):
    
#     # Plot progress
#     print("Processing chunk...")
    
#     # Append chunk to coverage dataframe
#     coverage = pd.concat([coverage, chunk])

# # Plot coverage distribution
# plt.hist(coverage["cov"], bins=range(0, max(coverage["cov"]), 5))
# plt.xlabel("Coverage")
# plt.ylabel("Count")
# plt.xlim([0, 100])
# plt.show()


