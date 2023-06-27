#!/bin/bash

# activate conda env and check if it exists first

env_name="braker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

conda install -y -c anaconda perl
conda install -y -c anaconda biopython
conda install -y -c bioconda perl-app-cpanminus
conda install -y -c bioconda perl-file-spec
conda install -y -c bioconda perl-hash-merge
conda install -y -c bioconda perl-list-util
conda install -y -c bioconda perl-module-load-conditional
conda install -y -c bioconda perl-posix
conda install -y -c bioconda perl-file-homedir
conda install -y -c bioconda perl-parallel-forkmanager
conda install -y -c bioconda perl-scalar-util-numeric
conda install -y -c bioconda perl-yaml
conda install -y -c bioconda perl-class-data-inheritable
conda install -y -c bioconda perl-exception-class
conda install -y -c bioconda perl-test-pod
conda install -y -c bioconda perl-file-which 
conda install -y -c bioconda perl-mce
conda install -y -c bioconda perl-threaded
conda install -y -c bioconda perl-list-util
conda install -y -c bioconda perl-math-utils
conda install -y -c bioconda cdbtools
conda install -y -c eumetsat perl-yaml-xs
conda install -y -c bioconda perl-data-dumper
conda install -y -c bioconda samtools
conda install -y -c bioconda spaln=2.3.3
conda install -y -c bioconda blast=2.2.31
conda install -y -c bioconda diamond=0.8.24
conda install -y -c daler sratoolkit=3.00
conda install -y -c bioconda hisat2
conda install -y -c bioconda bedtools
conda install -y -c bioconda gffread


for pkg in "perl" "biopython" "perl-app-cpanminus" "perl-file-spec" "perl-hash-merge" "perl-list-util" "perl-module-load-conditional" "perl-posix" "perl-file-homedir" "perl-parallel-forkmanager" "perl-scalar-util-numeric" "perl-yaml" "perl-class-data-inheritable" "perl-exception-class" "perl-test-pod" "perl-file-which" "perl-mce" "perl-threaded" "perl-list-util" "perl-math-utils" "cdbtools" "perl-yaml-xs" "perl-data-dumper" "samtools" "spaln" "blast" "diamond" "sratoolkit" "hisat2" "bedtools" "gffread"
do
    if ! conda list -n braker $pkg | grep -q "^$pkg"; then
        echo "Package $pkg is not installed in the braker environment."
    fi
done






