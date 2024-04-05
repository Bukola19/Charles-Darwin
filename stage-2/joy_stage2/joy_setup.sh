# setup.sh
#!/bin/bash
#to download anaconda via the command line
wget https://repo.continuum.io/archive/Anaconda3-2024.02-1-Linux-x86_64.sh

#to activate conda environment
conda create --name joy_stage2

#to activate conda environment
conda activate joy_stage2

#to install wget to fetch and download datasets
conda install wget

#to install fastqc for quality control
conda install bioconda::fastqc


#to install fastp for trimming reads
conda install bioconda/label/cf201901::fastp

#to install bwa for read mapping
conda install bioconda::bwa

#to install samtools for parsing and manipulating alignment in SAM/BAM format
conda install bioconda/label/cf201901::samtools

#to install bcftools for manipulating variant calling with vcf and bcf
 conda install bioconda/label/cf201901::bcftools











