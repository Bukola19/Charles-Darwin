#!/bin/bash
# activate conda environment
ref_url="https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta"
ref_name="reference.fasta"
#download reference sequence
wget -O "$ref_name" "$ref_url"
# to define an array of sample urls
sample_urls=(
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R2.fastq.gz"
 )
# loop each sequence url
for url in "${sample_urls[@]}"; do
name=$(basename "$url" | cut -d '_' -f 1)
#download the fastq sequences
wget -O "${name}_R1.fastq.gz" "$url"
wget -O "${name}_R2.fastq.gz" "$url"
#create directory for Quality control, Genome Mapping and Variant calling
mkdir -p QC-reports Mapping Variant-calling
# Quality control for read1 and read2
fastqc -i "${name}_R1.fastq.gz" "${name}_R2.fastq.gz" -o "QC-reports"
# Multiqc reports
multiqc QC-reports/*fastqc
# Trimming of fastq.gz files
fastp -i "${name}_R1.fastq.gz" -I "${name}_R2.fastq.gz" -o "${name}_R1_trimmed.fastq.gz" -O "${name}_R2_trimmed.fastq.gz"
#index the reference genome
bwa index "$ref_name"
#Genome mapping
bwa mem "$ref_name" "${name}_R1_trimmed.fastq.gz" "${name}_R2_trimmed.fastq.gz" > Mapping/"$name".sam
samtools view -@ 10 -S -b Mapping/"$name".sam > Mapping/"$name".bam
samtools sort -@ 10 -o Mapping/"$name".sorted.bam Mapping/"$name".bam































 



















































