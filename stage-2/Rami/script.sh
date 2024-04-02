#! /bin/bash

read -p "Please input the reference genome URL: " ref_genome_URL
read -p "Please input read1 URL: " read1_URL
read -p "Please input read2 URL: " read2_URL

wget -O ref_genome.fasta $ref_genome_URL
wget -O read1.fastq.gz $read1_URL
wget -O read2.fastq.gz $read2_URL

fastqc *.fastq.gz

multiqc read1_fastqc.zip read2_fastqc.zip

fastp -i read1.fastq.gz -I read2.fastq.gz -o read1_clean.fastq.gz -O read2_clean.fastq.gz --html report.html

bwa index ref_genome.fasta

bwa mem ref_genome.fasta read1.fastq.gz read2.fastq.gz > mapping.sam

samtools view -h -b -o  mapping.bam mapping.sam

samtools view -bF 0xc mapping.bam -o mapping_filtered.bam

samtools sort mapping_filtered.bam -o mapping_filtered.sorted.bam

samtools index mapping_filtered.sorted.bam

bcftools mpileup -Ou -f ref_genome.fasta mapping_filtered.sorted.bam | bcftools call -mv -Ov -o variant_calling.vcf
