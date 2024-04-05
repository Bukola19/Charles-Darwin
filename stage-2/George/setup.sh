#!/bin/bash

conda create -n WGS_P

conda activate WGS_P

conda install -n base -c conda-forge mamba

mamba create -c conda-forge -c bioconda -n NGS_P snakemake

conda install bioconda::fastqc -y

mamba install fastp -y

conda install bioconda::bwa -y

conda install bioconda::samtools -y

conda install bioconda::bcftools -y

conda install bioconda::multiqc -y

sudo apt-get install pandoc

echo "Installation complete. Change directory to George before running the pipeline"
