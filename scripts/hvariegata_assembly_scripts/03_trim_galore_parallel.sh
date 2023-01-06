!/bin/bash

set -eu

echo "Cleaning data using trim_galore v 0.6.6 ..."

echo Found version `trim_galore --version`

mkdir -p results/quality_reports/{quality_clean_reads,multiqc_clean_reads}

echo "Cleaning data using trim_galore in a parallel mode..."

ls -1 data/merged_raw_reads/*.fastq.gz | \
cut -d. -f1 | sort | uniq | \
parallel -j 2 \
trim_galore \
--paired {}.R1.fastq.gz {}.R2.fastq.gz \
--cores 8 \
--length 1 \
--phred33 \
--nextera \
--output_dir results/clean_reads

echo Done.

echo Checking the quality of the reads using fastqc tool version 0.11.9

echo Found version `fastqc --version`

echo Evaluating the quality of the cleaned reads...

fastqc results/clean_reads/*.gz -t 8 -o results/quality_reports/quality_clean_reads

echo Generating report using Multiqc version 1.11


multiqc -o results/quality_reports/multiqc_clean_reads results/quality_reports/quality_clean_reads

echo Done.



