#!/bin/bash

# install krona tools

echo "Analyzing kraken reports using krakentools..."

basedir="/home/kebaso/Documents/projects/hippo/hcamelina_male/results/kraken"
species="hcamelina_male"

echo Activating environment...

source /home/kebaso/mambaforge/bin/activate /home/kebaso/micromamba/envs/kraken2

mkdir -p "${basedir}"

# Generate Krona report from kraken report
python3 scripts/kreport2krona.py   -r "$basedir/kraken_report_2.txt" -o "$basedir/${species}_kraken_report.krona"

# Convert Krona report to HTML format
ktImportText  "$basedir/${species}_kraken_report.krona"  -o "$basedir/${species}_kraken_report.krona.html"

echo "Analysis completed! To visualize the generated report, open the .html file in a browser."
