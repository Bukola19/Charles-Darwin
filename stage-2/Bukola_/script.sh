#!/usr/bin/env
# make a new directory for the task titled PROJECT3 and change to the directory
mkdir PROJECT3 && cd PROJECT3
# make new directories Data, Ref, results and change to the Data directory
mkdir Data Ref Results && cd Data
# Download the forward strand
wget https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz
# Download the reverse strand
wget https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz
# list the files and check the size
ls-lh
# view the content of the zipped file
zcat ERR8774458_1.fastq.gz | less -S
# change the directory to the ref folder
cd ref
# download the reference sequence
wget https://zenodo.org/records/10886725/files/Reference.fasta
# Activate the conda env
conda activate base
# Install fastqc
conda install -c bioconda fastqc
# change the directory to data
cd PROJECT3/data/
# Run the quality control
fastqc *.fastq.gz -o PROJECT/Results
# Install multiqc
conda install -c bioconda multiqc
# Run multiqc to aggregate the qc results
multiqc *_fastq.gz > PROJECT3/results
# Trim the sequence
fastp --thread 8 --detect_adapter_for_pe --cut_mean_quality 20 --length_required 50 --html report.html --json report.json -i ERR8774458_1.fastq.gz -I ERR8774458_2.fastq.gz -o trimmed_ERR8774458_1.fastq.gz -O trimmed_ERR8774458_2.fastq.gz
conda install -c bioconda bwa
# change the directory to Ref
cd PROJECT/Ref/
bwa index Reference.fasta 
bwa mem Reference.fasta trimmed_ERR8774458_1.fastq.gz trimmed_ERR8774458_2.fastq.gz > /PROJECT3/results/mapped.sam
cd ../
cd results/
conda install -c bioconda samtools
samtools view -@ 20 -S -b /PROJECT3/results/mapped.sam > /PROJECT3/results/mapped.bam
cd /PROJECT3/results/
ls -lh
samtools sort -@ 32 -o mapped_sorted.bam mapped.bam
ls
samtools index mapped_sorted.bam
conda install -c bioconda bcftools

