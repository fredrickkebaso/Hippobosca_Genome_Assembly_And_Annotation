#!/bin/bash

#For analysis of cafe output
basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/cafe5/cafe_no_erro/error_model"
script="/home/kebaso/Documents/projects/hippo/hvariegata_female/scripts/bin/tutorial/cafe5_draw_tree.py"
clades=${basedir}/Base_clade_results.txt
report=${basedir}/Base_report.cafe
plot=${basedir}/clade_results.png
results=${basedir}


#Generating cafe plots for gene loss and gain of significant gene famillies

# cafeplotter -i ${basedir} -o ${results}



#Plotting phylogenetic results

python "${script}" -i $clades --ids $report -o $plot

#If you want to know how many and which families underwent a significant expansion/contraction, 
#you can parse this file using simple grep or awk commands.
#To count significant families at the p=0.05 threshold:

echo ""

gain_loss=$(grep -c "y" ${basedir}/Base_family_results.txt)

#Extract signficant gene families to file

grep "y" ${basedir}/Base_family_results.txt > ${results}/Significant_families.txt

echo "Expanded and Contracted gene famillies at p-value 0.05 =" ${gain_loss}

echo ""
# If you used a the default p-value (0.05) in your analysis but have too many significant results, you can filter 
# these to a lower p-value (0.01 in the example) using awk, e.g.:

p_value=0.01

awk '$2 < .01 {print $0}' ${basedir}/Base_family_results.txt > ${results}/Sig_at_p.01.txt

filtered_sigficant=$(cat ${results}/Sig_at_p.01.txt | wc -l)

echo "Expanded and Contracted gene famillies at p-value" ${p_value} "=" ${filtered_sigficant}

