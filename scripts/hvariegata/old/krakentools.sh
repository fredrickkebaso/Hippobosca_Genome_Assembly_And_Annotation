#!/bin/bash

set -eu

# install krona tools

echo "Loading required modules/Activating required environment..."

# env_name="/home/kebaso/miniconda3/envs/krakentools"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi

# source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

echo "Analyzing kraken reports using krakentools..."

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/kraken/cleaned_reads"
species="hvariegata_female"

mkdir -p "${basedir}"

# Generate Krona report from kraken report
kreport2krona.py   -r "$basedir/kraken_report_2.txt" -o "$basedir/${species}_kraken_report.krona"

# Convert Krona report to HTML format
ktImportText  "$basedir/${species}_kraken_report.krona"  -o "$basedir/${species}_kraken_report.krona.html"

echo "Analysis completed! To visualize the generated report, open the .html file in a browser."
