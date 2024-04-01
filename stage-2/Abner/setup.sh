# setup.sh

# Install required tools
# Create a conda environment and install snakemake
conda create -n snake -c bioconda snakemake
# Activate snake env
conda activate snake
# Install FastQC
conda install -c bioconda fastqc
# Install FastP
conda install -c biconda fastp
# Install BWA
conda install -c bioconda bwa
# Install Samtools
conda install -c bioconda samtools
# Install BCFtools
conda install -c bioconda bcftools


