#!/usr/bin/env bash

# Define the URL for the reference genome and the desired filename
ref_url="https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta"
ref_name="reference.fasta"

# Download the reference genome if it's not already present
    wget -O "$ref_name" "$ref_url"
    echo "Downloaded reference genome."
    
# Define an array of sequence URLs
seq_urls=(
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

# Loop through each sequence URL
for url in "${seq_urls[@]}"; do
  # Extract the sample name from the URL using cut
  name=$(basename "$url" | cut -d '_' -f 1)
  echo "Sample: $name"

# Download the dataset
  wget -O "${name}_R1.fastq.gz" "$url"
  wget -O "${name}_R2.fastq.gz" "$url"
  echo "Downloaded dataset for $name."  

 # Create directories for quality control and mapping
  mkdir -p "$name"/QCReports
  mkdir -p "$name"/GenMapping
  echo "Created directories for quality control and mapping for $name."
  
# Quality control for both R1 and R2 reads
 fastqc --threads 8 "${name}_R1.fastq.gz" "${name}_R2.fastq.gz" -o "$name"/QCReports
  echo "Performed quality control for $name."

# Summarize QC results
  multiqc "$name"/QCReports
  echo "Summarized QC results for $name."
  
# Trim using fastp
  fastp --thread 8 --detect_adapter_for_pe --cut_mean_quality 20 --length_required 50 --html report.html --json report.json -i "${name}_R1.fastq.gz" "${name}_R2.fastq.gz" -o "${name}_R1_trimmed.fastq.gz" -O "${name}_R2_trimmed.fastq.gz"
  echo "Trimming done for $name."

# Index the reference genome for mapping
bwa index "$ref_name"
echo "Indexed reference genome for Genome mapping."
# Genome Mapping
  bwa mem "$ref_name" "${name}_R1_trimmed.fastq.gz" "${name}_R2_trimmed.fastq.gz" > "$name"/GenMapping/"$name".sam
  samtools view -@ 20 -S -b "$name"/GenMapping/"$name".sam > "$name"/GenMapping/"$name".bam
  samtools sort -@ 32 -o "$name"/GenMapping/"$name".sorted.bam "$name"/GenMapping/"$name".bam
  samtools index "$name"/GenMapping/"$name".sorted.bam
  echo "Genome mapping done for $name."

# Variant calling using bcftools
  samtools faidx "$ref_name"
  bcftools mpileup -Ou -f "$ref_name" "$name"/GenMapping/"$name".sorted.bam | bcftools call -mv -Ob -o "$name"/"$name".bcf
  bcftools view "$name".bcf > "$name".vcf

done
  
