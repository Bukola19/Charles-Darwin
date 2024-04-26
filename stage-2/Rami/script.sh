#! /bin/bash

#Take input parameters from user
read -p "Please input the reference genome URL: " ref_genome_URL
read -p "Please input read1 URL: " read1_URL
read -p "Please input read2 URL: " read2_URL

#Prepare the directories
mkdir reads
mkdir ref
mkdir multiqc
mkdir map_output
mkdir VCF

#Download the URLs as given by the user from the web
#Store the read files in `reads` directory
#Store the ref_genome in the `ref` directory
wget -O ref/ref_genome.fasta $ref_genome_URL
wget -O reads/read1.fastq.gz $read1_URL
wget -O reads/read2.fastq.gz $read2_URL

#Repair the read files in case they have different sizes to avoid downstream errors
#Store in `reads` directory
repair.sh -Xmx14g in1=reads/read1.fastq.gz in2=reads/read2.fastq.gz out1=reads/read1_repaired.fastq.gz out2=reads/read2_repaired.fastq.gz

#Perform Quality Control on the repaired input files to assess the quality of the reads in the files individually
#Store in `reads` directory
fastqc reads/*repaired*

#Perform a comparative analysis of both read files together
#Store in `reads` directory
multiqc -o multiqc reads/read1_repaired_fastqc.zip reads/read2_repaired_fastqc.zip

#Trim the read files to remove unwanted noise and contamination
#Store in `reads` directory
fastp -i reads/read1_repaired.fastq.gz -I reads/read2_repaired.fastq.gz -o reads/read1_trimmed.fastq.gz -O reads/read2_trimmed.fastq.gz --html reads/trimming_report.html -j reads/fastp.json

#Index the reference genome to prepare for efficient mapping
#Store in `ref` directory
bwa index ref/ref_genome.fasta

#Map the input read file against the indexed reference genome
#Store in `map_output` directory
bwa mem ref/ref_genome.fasta reads/read1_repaired.fastq.gz reads/read2_repaired.fastq.gz > map_output/mapping.sam

#Convert the output of the mapping to a BAM file to perform downstream analysis
#Store in `map_output` directory
samtools view -h -b -o  map_output/mapping.bam map_output/mapping.sam

#Filter out the reads that did not map to the reference genome
#Store in `map_output` directory
samtools view -bF 0xc map_output/mapping.bam -o map_output/mapping_filtered.bam

#Sort the mapped reads according to their coordinates
#Store in `map_output` directory
samtools sort map_output/mapping_filtered.bam -o map_output/mapping_filtered.sorted.bam

#Index the filtered and sorted BAM file to perform Variant Calling with ease
#Store in `map_output` directory
samtools index map_output/mapping_filtered.sorted.bam

#Mpileup is used to aggregate all results of the mapping for facilitated variant calling
#we feed the output of Mpileup to bcftools call to conduct variant calling.
#Store in `VCF` directory
bcftools mpileup -Ou -f ref/ref_genome.fasta map_output/mapping_filtered.sorted.bam | bcftools call -mv -Ov -o VCF/variant_calling.vcf

#Final message
echo -e "\nThanks for using this pipeline. If you wish to run it again on another dataset, make sure you run in a clear directory to avoid overlapping files"
