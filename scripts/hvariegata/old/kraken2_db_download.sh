#!/bin/bash

set -eu

basedir="/mnt/lustre/users/fkebaso/hippo/data/databases/kraken2/kraken2_conda"

# Name of the conda environment
env_name="kraken2"

# Check if the specified conda environment exists
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: The environment '$env_name' does not exist."
    exit 1
fi

mkdir -p "${basedir}"

# Activate the conda environment
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Build the kraken2 database
echo "Building the kraken2 database..."

kraken2-build --standard --threads 100 --db "${basedir}"

echo "Kraken2 database built successfully."



# #Build customized kraken2 databases

# echo Building customized kraken db....

# basedir=/home/kebaso/Documents/projects/hippo/data/databases/kraken2

# mkdir -p $basedir/{archaea,bacteria,plasmid,viral,human,fungi,plant,protozoa}

# for file in `ls $basedir`
# do 

# echo Buiding db for $file...

# kraken2-build --download-taxonomy --db $basedir/$file \
# kraken2-build --download-library $file --db $basedir/$file \
# kraken2-build --build --threads 60 --db $basedir/$file

# done;

# echo Total database size: `du -h $basedir`

# echo Building databases completed successfully!!!

#Standard db building


