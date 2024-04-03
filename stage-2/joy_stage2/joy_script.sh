

#!/bin/bash
source ~/anaconda3/etc/profile.d/conda.sh
conda activate joy_stage2

#set up various directories for the output
mkdir data data/fastq data/ref BAMS SAM VCF data/fastq/trimmed_reads

#downloading datasets using wget
wget -P data/fastq https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz \
                   https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz
#to check the downloaded data size and content
ls -lh

#to perform fastqc for the datasets
fastqc data/fastq/*.fastq.gz

#to generate summary of fastq report
multiqc data/fastq/*_fastqc.zip

#to trim the fastq files
fastp  -i data/fastq/ERR8774458_1.fastq.gz -I data/fastq/ERR8774458_2.fastq.gz -o data/fastq/trimmed_reads/ERR8774458_1.fastq.gz -O data/fastq/trimmed_reads/ERR8774458_2.fastq.gz --html data/fastq/trimmed_reads/ERR8774458_fastp.html --json data/fastq/trimmed_reads/ERR8774458_fastp.json


#to index the reference genome for mapping using bwa

bwa index -a bwtsw data/ref/Reference.fasta


# to map the trimmed fastq files  to a reference genome using bwa

ref=data/ref/Reference.fasta
read1=data/fastq/trimmed_reads/ERR8774458_1.fastq.gz
read2=data/fastq/trimmed_reads/ERR8774458_2.fastq.gz

bwa mem $ref $read1 $read2 > SAM/ERR8774458.sam

# to convert the SAM file into a BAM file that can be sorted and indexed
samtools view -hbo BAMS/ERR8774458.bam SAM/ERR8774458.sam 

# to sort the BAM file in genome
samtools sort BAMS/ERR8774458.bam -o BAMS/ERR8774458.sorted.bam

# to  index the the sorted files
samtools index BAMS/ERR8774458.sorted.bam


# to use bcftools call the variant calling

bcftools mpileup -Ou -f $ref BAMS/ERR8774458.sorted.bam|bcftools call -Ov -mv > VCF/ERR8774458.vcf
