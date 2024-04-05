conda config --show channels
conda create -n variant-calling fastqc multiqc bwa samtools freebayes bcftools tabix
conda activate variant-calling
mkdir stage2
cd ~/stage2
cd stage2
mkdir project2
cd project2
mkdir fastq
mkdir ref
ls
cd fastq
wget -O ERR8774458_1.fastq.gz https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz?download=1
wget -O ERR8774458_2.fastq.gz https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz?download=1
ls
cd ref
wget -O Reference.fasta https://zenodo.org/records/10886725/files/Reference.fasta?download=1
ls
cd project2
cd ..
cd fastq
fastqc fastq/* .fastq.gz
ls
multiqc fastq/*_fastqc.zip
multiqc
multiqc fastq/* _fastqc.zip
multiqc fastq/*
ls
mkdir raw_reads
cd project2
cp ./fastq/ERR8774458_1.fastq.gz ./raw_reads
cp ./fastq/ERR8774458_2.fastq.gz ./raw_reads
cd raw_reads
ls
cd ..
cd project2
mkdir trimmed_reads
cd trimmed_reads
conda install -c bioconda fastp
clear
cat raw_reads
cd ..
cd raw_reads
fastp -i ERR8774458_1.fastq.gz -I ERR8774458_2.fastq.gz -o trimmed-ERR8774458_1.fastq.gz -O trimmed-ERR8774458_2.fastq.gz
ls
cp ./raw_reads/trimmed-ERR8774458_1.fastq.gz ./trimmed_reads
cd ..
ls
cp ./raw_reads/trimmed-ERR8774458_1.fastq.gz ./trimmed_reads
cp ./raw_reads/trimmed-ERR8774458_2.fastq.gz ./trimmed_reads
cd trimmed_reads
ls
fastqc trimmed_reads/* fastq.gz
cd ..
fastqc trimmed_reads/* fastq.gz
ls
cd trimmed_reads
 ls
multiqc trimmed-ERR8774458_1_fastqc.zip trimmed-ERR8774458_2_fastqc.zip
ls
cd ref
ls
bwa index Reference.fasta
ls
mkdir BAMS

  
 mv Reference.fasta index/
 bwa index index/Reference.fasta
 cd BAMS
ls
 cp  ./trimmed-ERR8774458_1.fastq.gz ./BAMS
cp ./trimmed-ERR8774458_2.fastq.gz ./BAMS
ls
bwa mem -t 8 index/Reference.fasta trimmed-ERR8774458_1.fastq.gz trimmed-ERR8774458_2.fastq.gz > output.sam
 ls
du -sh output.sam
samtools view -b output.sam > output.bam
du -sh output.bam
rm output.sam
 samtools sort -o output.sorted.bam output.bam
ls
samtools index output.sorted.bam
ls
samtools flagstat output.sorted.bam
 samtools -b -F 0xc BAMS/output.sorted.bam -o BAMS/output.filtered.bam
 samtools view -b -F 0xc BAMS/output.sorted.bam -o BAMS/output.filtered.bam
  ls
  cd BAMS
  samtools markdup -r -@ 8 BAMS/output.sorted.bam BAMS/output.dedup.bam
  cd BAMS
 du -sh output.fixmate.bam
  samtools sort -@ 8 BAMS/output.fixmate.bam -o BAMS/output.sorted.p.bam
 mkdir output
 cp ./BAMS/output.fixmate.bam ./output
  cd output
 ls
 cd output
samtools sort -@ 8 output.fixmate.bam -o output/output.sorted.p.bam
cd ..
mkdir VCF
wget https://zenodo.org/records/10886725/files/Reference.fasta
ls
bwa index Reference.fasta
ls
freebayes -f Reference.fasta -b output.sorted.bam > output.vcf
ls
du -sh output.vcf
bgzip output.vcf
ls
bcftools index output.vcf.gz
zgrep -v -c '^#'output.vcf.gz
bcftools view -v indels output.vcf.gz|grep -v -c '^#'
bcftools view -v snps output.vcf.gz|grep -v -c '^#'
bcftools view -v snps output.vcf.gz -Oz -o snps.vcf.gz
ls
zgrep -v -c '^#' snps.vcf.gz
bcftools filter -i "QUAL>=30" output.vcf.gz -oz -o variants.filtered.vcf.gz
zgrep -v -c '^#' variants.filtered.vcf.gz

Task2
conda activate variant-calling
  881  ls
  882  cd stage2
  888  mkdir project3
  889  cd project3
  890  mkdir downloadlinks.txt
  891  cd downloadlinks.txt  ls
                                                                                                                                                                        https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R2.fastq.gz                                                                                      https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R1.fastq.gz                                                                                     https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R2.fastq.gz                                                                                     https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz                                                                                      https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R2.fastq.gz                                                                                      https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R1.fastq.gz                                                                                   https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R2.fastq.gz
  936  echo "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R1.fastq.gz
  937  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R2.fastq.gz                                                                                   https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R1.fastq.gz
  938  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R2.fastq.gz
  939  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R1.fastq.gz
  940  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R2.fastq.gz                                                                                     https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz
  941  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R2.fastq.gz
  942  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R1.fastq.gz
  943  https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R2.fastq.gz" > download_links.txt
  944  cat download_links.txt
  

  990  cat download_links.txt | xargs -i wget '{}'
  991  ls
  992  wget https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R2.fastq.gz
  993  wget https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R1.fastq.gz
  994  wget https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz
  995  mkdir fastq2
  996  mv *fastq*.gz. fastq2
  997  mv *fastq.gz* fastq2
  998  ls
  999  cat fastq2
 1000  ls fastq2
 1001  mkdir ref
 1002  cd ref
 1003  wget https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta
 1004  ls
 1005  cd ..
 1007  cd fastq2
 1008  ls
 1009  fastqc fastq2/*
 1010  fastqc
 1012  sudo apt install fastqc
 
  fastqc fastq2/* fastq.gz
 1024  cd fastq2
 1025  ls
 1026  multiqc
 1029  conda install multiqc
 1030  multiqc
 1031  cd ..
 1032  multiqc fastq2/*fastqc*
 1033  ls
 
 1042  touch trim.sh
 1043  ls
 1044  nano trim.sh
      !/bin/bash
mkdir trimmed_reads
SAMPLES=(
  "ACBarrie"
  "Alsen"
  "Baxter"
  "Chara"
  "Drysdale"
)

for SAMPLE in "${SAMPLES[@]}"; do

   fastp \
     -i "$PWD/${SAMPLE}_R1.fastq.gz" \
     -I "$PWD/${SAMPLE}_R2.fastq.gz" \
     -o "trimmed_reads/${SAMPLE}_R1.fastq.gz" \
     -O "trimmed_reads/${SAMPLE}_R2.fastq.gz" \
     --html "trimmed_reads/${SAMPLE}_fastp.html"
done
 1051  fastp
 1052  sudo apt install fastp
 1053  fastp
 1054  bash trim.sh
 1055  ls
 1056  ls trimmed_reads
 1057  cd trimmed_reads
 1058  ls

 1062  cd fastq2
 1063  fastqc trimmed_reads/* fastq.gz
 1064  cd trimmed_reads
 1065  ls


 1093  multiqc trimmed_reads/*fastqc*
 1094  cd trimmed_reads
cd ..
conda install bwa
touch alignment_map
conda install agbiome::bbtools
nano alignment_map
#!/bin/bash

# Define array of sample names
SAMPLES=("ACBarrie" "Alsen" "Baxter" "Chara" "Drysdale")

# Index the reference.fasta file
bwa index references/reference.fasta

# Create directories if they don't exist
mkdir -p repaired alignment_map results.sorted.bam

# Iterate over each sample
for SAMPLE in "${SAMPLES[@]}"; do
    # Run repair.sh on paired-end trimmed reads
    repair.sh in1="trimmed_reads/${SAMPLE}_R1.fastq.gz" \
              in2="trimmed_reads/${SAMPLE}_R2.fastq.gz" \
              out1="repaired/${SAMPLE}_R1_rep.fastq.gz" \
              out2="repaired/${SAMPLE}_R2_rep.fastq.gz" \
              outsingle="repaired/${SAMPLE}_single.fq"
    
    # Align repaired reads using BWA
    bwa mem -t 1 references/reference.fasta \
            "repaired/${SAMPLE}_R1_rep.fastq.gz" \
            "repaired/${SAMPLE}_R2_rep.fastq.gz" \
    | samtools view -b > "alignment_map/${SAMPLE}.bam"
    
    # Sort the alignment results
    samtools sort "alignment_map/${SAMPLE}.bam" \
                  -o "results.sorted.bam/${SAMPLE}.sorted.bam"

    # Index the sorted BAM file
    samtools index "results.sorted.bam/${SAMPLE}.sorted.bam"

    # Generate flagstat for the sorted BAM file
    samtools flagstat "results.sorted.bam/${SAMPLE}.sorted.bam" > "results.sorted.bam/${SAMPLE}.flagstat"
done

















































 



















































