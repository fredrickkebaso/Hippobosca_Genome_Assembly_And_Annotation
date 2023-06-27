


module load chpc/BIOMODULES
module add seqkit

merged_raw="/home/alaigong/lustre/Hippobosca_analysis/Data"

awk '$3 > 89.00' ${merged_raw}/blast_raw/S1-Hvariegata-F1_S1_L001_merged.fa.blast.txt \
| cut -f1 | awk '{print ">"$0}' >> ${merged_raw}/blast_raw/blast_hits.txt

raw_fasta=${merged_raw}/trimmed_fasta/S1-Hvariegata-F1_S1_L00*.fa


# Extracting sequences from genome files
    echo "Extracting sequences.."
    og=$(cat ${merged_raw}/blast_raw/blast_hits.txt)

    for i in $og
    do 
        echo "Processing sequence: ${i}..."
        seqkit grep -f ${merged_raw}/blast_raw/blast_hits.txt ${raw_fasta} >> ${merged_raw}/trimmed_fasta/S1-Hvariegata-R1.fa
    done
    

echo Done