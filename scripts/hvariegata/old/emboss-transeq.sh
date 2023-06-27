
#!/bin/bash

# This is a shebang line that specifies that the script should be run using the Bash shell.

set -eu

# This sets two Bash options: `set -e` means that the script will exit immediately if any command returns a non-zero exit code, and `set -u` means that the script will exit if it tries to use an undefined variable.

workdir=/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database

# This sets the `workdir` variable to the directory containing the input files.

for file in ${workdir}/*_nucl.fasta
do 
    # This starts a loop over all input files matching the pattern `*_nucl.fasta`.

    base=$(basename $file _nucl.fasta)

    transeq \
    -clean \
    -sequence ${file} \
    -outseq ${workdir}/${base}_prot.fasta 

done

