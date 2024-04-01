#!/bin/bash
# source ~/miniconda3/etc/profile.d/conda.sh
# conda activate bioenv2

echo  '==========Creating different directory=========='
mkdir data data/fastq data/ref BAMS VCF

echo  '==========Getting the data=========='
wget -P data/fastq https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz \
		   https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz

wget -P data/ref https://zenodo.org/records/10886725/files/Reference.fasta

echo "==========Performing quality control with FastQC=========="
fastqc data/fastq/*.fastq.gz

multiqc data/fastq/*_fastqc.zip

echo "==========Trimming with FastP=========="



echo "==========Genome Mapping with bwa=========="
bwa index data/ref/Reference.fasta

ref=data/ref/Reference.fasta
read1=data/fastq/ERR8774458_1.fastq.gz
read2=data/fastq/ERR8774458_2.fastq.gz

RGID="000"
RGSN="ERR8774458"
readgroup="@RG\\tID:${RGID}\\tPL:Illumina\\tPU:None\\tLB:None\\tSM:${RGSN}"

bwa mem -t 8 -R "$readgroup" $ref $read1 $read2 | samtools view -h -b -o BAMS/ERR8774458.raw.bam

samtools view -b -F 0xc BAMS/ERR8774458.raw.bam -o BAMS/ERR8774458.filtered.bam

samtools sort -@ 8 -n BAMS/ERR8774458.filtered.bam -o BAMS/ERR8774458.sorted.n.bam

samtools fixmate -m BAMS/ERR8774458.sorted.n.bam BAMS/ERR8774458.fixmate.bam

samtools sort -@ 8 BAMS/ERR8774458.fixmate.bam -o BAMS/ERR8774458.sorted.p.bam

samtools markdup -r -@ 8 BAMS/ERR8774458.sorted.p.bam BAMS/ERR8774458.dedup.bam

samtools index BAMS/ERR8774458.dedup.bam



echo "==========Variant Calling with freebayes=========="
freebayes -f data/ref/Reference.fasta -b BAMS/ERR8774458.dedup.bam --vcf VCF/ERR8774458.vcf

bgzip VCF/ERR8774458.vcf

bcftools index VCF/ERR8774458.vcf.gz


echo "==========Variant Filtering=========="
bcftools view -v snps VCF/ERR8774458.vcf.gz -Oz -o VCF/snps.vcf.gz

bcftools filter -i "QUAL>=30" VCF/ERR8774458.vcf.gz -Oz -o VCF/variants-filtered.vcf.gz


