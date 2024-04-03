#! /bin/bash

conda install bioconda::fastqc
conda install -c bioconda multiqc=1.21
conda install bioconda::fastp
conda install bioconda::bwa
conda install bioconda::samtools
conda install bioconda::bcftools
