#!/bin/bash
mkdir -p data
data_dir="data"
SAMPLES=(
    "ACBarrie"
    "Alsen"
    "Baxter"
    "Chara"
    "Drysdale"
)

#DOWNLOAD DATA
for sample in "${SAMPLES[@]}";do
    read1_url="https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/${sample}_R1.fastq.gz"
    read2_url="https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/${sample}_R2.fastq.gz"
    
    wget -P "${data_dir}" "$read1_url"
    wget -P "${data_dir}" "$read2_url" 
done

ref_url="https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta"
wget -P "${data_dir}" "$ref_url"

#QUALITY CONTROL
mkdir -p fastqc_out
for fq in "${data_dir}"/*.fastq.gz;do
    #fastqc -i "${fq}" -o fastqc_out
    fastqc -f fastq -o fastqc_out "${fq}"
done

#TRIMMING
for fastq in "${SAMPLES[@]}";do
    read1="${data_dir}/${fastq}_R1.fastq.gz"
    read1_out="${data_dir}/${fastq}_R1.trimmed.fastq.gz"
    read2="${data_dir}/${fastq}_R2.fastq.gz"
    read2_out="${data_dir}/${fastq}_R2.trimmed.fastq.gz"
    fastp -i "${read1}" -o "${read1_out}" -I "${read2}" -O "${read2_out}"
done

#GENOME MAPPING
reference="${data_dir}/reference.fasta"
bwa index -a bwtsw "${reference}"
mkdir -p bwa_output
for map in "${SAMPLES[@]}"; do
    read1="${data_dir}/${map}_R1.trimmed.fastq.gz"
    read2="${data_dir}/${map}_R2.fastq.gz"
    bwa_result="bwa_output/${map}.sam"
    bwa mem "${reference}" "${read1}" "${read2}" > "${bwa_result}"
    samtools view -hbo "bwa_output/${map}.bam" "bwa_output/${map}.sam"
    samtools sort "bwa_output/${map}.bam" -o "bwa_output/${map}.sorted.bam"
    samtools index "bwa_output/${map}.sorted.bam"
done

#VARIANT CALLING
mkdir -p bcf_output
for bcf in "${SAMPLES[@]}"; do
    bcftools mpileup -Ou -f "${reference}" "bwa_output/${bcf}.sorted.bam" | bcftools call -Ov -mv > "bcf_output/${bcf}.vcf"
done
