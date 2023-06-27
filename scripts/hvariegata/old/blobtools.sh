#!/bin/bash

workdir=/scratch/fkebaso/hippo/hvariegata_female/results

mkdir -p ${workdir}/blobtool_stats

wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz -P ${workdir}/blobtool_stats/data  \

tar zxf ${workdir}/blobtool_stats/data/taxdump.tar.gz -C ${workdir}/blobtool_stats/data/ nodes.dmp names.dmp

blobtools nodesdb --nodes ${workdir}/blobtool_stats/data/nodes.dmp --names ${workdir}/blobtool_stats/data/names.dmp



conda create -n blobtools
conda activate blobtools
mamba install -c anaconda matplotlib docopt tqdm wget pyyaml git
mamba install -c bioconda pysam --update-deps