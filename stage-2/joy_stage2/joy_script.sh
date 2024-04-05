#!/bin/bash
#loop_script for ngs pipeline
mkdir -p data
Data_dir="data"
SAMPLES=(
    "ACBarrie"
    "Alsen"
    "Baxter"
    "Chara"
    "Drysdale"
)

#to download the datasets 
for sample in "${SAMPLES[@]}";do
    read1_url="https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/${sample}_R1.fastq.gz"
    read2_url="https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/${sample}_R2.fastq.gz"
    
    wget -P "${Data_dir}" "$read1_url"
    wget -P "${Data_dir}" "$read2_url" 
done

ref_url="https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta"
wget -P "${Data_dir}" "$ref_url"

#to perform the quality control using fastqc
mkdir -p fastqc_out
for fq in "${Data_dir}"/*.fastq.gz;do
    #fastqc -i "${fq}" -o fastqc_out
    fastqc -f fastq -o fastqc_out "${fq}"
done

#to perform trimming using the fastp
for fastq in "${SAMPLES[@]}";do
    read1="${Data_dir}/${fastq}_R1.fastq.gz"
    read1_out="${Data_dir}/${fastq}_R1.trimmed.fastq.gz"
    read2="${Data_dir}/${fastq}_R2.fastq.gz"
    read2_out="${Data_dir}/${fastq}_R2.trimmed.fastq.gz"
    fastp -i "${read1}" -o "${read1_out}" -I "${read2}" -O "${read2_out}"
done

#to perform genome mapping with the reference fasta using bwa
reference="${Data_dir}/reference.fasta"
bwa index -a bwtsw "${reference}"
mkdir -p bwa_outputfile
for map in "${SAMPLES[@]}"; do
    read1="${Data_dir}/${map}_R1.trimmed.fastq.gz"
    read2="${Data_dir}/${map}_R2.fastq.gz"
    bwa_result="bwa_outputfile/${map}.sam"
    bwa mem "${reference}" "${read1}" "${read2}" > "${bwa_result}"
    samtools view -hbo "bwa_outputfile/${map}.bam" "bwa_outputfile/${map}.sam"
    samtools sort "bwa_outputfile/${map}.bam" -o "bwa_outputfile/${map}.sorted.bam"
    samtools index "bwa_outputfile/${map}.sorted.bam"
done

#to perform the variant calling using the bcftools
mkdir -p bcf_outputfile
for bcf in "${SAMPLES[@]}"; do
    bcftools mpileup -Ou -f "${reference}" "bwa_outputfile/${bcf}.sorted.bam" | bcftools call -Ov -mv > "bcf_outputfile/${bcf}.vcf"
done
