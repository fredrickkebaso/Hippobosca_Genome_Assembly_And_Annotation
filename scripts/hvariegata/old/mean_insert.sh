#!/bin/bash

# Calculates the mean insert size from insertmetrics.txt files in all directories.

set -eu

workdir="/scratch/fkebaso/hippo/hvariegata_female/results"

echo Calculating mean insert size...

# Initialize variables
total_mean=0
count=0

# Loop through all directories
for dir in ${workdir}/insert_metrics/{001..021}; do

    if [[ -f ${dir}/insertmetrics.txt ]]; then

        # Get mean insert size from insertmetrics.txt file
        mean=$(grep "Mean insert size:" ${dir}/insertmetrics.txt | awk '{print $4}')

        # Add to total mean and increment count
        total_mean=$(echo "${total_mean} + ${mean}" | bc)
        count=$(expr ${count} + 1)

    fi
done

# Calculate mean of total insert size
if [[ ${count} -gt 0 ]]; then
    mean=$(echo "${total_mean} / ${count}" | bc)
    echo "Mean insert size: ${mean}"
else
    echo "No insertmetrics.txt files found"
fi

# Explanation of the script:
#
# This script calculates the mean insert size from the insertmetrics.txt files in all directories in the given workdir.
# It first initializes two variables: total_mean and count, which will be used to keep track of the total sum of mean 
# insert sizes and the number of files that have been processed. 
# Then, the script loops through all directories in the insert_metrics directory. 
# If an insertmetrics.txt file exists in the directory, the script extracts the mean insert size from it using the 
# grep and awk commands. The mean insert size is then added to total_mean and count is incremented. 
# After all files have been processed, the script calculates the mean of total insert size by dividing total_mean by count. 
# If no insertmetrics.txt files were found, the script prints a message indicating that.
