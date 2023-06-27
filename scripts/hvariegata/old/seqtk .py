import os
import subprocess

# Define base directory
basedir = "/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"

# Define input files
velvet_raw = os.path.join(basedir, "velvet/velvet_raw/hv_f_velvet_raw_genome.fa")
velvet_pilon = os.path.join(basedir, "pilon/velvet_hv_f_pilon_genome.fa")
spades = os.path.join(basedir, "spades/hv_f_spades_genome.fa")
velvet_spades = os.path.join(basedir, "velvet/spades_corrected/hv_f_velvet_spades_genome.fa")
threads = 72
genome_files = [velvet_raw, velvet_pilon, spades, velvet_spades]

for file in genome_files:
    # Get the file name without the extension
    file_name = os.path.splitext(os.path.basename(file))[0]

    # Get the directory name where the filtered file will be saved
    out_dir = os.path.dirname(file)

    # Get the size of the input file
    file_size = subprocess.check_output(['du', '-h', file]).decode().split()[0]

    print(f"Filtering {file}...")

    # Filter out contigs shorter than 71bp and save to a new file
    cmd = f"bbduk.sh in={file} out={out_dir}/{file_name}_filtered_assembly.fa minlen=71 overwrite=true"
    subprocess.run(cmd, shell=True, check=True)

    # Get the size of the filtered file
    filtered_size = subprocess.check_output(['du', '-h', f"{out_dir}/{file_name}_filtered_assembly.fa"]).decode().split()[0]

    # Get the total size of records filtered out
    cmd = f"seqstats.sh {out_dir}/{file_name}_filtered_assembly.fa | awk 'NR==2 {{print $2}}'"
    filtered_out = subprocess.check_output(cmd, shell=True).decode().strip()

    print(f"Filtering completed for {file}")
    print(f"Input file size: {file_size}")
    print(f"Filtered file size: {filtered_size}")
    print(f"Total size of records filtered out: {filtered_out}")
