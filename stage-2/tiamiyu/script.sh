#!/bin/bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate bioenv2

echo  '==========Creating different directories=========='
mkdir data data/fastq data/ref BAMS SAM VCF data/fastq/trimmed_reads

echo  '==========Getting the data=========='
wget -P data/fastq https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz \
                   https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz

wget -P data/ref https://zenodo.org/records/10886725/files/Reference.fasta

echo "==========Performing quality control with FastQC=========="
fastqc data/fastq/*.fastq.gz

multiqc data/fastq/*_fastqc.zip

echo "==========Trimming with FastP=========="
fastp  -i data/fastq/ERR8774458_1.fastq.gz -I data/fastq/ERR8774458_2.fastq.gz -o data/fastq/trimmed_reads/ERR8774458_1.fastq.gz -O data/fastq/trimmed_reads/ERR8774458_2.fastq.gz --html data/fastq/trimmed_reads/ERR8774458_fastp.html --json data/fastq/trimmed_reads/ERR8774458_fastp.json


echo "==========Indexing the Refereence Genome with BWA=========="

bwa index -a bwtsw data/ref/Reference.fasta

echo "==========Genome Mapping/Assembling with BWA=========="
# to map the trimmed reads to a reference genome using BWA and producing SAM output

ref=data/ref/Reference.fasta
read1=data/fastq/trimmed_reads/ERR8774458_1.fastq.gz
read2=data/fastq/trimmed_reads/ERR8774458_2.fastq.gz

bwa mem $ref $read1 $read2 > SAM/ERR8774458.sam

# convert the SAM file into a BAM file that can be sorted and indexed
samtools view -hbo BAMS/ERR8774458.bam SAM/ERR8774458.sam 

# sort the BAM file by position in genome
samtools sort BAMS/ERR8774458.bam -o BAMS/ERR8774458.sorted.bam

# index the sorted BAM file to randomly access it quickly in variant calling 
samtools index BAMS/ERR8774458.sorted.bam

echo "==========Performing Variant Calling with bcftools=========="
# to call variants from the mapped reads (sorted BAM) using a variant caller bcftools

bcftools mpileup -Ou -f $ref BAMS/ERR8774458.sorted.bam|bcftools -Ov -mv > VCF/ERR8774458.vcf
