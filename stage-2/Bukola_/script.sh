#!/usr/bin/env bash

# make a new directory for the task titled PROJECT3 and change to the directory
mkdir PROJECT3 && cd PROJECT3

# make new directories Data, Ref, results and change to the Data directory
mkdir Data Ref Results && cd Data

# Download the forward strand
wget https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz

# change the directory to the ref folder
cd .. && cd Ref

# download the reference sequence
wget https://zenodo.org/records/10886725/files/Reference.fasta
cd ..

# Activate the conda env
conda activate base

# change the directory to data
cd Data/

# Run the quality control
fastqc *.fastq.gz

# Move the fastqc result to Results directory
mv *_fastqc.zip *.html PROJECT3/Results/

# Change the directory to the result directory
cd .. && cd Results

# Run multiqc to aggregate the qc results
multiqc *_fastqc.zip

# Change to the Data directory
cd .. && cd Data

# Trim the sequence
fastp --thread 8 --detect_adapter_for_pe --cut_mean_quality 20 --length_required 50 --html report.html --json report.json -i ERR8774458_1.fastq.gz -I ERR8774458_2.fastq.gz -o trimmed_ERR8774458_1.fastq.gz -O trimmed_ERR8774458_2.fastq.gz

# Move the Trimmed result to Results directory
mv trimmed_ERR8774458_1.fastq.gz trimmed_ERR8774458_2.fastq.gz report.json report.html ~/PROJECT3/Results/

# change the directory to Ref
cd .. && cd Ref

bwa index Reference.fasta 
bwa mem Reference.fasta ~/PROJECT3/Results/trimmed_ERR8774458_1.fastq.gz ~/PROJECT3/Results/trimmed_ERR8774458_2.fastq.gz > ~/PROJECT3/Results/mapped.sam
cd ../
cd .. && cd Results
samtools view -hbo mapped.bam mapped.sam
samtools sort mapped.bam -o mapped.sorted.bam

# Variant Calling
bcftools mpileup -Ou -f ~/PROJECT3/Ref/Reference.fasta mapped.sorted.bam | bcftools call -mv -Ob -o variants.bcf
cd ..
# To view all the Data generated 
ls -lh ~/PROJECT3/Data/ ~/PROJECT3/Ref ~/PROJECT3/Results/


#!/usr/bin/env bash
