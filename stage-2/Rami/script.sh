#! /bin/bash

read -p "Please input the reference genome URL: " ref_genome_URL
read -p "Please input read1 URL: " read1_URL
read -p "Please input read2 URL: " read2_URL

mkdir reads
mkdir ref
wget -O ref/ref_genome.fasta $ref_genome_URL
wget -O reads/read1.fastq.gz $read1_URL
wget -O reads/read2.fastq.gz $read2_URL

repair.sh -Xmx14g in1=reads/read1.fastq.gz in2=reads/read2.fastq.gz out1=reads/read1_repaired.fastq.gz out2=reads/read2_repaired.fastq.gz

fastqc reads/*repaired*

mkdir multiqc
multiqc -o multiqc reads/read1_repaired_fastqc.zip reads/read2_repaired_fastqc.zip

fastp -i reads/read1_repaired.fastq.gz -I reads/read2_repaired.fastq.gz -o reads/read1_trimmed.fastq.gz -O reads/read2_trimmed.fastq.gz --html reads/trimming_report.html -j reads/fastp.json

bwa index ref/ref_genome.fasta

mkdir map_output
bwa mem ref/ref_genome.fasta reads/read1_repaired.fastq.gz reads/read2_repaired.fastq.gz > map_output/mapping.sam

samtools view -h -b -o  map_output/mapping.bam map_output/mapping.sam

samtools view -bF 0xc map_output/mapping.bam -o map_output/mapping_filtered.bam

samtools sort map_output/mapping_filtered.bam -o map_output/mapping_filtered.sorted.bam

samtools index map_output/mapping_filtered.sorted.bam

mkdir VCF
bcftools mpileup -Ou -f ref/ref_genome.fasta map_output/mapping_filtered.sorted.bam | bcftools call -mv -Ov -o VCF/variant_calling.vcf

echo "Thanks for using this pipeline. If you wish to run it again on another dataset, make sure you run in a clear directory to avoid overlapping files"
