#!/bin/bash
conda config --add channels bioconda
conda config --add channels conda-forge

conda create -n bioenv2 fastqc multiqc bwa samtools freebayes bcftools tabix

source ~/miniconda3/etc/profile.d/conda.sh
conda activate bioenv2
